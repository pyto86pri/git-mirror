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

2つのGitリポジトリを一方向的に同期するAPIを作成する。

Backlog Git → AWS CodeCommit → AWS CodePipeline

などのユースケースを想定。

Webhook機能を持つGitリポジトリがソースであれば適応可能。

一方向的であるため、逆方向には対応していない。

[カスタム AWS Lambda ランタイム](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/runtimes-custom.html)で実現。

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

## Acknowledgements

* 何もインストールされないのは正常です。

## Todo

* 複数リポジトリのWebhook拡張
  * リポジトリ間マッピングの保持
  * API Gateway → Kinesis Stream → Lambda