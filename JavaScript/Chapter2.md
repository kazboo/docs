# 2 基本的な書き方を身に着ける

## 2.1 JavaScriptの基本的な記法

## 2.1.1 JavaScriptで「こんにちは、世界!」

* サンプル参照
* UTF-8は国際化対応にも優れ、HTML5をはじめとしたさまざまな技術で推奨される文字コード
  * その他の文字コードはAjax通信で外部サービスと連携する際、思わぬ不具合、文字化けの原因になる

## 2.1.2 javaScriptをHTMLファイルに組み込む - script要素

* JavaScriptのコードをHTMLファイルに組み込む
  ```html
  <script type="text/javascript">
  // JavaScriptのコード
  </script>
  ```
  HTML5では`text/javascript`がデフォルトになっているため省略可

* script要素を記述する場所
    1. body要素の配下(任意の位置)
      * script要素での処理結果をページに直接出力するために利用する
      * コンテンツとコードが混在するのは、可読性/保守性の観点からのぞましくない
      * 現在ではほぼ使われない(例外を除いて使うべきでない)
    1. body要素の配下(body閉じタグの直前)
      * ページ高速化の手法として末尾に配置(見た目の描画速度が改善する)
        * 一般的なブラウザはスクリプトの読み込みや実行が完了するまで以降の描画を行わない
        * 読み込み・実行に時間がかかるスクリプトはそのままページ描画の遅れに直結する
      * 一般的に、JavaScriptによる処理はページがすべて準備できてから行うべきものであるはずなので弊害もほぼない
    1. head要素の配下
      * (2)で賄えないケース
      * JavaScriptでは関数を呼び出すためのscript要素よりも、関数定義のscript要素を先に記述していなければならない  
        (関数定義、呼び出しが一つのscript要素にまとまっていてもかまわない)
      * body配下で直接呼び出すための関数を定義したい
        ```html
        <head>
          <script>
          function sample() {}
          </script>
        </head>
        <body>
          <a onClick="sample()">Sample</a>
        </body>
        ```

* (2)を基本とし、まかえないときだけ(3)を利用する
  * (1)は外部のウィジェットを埋め込むなどの状況除けばほとんどない
  * https://qiita.com/mikimhk/items/7cfbd6c94d0f3d7aa51f

* 外部スクリプトをインポートする
  ```html
  <script type="text/javascript" src"path" charset="encoding">
  // path: スクリプトファイルへのパス
  // encoding: スクリプトファイルで利用している文字コード
  </script>
  ```

* コード外部化のメリット
  * レイアウトとスクリプトを分離することで、コードを再利用しやすくする
  * スクリプトを外部化することで、htmlファイルの見通しがよくなる  

* 本格的なアプリ開発ではできる限りJavaScriptは外部ファイル化するべき
  * コード部分が非常に短いなどのケースで、外部化したほうがかえって記述が助長になることもある
  * 状況に応じてページインラインでの記法を使い分ける

* 外部スクリプトとインラインスクリプトを併用する場合の注意点
  * 以下のような書き方はできない
    ```html
    <script type="text/javascript" src="lib.js">
    window.alert("hello, world");
    </script>
    ```
  * src属性を指定した場合、script要素配下のコンテンツは無視されるため
    ```html
    <script type="text/javascript" src="lib.js"></script>
    <script>
    window.alert("hello, world");
    </script>
    ```

* JavaScript機能が無効の環境で代替コンテンツを表示させる
  ```html
  <noscript>...</noscript>
  ```
  * 本来、JavaScriptが動作してない場合でも必要最低限のコンテンツを閲覧できるようにデザインするべき
  * JavaScriptに依存せざるを得ない場合には、有効にしたうえでアクセスしてほしい旨をメッセージ表示する

* JavaScript疑似プロトコル
  * アンカータグのhref要素にスクリプトを埋め込む
  ```html
  <a href="JavaScript:window.alert('Hello World.');">リンクテキスト</a>
  ```

* そのほか、特定の要素に対してイベントハンドラーとしてスクリプトを埋め込む方法もある
