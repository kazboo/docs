# Compute Engine: Qwik Start - Windows

* 「ブートディスク」セクションで「変更」をクリックし、ブートディスクの構成を始める
    + Windows Server 2012 R2 Datacenter を選択し、「選択」をクリックする
    + その他の設定はすべてデフォルトのまま

## Windows の起動ステータスをテストする
 
* プロビジョニングが完了すると、「VMインスタンス」ページに緑色のステータスアイコン付きで表示される

* 全てのOSコンポーネントが初期化されるまでには時間がかかるため、RDP接続を受け入れる準備がまだできていない可能性がある

* CloudShellのターミナルから以下のコマンドで確認する
    ```sh
    gcloud compute instances get-serial-port-output instance-1 --zone us-central1-a
    ```

* 次の出力結果が表示されるまで、コマンドを繰り返し実行
    ```
    Finished running startup scripts.
    ```

## インスタンスに接続する

* 仮想マシンの名前をクリックする

* 「リモートアクセス」セクションで、「Windowsパスワードを設定」ボタンをクリックする
    + ユーザー名が生成される

* 「設定」をクリックし、このWindowsインスタンスのパスワードを作成する(完了まで数分かかる場合もある)

## Windows Serverにリモートデスクトップ(RDP)でアクセスする

* [Chrome RDP for Google Cloud Platform](https://google.qwiklabs.com/focuses/560?locale=ja&parent=catalog&qlcampaign=7c-jpac-20)拡張機能
    + ブラウザから直接RDPで接続できる
    + もちろん自身のWindowsからのアクセスも可能