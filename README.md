# Gitリポジトリ同期

Gitをリポジトリ同期処理

<!-- TABLE OF CONTENTS -->
## Table of Contents

* [About the Project](#about-the-project)
  * [Built With](#built-with)
* [Getting Started](#getting-started)
  * [Prerequisites](#prerequisites)
  * [Installation](#installation)
* [Development](#development)
  * [PlantUML](#plantuml)
* [Acknowledgements](#acknowledgements)


## About The Project

TODO

### Built With

## Getting Started

### Prerequisites

* Python3.6
* VSCode

#### Pythonモジュール

* pipenv

```
$ pip install pipenv
```

### Installation

1. リポジトリのクローン
```sh
$ git clone https://bitbucket.org/aruhi_opekal/asses.git
```
3. Pythonモジュールのインストール
```sh
$ pipenv sync
$ pipenv sync --dev
```

<!-- DEVELOPMENT -->
## Development

実際の変換処理は[こちら](https://bigtree.backlog.jp/git/AST/salesforce-api/tree/master)で実装

### keyMapping

Salesforceのカラム名とDynamoDBのカラム名の対応付けを定義。

**keyMapping.json**
```json
{
  "SalesforceColumnName": ["DynamoDBColumnName_1", "DynamoDBColumnName_2"],
  ...
}
```
上記のようなマッピングであった場合、下記のように変換される。

**DynamoDB**
```json
{
  "DynamoDBColumnName_1": {
    "DynamoDBColumnName_2": "dummy"
  }
}
```
**Salesforce**
```json
{
  "SalesforceColumnName": "dummy"
}
```
#### 定数

値にリストではなく定数を定義すると、定数がそのまま変換後に定義される。

**keyMapping.json**
```json
{
  "SalesforceColumnName": "Constant"
  ...
}
```
**Salesforce**
```json
{
  "SalesforceColumnName": "Constant"
}
```
#### 関数

`Fn::Sum`という関数が定義されており、項目の和の連携が可能。

### valueMapping

オペカルでの値とSalesforceに連携する値の対応付けを定義。

**valueMapping.json**
```json
{
  "DynamoDBValue": "SalesforceValue",
  ...
}
```
上記のようなマッピングであった場合、下記のように値が変換される。

**DynamoDB**
```json
{
  "DynamoDBColumn": "DynamoDBValue"
}
```
**Salesforce**
```json
{
  "SalesforceColumn": "SalesforceValue"
}
```

<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements

TODO