# AWS_CLI_CONTAINER

# 前提条件
- Dockerfileをビルドできる環境
    - Docker Desktopなど

# 使い方
```
### ソースを取得します。
$ git clone https://github.com/yudozen/dop_c02_cloudformation.git
$ cd dop_c02_cloudformation

### 最小権限の原則にのっとったアクセスキーを`.env.secret`に指定します。
$ cp .env.secret.example .env.secret
$ vi .env.secret

### オリジナルのDockerイメージ名を必要に応じて編集します。
$ vi .env

### Dockerイメージを作成します。
$ make build

### AWSへの認証を確認します。
$ make test
```
