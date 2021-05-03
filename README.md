# GTFS-RT for Python

## ディレクトリ構成

```text
├── Dockerfile          ：Dockerのイメージに関する設定
├── Makefile            ：makeコマンドの設定
├── README.md           ：はじめに読むドキュメント
├── docker-compose.yml  ：Dockerのイメージに関する設定
├── gtfs-realtime.proto ：GTFS-RTの設定(Protocol Buffers)
├── gtfs_rt_pb2.py      ：GTFS-RTの設定(Pythonに翻訳後)
└── main.py             ：メインファイル
```

## 環境構築

① `.env.sample` ファイルから `.env`ファイルを作成しパラメータを設定する

```bash
# 環境設定ファイルを複製
$ cp .env.sample .env
```

② 下記コマンドを実行し環境構築

```bash
# 環境構築コマンド(docker-compose build)
$ make build
```

③ 下記コマンドを実行しコンテナを起動

```bash
# 環境構築コマンド(docker-compose up -d)
$ make up
```

④ 下記コマンドを実行しコンテナに入る

```bash
# 環境構築コマンド(docker-compose exec python3 bash)
$ make exec
```

⑤ 下記コマンドを実行しpython実行

```bash
# 環境構築コマンド(python3 main.py)
$ make gtfs
```

## コマンド一覧

```bash
# ビルド
$ make build
# コンテナ起動
$ make up
# コンテナ内でコマンド実行
$ make exec
# GTFS-RTのファイル実行
$ make gtfs
```
