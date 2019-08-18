# Kubernetes Engine: Qwik Start

* Google Kubernetes Engine(GKE)
    + Googleのインフラを使用
    + 「コンテナ化されたアプリケーション」の「デプロイ、管理、スケーリング」を行うマネージド環境を提供する

* GKE環境は複数のGCEインスタンスで構成されている
    + これらのマシンが`グループ化`されて[コンテナクラスタ](https://cloud.google.com/kubernetes-engine/docs/concepts/cluster-architecture)を形成する

* クラスタは少なくとも、１つの[クラスタマスター](https://cloud.google.com/kubernetes-engine/docs/concepts/cluster-architecture#master)と[ノード](https://cloud.google.com/kubernetes-engine/docs/concepts/cluster-architecture#nodes)と呼ばれる１つ以上複数のワーカーマシンで構成される

* クラスタマスターとノードマシンがKubernetesクラスタのオーケストレーションを実行する
    + クラスタマスター
        - Kubernetes API サーバー、スケジューラ、コアリソース コントローラといった Kubernetes コントロール プレーンのプロセスを実行します
        - マスターのライフサイクル管理は GKE が行う
        - マスターは、クラスタの統合されたエンドポイント
            - クラスタのすべての操作は Kubernetes API 呼び出しを経由して実行される
            - マスターでは Kubernetes API サーバー プロセスを実行してこれらのリクエストを処理
        - 
    + ノード
        - コンテナ化されたアプリケーションや他のワークロードを実行するワーカーマシン

* Kubernetes API 呼び出し
    + HTTP/gRPC を使用して直接行うこともできる
    + 間接的にも可能
        - Kubernetes コマンドライン クライアント（kubectl）からコマンドを実行する
        - GCP Console で UI を操作する

* クラスタ マスターの API サーバー プロセス
    + クラスタのすべての通信のハブとなります
    + すべての内部的なクラスタ プロセス（クラスタノード、システムとコンポーネント、アプリケーション コントローラなど）は、API サーバーのクライアントとして機能
    + API サーバーはクラスタ全体の信頼できる唯一の情報源となる

* クラスタはGKEの基盤であり、コンテナ化されたアプリケーションを表す`Kunernetesオブジェクト`は全てクラスタ上で実行される

## Kubernetes Engineによるクラスタオーケストレーション

* [Kubernetes](https://kubernetes.io/)オープンソースクラスタ管理システムを利用する
    + コンテナクラスタを操作するメカニズムを提供する