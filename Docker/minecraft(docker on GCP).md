# Minecraftマルチ用サーバーをDocker+GCPで構築

Minecraftマルチ用サーバーをDocker+GCPで構築した。(GCPは1年間無料トライアル)
作業時間：ほぼ1日

* Minecraftマルチ用サーバーを構築
  * GCE(Google Compute Engine)
  * itzg/minecraft-server(Docker Hub)
    * Docker, Docker Compose

* SlackからGCEの起動/停止/状態確認できるようにする
  * slack(Slash Command)
  * GAE(Google App Engine)

* MinecraftのワールドデータをGCSにバックアップ
  * GCS(Google Cloud Storage)

* 通常かかる費用(月予測)
  * [料金計算ツール](https://cloud.google.com/products/calculator/?hl=ja)
  * GCE
    * 1 x minecraft
    * 91.25 total hours per month
    * VM class: regular
    * Instance type: g1-small
    * Region: Tokyo
    * Estimated Component Cost: JPY 321.53 per 1 month
  * GCS
    * Regional storage: 0.3 GB
    * JPY 0.76
  * GAE(standard environment instances)
    * [リソースの利用料金](https://cloud.google.com/appengine/pricing?hl=ja)
    * JPY 0
  * Total Estimated Cost: JPY 322.29 per 1 month 

## Minecraftマルチ用サーバーを構築

* 基本は以下のGCP公式を参考にした。
  * [Google Compute Engine での Minecraft サーバーのセットアップ](https://cloud.google.com/solutions/gaming/minecraft-server?hl=ja#header_1)
  * GCE
    * インスタンスをホストするゾーンは `asia-northeast1-a` を指定([リージョンとゾーン](https://cloud.google.com/compute/docs/regions-zones/?hl=ja#available))
    * ブートディスクは `Ubuntu 18.04 LTS`で`標準の永続ディスク`
    * `永続ディスクをインスタンスに追加` は実施しない

* Dockerで`itzg/minecraft-server`からMinecraftサーバーを構築
  * server.propertiesのパラメータはdocker-compose.ymlに記述
    ```yaml
    version: '2'
    services:
        minecraft-server:
            container_name: minecraft-server
            image: itzg/minecraft-server
            ports:
                - "25565:25565"
            tty: true
            stdin_open: true
            restart: always
            volumes:
                - ./data:/data
            environment:
                - EULA=TRUE
                - MAX_PLAYERS=2
                - WHITELIST=xxx,yyy
                - MAX_WORLD_SIZE=20000
                - VIEW_DISTANCE=8
    ```

* TODO: `インスタンスの作成` 設定時にコンテナ指定できるため、そちらで設定してみる

## SlackからGCEの起動/停止/状態確認できるようにする

* SlackのSlash Commandを利用する
  * 参考) http://mpiyok.hatenablog.com/entry/2017/12/10/094638
  * Token はVerification Tokenのこと。でもDeprecated。要対応。

* GAE
  * Go言語を使用
  * goコマンドを使用するため、msiでインストールしておく必要がある
    * https://cloud.google.com/appengine/docs/standard/go/building-app/creating-your-application?hl=ja
  * ディレクトリ構成
    + minecraft
      - app.yaml
      - ip.go
  * `https://{target-project}.appspot.com/minecraft` に対してリクエストする

* コマンド
  * `/minecraft up` : インスタンス起動
  * `/minecraft down` : インスタンス停止
  * `/minecraft status` : インスタンスの状況確認

## MinecraftのワールドデータをGCSにバックアップ

* 基本は以下のGCP公式を参考にした。
  * [Google Compute Engine での Minecraft サーバーのセットアップ](https://cloud.google.com/solutions/gaming/minecraft-server?
  * 特に必要ないとおもったので、「ワールドデータの現在の状態を保存した後、サーバーの自動保存機能を一時停止」は実施しない
  * backup.shを作成し、crontabでcron登録
    * crontab) https://www.server-memo.net/tips/crontab.html
    * `00  23  *  *  5,0` (金、日の23:00)

* backup.sh
    ```sh
    #!/bin/bash

    tar -zcvf world.tar.gz -C /home/kaz_orita/docker/minecraft/data world
    /snap/bin/gsutil cp -R ./world.tar.gz gs://minecraft-k2-world-backup/$(date "+%Y%m%d-%H%M%S")-world.tar.gz

    rm ./world.tar.gz
    ```

* 古いバックアップを自動的に削除する
  * GCP Consoleからオブジェクトのライフサイクル管理
  * 1週間で削除する