# Gitリポジトリ同期API

## Table of Contents

* [About the Project](#about-the-project)
  * [Built With](#built-with)
* [Getting Started](#getting-started)
  * [Prerequisites](#prerequisites)
  * [Installation](#installation)
* [Package](#package)
* [Acknowledgements](#acknowledgements)


## About The Project

Backlog Gitリポジトリから一方向的に他リポジトリにミラーリングするAPI。

[Backlog Git Webhook](https://support-ja.backlog.com/hc/ja/articles/360036145053)からキックされることを前提としている。

Backlog Git → Bitbucket → CircleCI

などのユースケースを想定。（BacklogはCIツールとの相性が悪いため）

一方向的であるため、完全な同期はできない。

[Backlog Git Webhook IPアドレス](https://support-ja.backlog.com/hc/ja/articles/360035645534-Webhook-%E3%82%B5%E3%83%BC%E3%83%90%E3%81%AE%E6%83%85%E5%A0%B1)以外からのリクエストを受け付けないようにし、セキュリティを担保。

[カスタム AWS Lambda ランタイム](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/runtimes-custom.html)(Shell)で実装。

API Gateway → Kinesis Stream → Lambda

の構成にすることで、高可用性を実現。

Kinesis StreamのBatch SizeやShard Countを増やすことで、スループットを上げることが可能。

### Usage

利用時は、Backlog GitリポジトリのWebフックURLに以下を設定。

https://******.execute-api.******.amazonaws.com/v1/${ターゲットリポジトリのURL}

* ターゲットリポジトリのURL：ターゲットリポジトリのURLをURLエンコードした値
  * 例："https://bigtree.backlog.jp/git/AST/git-mirror.git" → "https%3A%2F%2Fbigtree.backlog.jp%2Fgit%2FAST%2Fgit-mirror.git"

### Built With

* [pahud/sam-cli-docker](https://github.com/pahud/sam-cli-docker)
* [gkrizek/bash-lambda-layer](https://github.com/gkrizek/bash-lambda-layer)

## Getting Started

### Prerequisites

* [Docker](https://www.docker.com/)
* [make](https://www.tutorialspoint.com/unix_commands/make.htm)
* [bats](https://github.com/sstephenson/bats)

### Installation

```sh
$ make install
```

## Test

```sh
$ make test
```

## Package

```sh
$ BUCKET=${BUCKET} make package
```

## Deploy

```sh
$ STACK_NAME=${STACK_NAME} make deploy
```

## Acknowledgements

* 何もインストールされないのは正常です。

## Todo