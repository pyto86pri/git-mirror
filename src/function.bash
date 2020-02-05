TMP=/tmp

function log () {
    echo "$1" 1>&2
}

function urlencode() {
    local length="${#1}"
    for (( i = 0; i < length; i++ )); do
        local c="${1:i:1}"
        case $c in
            [a-zA-Z0-9.~_-]) printf "$c" ;;
            *) printf '%%%02X' "'$c" ;;
        esac
    done
}

function basic_auth_url () {
    echo "https://$(urlencode "$2"):$(urlencode "$3")@$(echo $1 | sed 's/https:\/\///')"
}

function handler () {
    EVENT=$1
    log "$(git --version)"
    log "$EVENT"
    xs=$(echo $EVENT | jq -r .Records[].kinesis.data | base64 -d)
    log "$xs"
    cd $TMP
    for x in "${xs[@]}"
    do
        y=( $x )
        SOURCE=$(basic_auth_url ${y[0]} $SOURCE_ID $SOURCE_PW)
        log "$SOURCE"
        TARGET=$(basic_auth_url ${y[1]} $TARGET_ID $TARGET_PW)
        log "$TARGET"
        _FOLDER="$(echo -n ${x[0]} | md5sum | awk '{print $1}')"
        log "$_FOLDER"
        if [ ! -e $_FOLDER ]; then
            git clone --mirror $SOURCE $_FOLDER
        fi
        cd $_FOLDER
        git fetch --all
        git push --mirror $TARGET
        cd $TMP
    done
    echo 0
}