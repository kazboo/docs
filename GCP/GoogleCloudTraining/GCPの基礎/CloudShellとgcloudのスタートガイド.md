# Cloud Shellとgcloudのスタートガイド

* gcloudコマンドの使い方について実践しながら学ぶ
* Google Cloud Platformでホストされているストレージサービスに接続する

## コマンドラインの使用

* gcloudコマンドの実行時に末尾に`-h`フラグを付けると、gcloudに使用方法の簡単なガイドラインが表示される
    ```shell
    gcloud -h
    ```

* さらに詳細なヘルプを表示
    ```shell
    gcloud config --help
    ```
    ```shell
    gcloud help config
    ```

## ホームディレクトリの仕様

* Cloud Shellホームディレクトリのコンテンツは、仮想マシンを停止して再起動した後も、プロジェクトをまたいで全てのCloud Shellセッション間で保持される

* 現行作業中のディレクトリを変更する
    ```shell
    cd $HOME
    ```
    viを使って、.bashrc設定ファイルを開く
    ```shell
    vi ./.bashrc
    ```

## gcloudコマンドの使用

* 使用環境の構成リストを表示
    ```shell
    gcloud config list
    ```

* 他のプロパティの設定内容を確認するには、以下を実行して全てのプロパティを表示する
    ```shell
    gcloud config list --all
    ```

## Cloud Storageデータの管理

※ 日本ロケールで進めると、Qwiklabの進捗ステータスが緑にならなかった。チャットでサポートに問い合わせると、既知の問題で、ロケールを英語にするとすすめるのだそう。

* gsutil
    + Cloud Storageのリソースを管理できる

* バケットの作成
    ```shell
    gsutil mb gs://unique-name
    ```

* バケットにデータをアップロード
    ```shell
    gsutil cp test.dat gs://unique-name
    ```

* バケットの削除
    ```sh
    gsutil rb gs://unique-name
    ```

## 仮想マシンの作成

* `gcloud compute`でGCEリソースを管理しやすくなる
    + `instances create`で新しいインスタンスを作成
    ```sh
    gcloud compute instances create gcelab2 --machine-type n1-standard-2 --zone $ZONE
    ```

## 仮想マシンインスタンスへのSSH

* `gcloud compute ssh`
    ```sh
    gcloud compute ssh gcelab2 --zone $ZONE
    ```