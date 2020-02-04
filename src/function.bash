FOLDER=repo

function handler () {
    EVENT=$1
    echo $(git --version)
    cd $TMP
    if [ ! -e $FOLDER ]; then
        git clone --mirror $SOURCE $FOLDER
    fi
    cd $FOLDER
    git fetch --all
    git push --mirror $TARGET
    echo 0
}