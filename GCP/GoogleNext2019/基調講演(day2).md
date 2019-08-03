# 基調講演(day2)

* [YouTube](https://www.youtube.com/watch?v=PVCyiTLQrjQ)

* `Anthos`
    + https://cloud.google.com/anthos/?hl=ja
    + [クラウド移行支援ツールなどのアップデートを発表](https://japan.zdnet.com/article/35140691/)

## ファミリーマートのGSuite全社導入実績

+ 現場主義
    - 現場同士で書類・動画等のナレッジ共有
    - それに協力する組織を作る必要がある

+ 服装自由化、フリーアドレス等の取り組み
    - 問題が発生したら解決すればいいという方針

## GSuite

+ 経済効果
    - 一人当たりの節約/年 `-21日`
    - 情報漏洩のリスク削減 `95%`  等

+ Hangouts ChatがいろんなGSuiteツールの中で扱える
    - Gmailの中でチャット、Googleスライドの中でチャット
    - 別々のツールの中でコミュニケーションできる
    - 情報共有をシームレスに
    - 外部ビジネスユーザーをチャットメンバに追加できる

+ Voice
    - エンドユーザー向けクラウド通信サービス
    - 日本でサービス開始予定
    - 社員に電話番号を付与し、どのデバイスでも通話可能
    - 管理者はプロビジョニング、管理簡単に
    
## 日本商工会議所のGSuite導入

+ 生産性向上のためにITを使いたい中小企業
    - IT人材がいない, 資金がない, サーバーセキュリティ上の脅威

+ 中小企業に適したIT
    - 低コスト、専門知識不要、高いセキュリティ、使いやすさ

+ 世界は3つの三大要素技術のExponential Growthが変えていく
    - CPU, Storage, Network

+ 中小企業への取り組み
    + 全国中小企業クラウド実践大賞の開催等

## データのセキュリティ、プライバシーの保護

+ インフラとセキュリティにフォーカス

+ 5兆円以上を投資

+ お客様のデータはお客様のもの
    - Googleにおいては顧客データを宣伝や競争のために使うことはない
    - サードパーティに対して顧客データを提供したり、売ったりもない
    - アクセストランスペアレンシーログを提供
    
+ 包括的なセキュリティをデフォルトで実装
    - 全ての顧客データを保存中にデフォルトで暗号化

+ データ紛失を保護するためにDLP(Data Loss Prevention)ツールを提供
    - マイナンバー、銀行口座、免許証等が対象

+ `VPC Service Controls`により、リソースをセグメントし、データの盗み出しリスクが下がる
    - マネージドストレージ、データ処理サービス、プライベートクラウドのセキュリティ等の強みを組み合わせる

+ Anomaly Detection(new!)
    - ユーザビヘイビアにおいて異常を検知し、ドライブからのデータの盗取を防止
    - [公式](https://gsuiteupdates.googleblog.com/2019/07/anomaly-detection-gsuite.html)

### まとめ

+ 顧客がGoogleに預けているデータは顧客のものである
+ Googleは第三者に顧客データを決して販売しない
+ GoogleCloudは顧客データを広告に利用しない
+ 全ての顧客データはデフォルトで暗号化される
+ 内部でのユーザデータへのアクセスについても厳密に制限される
+ 政府にバックドア経由のアクセスを決して与えない
    + 国際基準に照らして監査されている

## 可視化とコントロール

+ `Cloud Security Command Center`(new!)
    - クラウド資産の単一のビューを提供する
        + 全てのディスクプロバイダ(VM, ストレージバケット, コンテナ)が対象
    - [公式](https://cloud.google.com/security-command-center/?hl=ja)

+ `Event Threat Detection`(new!)
    - Stackdriverのログを自動的にスキャンして、GCP環境の不審なアクティビティを発見
    - [公式](https://cloud.google.com/event-threat-detection/?hl=ja)

+ `Chronicle Backstory`(new!)
    - [Can I get the Backstory?](https://medium.com/chronicle-blog/introducing-backstory-45dd9b4d4a6d)
    - [公式ブログ](https://cloud-ja.googleblog.com/2019/07/the-security-moonshot-joins-google-cloud.html)
    - https://japan.cnet.com/article/35133676/

+ Chrome Book
    - OSパッチ必要ない、バックアップも心配しなくていい
    - 検証されたブート、ランサムウェアなどマルウェアから基本的に影響を受けない
    - FIDOセキュリティ
        - Titanセキュリティキー
        - アカウント不正利用の報告なし
        - 全世界での提供を目指す
        - 現在、日本、イギリス、フランス、カナダ
            - Googleストアなどで提供

* アンドロイド端末にセキュリティキー

* `Adbanced Protection Program`beta
    - セキュリティキーはこれの中核をなす
    - アカウントセキュリティの最強レベル
    - 管理者ユーザーを守るような設計
    - 例) 既存のオンプレ、或いはクラウドをAnthosに移行する
        ```
        Chromebook - Identity Aware Proxy - Anthos & Customer App
        ```
        - 全て組み込まれているAnthosのセキュリティを採用することになる
            - サービス用ID、セキュアな通信、構成管理、ログと監査
        - `Identity Aware Proxy`
            - DDoS保護、地球レベルのロードバランサーを得ることができる
            - CustomerAppにコンテキストアウェアなアクセスポリシーを設定できる
        - `Apigee API Platform`
            - 他のビジネスへサービスをエクスポートできる
            - Anthosは一元化された監査ログがあるので、BigQuery、EventThreatDetectionおよびChronicleにfeatし主要なインサイトが得られる

## Smart Analytics

+ アサヒビール
    - データウェアハウスのモダナイゼーション

+ RECRUIT
    - Hadoop, Spark環境をGCPへ移行し、拡張性・コスト効率を高める
    - アナリティクスをつかってリアルタイムデータからインサイトをえている

+ GoogleCloudのアナリティクスパートナー
    - SAP, alteryx, looker etc

## データサイロの解消

+ `Cloud Data Fusion`
    - フルマネージドでクラウドネイティブなデータ統合サービス
    - オープンソースの変換プラグインと100以上の事前構築済みコネクタを搭載
        - 様々なデータとフォーマットに対応
        - コーディングや準備作業から解放され、本当に必要な分析作業に集中できる
    - 例）オンプレミスなシステムにある出荷データ > BigQueryに移してデータ分析する
        ```
        Database -> Cloud Data Fusion -> BigQuery
        ```
        - DataFusionはこの作業を極めて簡単にする
    - データ変換を視覚的に
        - 数クリックでデータパイプラインをデプロイ
    - データの変換、移動を自動化
    
+ `BigQuery`
    - 世界中の組織がBigQueryを使用してデータを解析
    - 完全なサーバレス
    - インフラの管理ではなく本来の分析作業に集中
    - lookerなどのBIツール、ダッシュボードを引き続き利用できる
    
+ `Connected sheets`(beta 近日公開)
    - BigQueryのスケーラビリティをスプレッドシートでも(GSuiteの機能)
    - 通常のスプレッドシートでは解析は難しい
    - スプレッドシートの使いやすさと、BigQueryのスケーラビリティを両立させる
    - Connected sheets と BigQuery 上のデータが接続される
        - 数十億行のデータを扱える(グラフ、ピボットテーブルなど)
    - コラボレーション機能もあり、チーム間の共有が簡単

+ `AutoML Tables`
    - AIを便利に、シンプルに、高速に
    - だれもが容易に最先端のMLモデルを開発・運用することができる
        - MLの専門家を見つけるのは難しいという課題を解消
        - MLのエキスパートである必要も、SQL・テンサーフローコードを記述する必要もない
            - AutoMLが最良のモデルを見つけてくれる
    - MLを利用して「予測」、「分析」を短時間に完了させることができる

## アサヒビールのGCP利用例

+ 期待を超える価値のために
    - 様々なデータを活用して、市場ニーズ・変化よりも早く答えにたどり着く

+ Speed(Category Management System)
    - 様々なデータを活用して小売り向けに最適な棚割りを提案
    - 提案、データの準備、分析時間を大幅に削減、業務の効率化を実現
    
+ 技術の話
    - `BigQuery`
        - サーバーレスで使って分だけ
        - 10TB程度のrawデータを一瞬で処理(数時間 > 数分から数十分)
        - 誰もがデータに素早くアクセス
    - `GKE`
        - 処理をすべてマイクロサービス化(あらゆるジョブの実行管理にGKEを活用)
        - 市場ニーズ・変化に柔軟に対応可能
        - コンテナ導入で市場の一歩先に(コンテナ1つに対して追加修正するだけで、短期間で安価に機能やデータを追加していくことが可能)

## Hakuhodo DY HoldingsのGCP導入

+ 博報堂DYグループのデジタルトランスフォーメーションを推進

+ AudienceOne(Data Management Platform)を提供
    - 広告主のCRM、広告出稿のマーケティングの高度化等を支援
    - PCスマホのデータが中心 > 5Gなど、今後データの量が爆発的に増える

+ 技術の話
    - `CloudStorage`, `CloudDataflow`, `BigQuery`, `DataProtal`
    - デジタル広告ならではの対応必要性
        - 大量トラフィックにおけるキャパシティプランニング
        - サービス間のアプリケーションの依存関係やボトルネックの管理や可視化
        - マイクロサービス化による変化対応の強化
        - 新しい技術導入によるインフラ環境の高度化

## AIと機械学習

+ AIを企業の意思決定者のために

+ 3つすぐに使えるAIのソリューションを今年発表した
    - `Document Understanding AI`
        - ドキュメントを分析し、情報やインサイトを自動的に抽出
        - ビジネスプロセスをもっと楽に
    - `Recommendations AI`
        - リテール向けのソリューション
        - 一人ひとりに合わせた製品のおすすめ情報を様々な環境に応じて提供
    - `Contact Center AI`
        - 簡単な質問に対しては自動化
        - コンタクトセンターのエージェントに対してのレコメンデーションを提供
        - 大手の通信事業者とも統合されている

+ AIを開発する人のために
    + `Cloud AI Platform`
        - 今年発表
        - エンドツーエンドの開発環境をデータサイエンス向けに提供
    + `AI Hub`
        - AIコンテンツ向けのホステッドレポジトリ
    + `AutoML Tables`
    + `AutoML Video Intelligence`
    + `Cloud Vision API`
        - OCR, 200以上の言語をサポート, 表データの検出と抽出
    + `AutoML Video`
    + `AutoML Vision`

+ 導入企業
    - 三菱UFJ銀行、RECRUIT、DeNA、ebay、ZOZO Technologies, mercari
    - 利用することで最終的な売り上げを伸ばす
        - ビジネスの効率を向上
        - カスタマーエクスペリエンスの向上
            - カスタマーサービスの提供、関連するサジェスチョンを出す 等

## 保険業界

* 保険業界におこっているデジタルディスラプション
    + 自動車保険
        - 自動運転、シェアリング > MaaS
    + 火災保険
        - IoT、センシング、AI災害予測 > Smart xyz
    + 生命・医療保険
        - ウェアラブル、AI疾病予測 > Digital Health
    + 他業界
        - ブロックチェーン、NewRisks

* SOMPO Sprint(アジャイル開発チーム)
    +  -> Planning -> DailyScrum -> Retro-spective -> Review ->
    + シリコンバレースタイル
    + 2018年の成果) PoC:58 > In Production: 10
        - Digital Sandbox(保険証券自動解析ツール)
            - Cloud Vision APIを活用
            - 40秒で次年度保険料の見積もりが可能に
        - スマート介護システム
            - デバイス(設備)・センサ(バイタルとか)のデータをつなぐプラットフォームと、データ表示・以上通知アプリを開発
            - Firebase, Cloud Runを活用
            - SwaggerサーバーをCloud Run上で動作させ、多数のAPIインターフェースを共有

## インフラストラクチャのモダナイズと最適化

* イノベーション起こしながらアジリティだしたい、リスクやコストを下げたい
    + マイグレーション
    + モダナイゼーション
    + パフォーマンス

+ `Migrate for Compute Engine`
    - AWSやオンプレからVMsの移行
    - (new)AzureからVMsの直接移行

+ Google Cloudがvmwareのワークロードをサポート
    - vsphereベースのワークロードをGCP上で稼働できる
    - コンテナ、Anthos等様々な組み合わせ

+ `Traffic Director`
    - サービスメッシュのための機能
    - Anthos上で提供

+ `Layer 7 Internal Load Balancer`
    - 既存のアプリに手を加えることなくサービスメッシュ化/モダナイズ
    - うしろにTraffic Director, envoy(OSSのProxy)もついている

+ Intel Xeon スケーラブルプロセッサ
    - 40% パフォーマンスアップ

+ 6TB・12TBメモリ VMs SAP認定済み ベータ版提供開始
    - 可用性、セキュリティ、柔軟性が高い
    - ダウンタイムは大きな損失：(SAP)オンプレのサーバー1hダウンしただけで300万ドルの損失
        - インフラのアップデート、メンテナンス、セキュリティパッチ

+ ライブマイグレーション
    - 脆弱性発見 > 0ダウンタイムで動かし続けることができた
    - 可用性、セキュリティの同時確保
        - 使わない場合、トレードオフ