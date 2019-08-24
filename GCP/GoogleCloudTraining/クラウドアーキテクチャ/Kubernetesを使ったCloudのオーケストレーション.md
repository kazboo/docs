# Kubernetes を使った Cloud のオーケストレーション

## 準備

### GKE

```shell
# ゾーン設定
gcloud config set compute/zone us-central1-b
# クラスタ作成と起動(ioはクラスタ名)
gcloud container clusters create io
```

## Kubernetesのクイックデモ

* nginxコンテナのインスタンスを1つ起動する

    ```sh
    # KubernetesがDeploymentを1つ作成する
    $ kubectl create deployment nginx --image=nginx:1.10.0
    ```
    + ポッドが実行されているノードで障害が発生した場合でも、Deploymentはポッドを稼働状態に保つ
    + Kubernetesではすべてのコンテナがポッドで実行される

        ```sh
        # 実行中のnginxコンテナを表示する
        kubectl get pods
        ```

* nginxコンテナ稼働後、これをKubernetesの外部に公開できる

    ```sh
    kubectl expose deployment nginx --port 80 --type LoadBalancer
    ```
    + パブリックIPアドレスが関連付けられた外部ロードバランサが、Kubernetesによって背後で作成された
    + このIPアドレスをヒットするクライアントは、サービスの背後にあるポッド(nginxポッド)にルーティングされる

        ```sh
        # サービス一覧を表示する
        kubectl get services
        # アクセス可能
        curl http://<External IP>:80
        ```

* このように、Kubernetesはそのまま簡単に使用できるワークフローに対応している

## ポッド

* Kubernetesの中核

* ポッドは、1つ以上のコンテナのコレクションであり、コンテナを保持している
    + 一般に、互いに強い依存関係を持つコンテナが複数存在する場合、それらを単一のポッド内にパッケージ化する

* Pods
    + Logical Application
        - One or more containers and volumes
        - Shared namespaces
        - One IP per pod

* 例では、monolithコンテナとnginxコンテナを含むポッドがある

* ポッドにはボリュームが存在する
    + ボリューム
        - ポッドが存在する限り存続するデータディスク
        - そのポッド内のコンテナによって使用できる
    + ポッドは、そのコンテンツに対して共有の名前空間を提供する
        - 例にあるポッド内の2つのコンテナが互いに通信できる
        - 接続されたボリュームを共有できることを意味する

* ポッドはネットワーク名前空間も共有する
    + ポッドことに1つのIPアドレスがあることを意味している

### ポッドを作成する

* ポッドは、「ポッド構成ファイル」を使用して作成できる
    ```yaml
    apiVersion: v1
    kind: Pod
    metadata:
    name: monolith
    labels:
        app: monolith
    spec:
    containers:
        - name: monolith
        image: kelseyhightower/monolith:1.0.0
        args:
            - "-http=0.0.0.0:80"
            - "-health=0.0.0.0:81"
            - "-secret=secret"
        ports:
            - name: http
            containerPort: 80
            - name: health
            containerPort: 81
        resources:
            limits:
            cpu: 0.2
            memory: "10Mi"
    ```
    - このポッドは1つのコンテナ(monolith)で作成されている
    - コンテナの起動時に引数がいくつか渡されている
    - httpトラフィック用にポート80を開いている

* kubectlを使用してmonolithポッドを作成し実行
    
    ```sh
    $ kubectl create -f pods/monolith.yaml
    # デフォルトの名前空間で動作する全てのポッドを一覧表示
    $ kubectl get pods
    # monolithポッドに関する情報(ポッドのIPアドレス、ラベル、イベントログ等)をさらに取得する
    $ kubectl describe pods monolith
    ```

### ポッドの操作

## サービス

### サービスの作成

### ポッドにラベルを追加する

## Kubernetesでアプリケーションをデプロイする