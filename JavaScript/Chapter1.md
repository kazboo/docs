# イントロダクション

## 1.1 JavaScriptとは

* Netscape Communications社によって開発されたブラウザ向けスクリプト言語  
  LiveScriptと呼ばれていたが、注目を浴びていたJava言語にあやかって改名(別言語で互換性もない)

* 1995年にNetscape Navigator2.0で実装された

* 1996年にはIE3.0でも実装され、ブラウザ標準のスクリプト言語として定着

* その後20年でChrome, Firefox, Safari, MS Edgeなど主要なブラウザで実装される

### 1.1.1 JavaScriptの歴史

* 1990年代後半は初期JavaScriptの全盛ともいえる時代
  * 過剰な装飾をJavaScriptで盛り込んでいった結果、ダサいページが量産されることになった
  * 早い段階で廃れ、「ダサいページを作成するための言語」「素人が使う低俗な言語」というイメージが定着
  * ブラウザベンダーが個々にJavaScriptの実装を拡張していた時代「より目立つ、派手な機能を」
    * ユーザーは置き去り
    * ブラウザ間の仕様差（クロスブラウザ問題）だけが広がっていく
    * セキュリティホールが断続的に見つかる
  * 不遇の時代

### 1.1.2 復権のきっかけはAjax、そしてHTML5の時代へ

* 2005年、Ajax(Asynchronous JavaScript + XML)の登場  
  ブラウザ上でデスクトップアプリライクなページを作成するための技術

* ブラウザ標準の技術(HTML, CSS, JavaScript)だけでリッチなコンテンツを作成できることからAjax技術は瞬く間に普及する
  * この頃にはブラウザベンダによる機能拡張合戦も落ち着き、互換性の問題が減少する

* 国際的な標準化団体(ECMA International)の下、JavaScriptの標準化がすすめられる

* Ajax技術の普及により、HTML/CSSの表現力を傍らで補うだけの簡易な言語ではなくなる
  * Ajax技術を支える中核
  * プログラミングの手法も、大規模な開発に耐えるためオブジェクト指向的な書き方を求められる  
    ※以前は関数を組み合わせるだけの簡易的な手続き的な記法

* さらにHTML5の登場により追い風（ブラウザのネイティブな機能だけで実現できる範囲が格段に広がる）
  * マークアップとしての充実に加え、アプリ開発のためのJavaScript APIを強化した
  * HTML5で追加された主なJavaScript API
    * Geolocation API  
      ユーザーの地理的な位置を取得
    * Canvas
      JavaScriptから動的に画像を描画
    * File API
      ローカルのファイルシステムを読み書き
    * Web Storage
      ローカルデータを保持するためのストレージ
    * Indexed Database
      キー/値のセットでJavaScriptのオブジェクトを管理
    * Web Workers
      JavaScriptをバックグラウンドで並列実行
    * Web Sockets
      クライアント・サーバー間の双方向通信を行うためのAPI

* ブラウザネイティブなJavaScriptの人気に拍車
  * スマホ/タブレット普及によるRIA(Rich Internet Application)技術(Flash/Silverlishtなど)の衰退
  * SPA(Single Page Application)の流行

* SPA
  * 単一のページで構成されるWebアプリ
  * 初回アクセスはページ全体を取得
  * 以降のページ更新は基本的にJavaScriptでまかなう
  * まかないきれない、データの取得/更新などはAjaxなどの非同期通信を利用して実装する
  * デスクトップアプリによく似た操作性・敏速な動作を実現するためのアプローチとして注目を浴びる

### 1.1.3 マイナスイメージの誤解

* そのほとんどがイメージ先行型の誤解でもあった

* 「JavaScriptは素人向けの簡易なだけの言語」というのは大間違い
  * れっきとしたオブジェクト指向言語

* 「JavaScriptにはセキュリティホールが多い」という誤解
  * JavaScriptの問題ではなく、JavaScriptを実装するブラウザの問題
  * 昨今ではベンダのセキュリティ意識も高まり、JavaScriptにかかわるセキュリティホールは減少しつつある

* 「JavaScriptにはクロスブラウザ問題があるので、開発生産性が低い」という誤解
  * これもブラウザ実装の問題
  * 標準化の流れの下で、互換性問題は軽減されつつある

* JavaScriptは手軽に導入でき、かつ十分に普及しているという意味で、初学者が学習するのに適した言語であるといえる

### 1.1.4 言語としての４つの特徴

* 1) スクリプト言語である
  * プログラムの記述や実行を比較的簡易に行うことができる言語の総称
  * オブジェクト指向的な構造も持ち合わせていて、再利用性・保守性に富んだコードも記述しやすいつくりになっている

* 2) インタプリター型の言語である
  * おおくのスクリプト言語はインタプリタ型である
  * プログラムを先頭から逐一解析し、コンピュータに理解できる形式に翻訳しながら実行していく言語のこと
  * このためコンパイル型に比べると動作が遅いが、コンパイルのような特別な手続きがなく、実行までの手間がかからない

* 3) 様々な環境で利用できる
  * JavaScriptはもともとブラウザ上で動作することを想定して作られたが、その用途にとどまらない
  * JavaScript(ECMAScript)をベースとして作られた言語が様々な環境で動作している
    * Node.js: サーバーサイド用途を中心としたJavaScript実行環境
    * Windows Script Host: Windows環境のスクリプト実行環境
    * Java Platform, Standard Edition: Java言語の実行環境
    * Android/iOS(WebView): Webページを表示するための組み込みブラウザ

