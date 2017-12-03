# CentOSインストール

学習用CentOSのインストール

## 環境

* Docker
  * 本書と違いDockerToolsを使用してみ
* CentOS Linux 7 (Core)
  * /etc/os-release

## Docker Imageの取得

CentOSの最新バージョンを取得

```
docker pull centos:latest
```

取得したイメージの確認

```
docker images
```

## コンテナ（仮想マシン）を起動

取得したコンテナは`docker run`で起動する

* 「centos」というコンテナで`/bin/echo ok` というコマンドを実行する
```
docker run centos /bin/echo ok
```

* 起動したコンテナに入る
```
docker run -i -t centos /bin/bash

exit # 抜けるとコンテナは終了する
```

* コンテナを起動したままにしておく
```
docker run -i -t -d centos /bin/bash
```
もしくは
```
docker run [CONTAINER]
```
起動しているコンテナを確認
```
docker ps
```

## コンテナに接続する

```
docker attach [CONTAINER]
```

`ctrl+p ctrl+q`で接続したコンテナから抜ける  
`exit`するとコンテナを終了する

## コンテナを停止する

```
docker stop [CONTAINER]
```

## net-tools

* yumでインストール

``` cmd
yum isntall net-tools
```

## 参考

* <https://qiita.com/voluntas/items/68c1fd04dd3d507d4083>