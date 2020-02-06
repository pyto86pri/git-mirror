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

@test "basic_auth_urlテスト" {
    run basic_auth_url 'https://dummy.git' 'dummy' '"#$%&=~^|\`@{[}]*:+;<,>.?/'

    [ "${status}" -eq 0 ]
    [ "${output}" -eq 'https://dummy:%22%23%24%25%26%3D~%5E%7C%5C%60%40%7B%5B%7D%5D*%3A%2B%3B%3C%2C%3E.%3F%2F@dummy.git' ]
}