* 4) いくつかの機能から構成される
  * コアJavaScript(~Chp.5)
    環境に依存しない、JavaScriptの言語としての標準的な機能を提供する部分
  * DOM(Document Object Model)(Chp.6)  
    JavaScript以外の言語からもドキュメントを動的に操作できる汎用的な仕様
  * ブラウザオブジェクト(Chp.7)
    ブラウザ上での操作をJavaScriptから制御するための機能

## 1.2 次世代JavaScript「ECMAScript2015」とは

* ECMAScript
  * 標準化団体ECMA Internationalによって標準化されたJavaScript
  * 最新版は2015年6月に採択された第6版ECMAScript 2015(ES2015)
    * [ECMAScript 2019](https://qiita.com/tonkotsuboy_com/items/07f8ef98abf89250b90c)
  * 版数から、ECMAScript 6(ES6)と呼ばれることもある

* ES2015で提供された主な仕様
  * `class命令の導入で、Java/C#ライクなクラス定義が可能に`
  * import/export命令によるコードのモジュール化をサポート
  * 関数構文尾改善(アロー関数、引数のデフォルト値、可変長引数など)
  * let/const命令によるブロックスコープの導入
  * for...of命令による値の列挙
  * イテレーター/ジェネレータにより列挙可能なオブジェクトの操作が可能に
  * 組み込みオブジェクトの拡充(Promise, Map/Set, Proxy etc)
  * String/Number/Arrayなど、既存の組み込み王ジェクトも機能を拡張

* ES5以前の文法も学びつつ、差分としてES2015の新文法を理解していくべき
  * ES5はほとんどのブラウザが対応している

### 1.2.1 ブラウザーの対応状況

* [ECMAScript 6 compatibility table](http://kangax.github.io/compat-table/es6)
  * Firefox, Chrome, Edge等のブラウザが9割以上の対応率である反面、IE11では2割り未満、Safariが5割強

* 現時点でES2015を利用するには、トランスコンパイラーのお世話になる
  * ES2015のコードをES5仕様のコードに変換するためのツール
  * [Babel](https://babeljs.io)

## 1.3 ブラウザー付属の開発者ツール

* JavaScript/スタイルシートでの開発には欠かせない強力なツール

### 1.3.1 開発者ツールを起動する

* Chrome
  * デベロッパーツール
  * `Elements` HTML/CSSの状態を確認
  * `Network` ブラウザで発生した通信を走査
  * `Sources` スクリプトのデバッグ(ブレイクポイントの設置&変数の監視など)
  * Timeline パフォーマンスを計測
  * Profiles JavaScriptで使用しているCPU/メモリなどの情報を収集
  * `Application` クッキー/ストレージなどの内容を確認
  * Audits ページを分析し、最適化のためのヒントをリスト表示
  * `Console` コンソール(変数情報の確認、エラーメッセージの表示など)

### 1.3.2 HTML/CSSのソースを確認する - Elementsタブ

* HTMLのソースをツリー表示できる
  * 「ソースを表示」とは違って、JavaScriptで動的に操作された結果が反映されているため、実行結果の確認に有効
  * 最終的なスタイルの調整にも便利

### 1.3.3 通信状況をトレースする - Networkタブ

* ブラウザ上で発生した通信を確認できる
  * 正しいリクエストがなされているのか、意図したデータを受信できているのかを確認しやすくなる

* Timelineタブで表示のボトルネックとなっている要素を特定するためにも利用できる

### 1.3.4 スクリプトをデバッグする - Sourcesタブ

* ブレイクポイントを設置可能

* 圧縮されたコードを整形する
  * Sourses タブ下の`{}`(Pretty print)ボタンをクックすることで、コードを改行・インデント付きの形式に整形可能

### 1.3.5 ストレージ/クッキーの内容を確認する - Applicationタブ

* 現在のページを構成するファイルのほか、ストレージ/クッキーを確認できる
  * リストから値を追加・編集・削除することも可能

* Application タブはChrome51以前では Resources タブと表記されていたもの

### 1.3.6 ログ確認/オブジェクト操作などの万能ツール - Consoleタブ

* 大きく2つの役割がある
  * 1) エラーメッセージやログを確認する
    * 1つにエラーメッセージやログの確認
    * console.logメソッドで出力したログ情報もコンソールで表示できる
      * Sourcesタブを利用するまでもない場合など
  * 2) 対話的にコードを実行する
    * コンソール上から対話的にJavaScriptを実行できる
    ```txt
    > document.getElementById('elem')
        <div id="elem">クリックすると背景色が変わります。</div>
    >
    ```

* JavaScriptを学ぶ上で役立つサイト
  * [Mozila Developer Network(MDN)](https://developer.mozilla.org/ja/JavaScript)
    * チュートリアルから、オブジェクトに関するリファレンスが網羅されたサイト
    * 可能であれば英語版を参照することをおすすめする(和訳版と内容が食い違っている場合がある)
  * [jQuery逆引きリファレンス](http://www.buildinsider.net/web/jqueryref)
  * [jQueryUI逆引きリファレンス](http://www.buildinsider.net/web/jqueryuiref)
  * [jQuery Mobile逆引きリファレンス](http://www.buildinsider.net/web/jquerymobileref)
  * [HTMLクイックリファレンス](http://www.htmq.com/)
  * [ECMAScript 2015 Language Specificaiton](http://www.ecma-international.org/ecma-262/6.0)
    * ECMAScript仕様書