TMP=tmp
SOURCE=source.git
TARGET=target.git

load ../src/function

setup() {
    mkdir "$TMP"
}

teardown() {
    rm -rf "$TMP"
}

git() {
    if [ "$1"="clone" ]; then
        mkdir "$4"
    fi
    echo "git $1"
    return 0
}

@test "handlerテスト" {
    run handler

    [ -e $TMP/repo ]
    [ "${status}" -eq 0 ]

    run handler

    [ "${status}" -eq 0 ]
}