# レスポンシブWebデザインのページを作成しよう

## レスポンシブWebデザインとは

* 同じ1枚のHTMLでスマートフォンでもパソコンでも、画面サイズに合わせて最適なレイアウトで表示する

### レスポンシブWebデザインを実現するテクニック

* フルーイドデザイン
* メディアクエリ/ブレイクポイント
* 伸縮する画像の表示
  ```html
  <head>
  <style>
  .img-responsive {
      display: block;
      max-width: 100%;
      height: auto;
  }
  </style>
  </head>
  <body>
      <img
        src="../images/img0148.jpg"
        width="904"
        height="572"
        alt="陽が沈む"
        class="img-responsive">
  </body>
  ```

### フルーイドデザイン(Fluid Design)

* ウィンドウ/画面サイズに合わせてページの幅を伸縮させる様に作られたデザイン
  * ボックスのサイズを極力固定しない

* 伸縮が苦手な機能(タグ)
  * フォーム部品
  * フロート
  * テーブル
  * ブロックボックス全般

* 伸縮が得意な機能(タグ)
  * フレックスボックス
  * box-sizing:border-box;

### メディアクエリ(Media Queries)

* ある条件を満たしたときだけ適応されるCSSを作ることができる
  ```css
  @media screen and (min-width: 768px) {
    .content {
      fload: left;
    }
  }
  ```

* 囲まれていない部分はどんな端末にも無条件で適用される
  * 共通する「ベースデザイン」

* `モバイルファーストCSS`
  * ベースデザインでまずスマートフォン向けのデザインを完成させる
  * その後メディアクエリで画面幅の広い端末向けデザインを追加する手法
  * 現在の主流
    * 全体の記述量が減り管理もしやすい
      ```css
      .home-course {
        display: flex;
        flex-flow: column;
      }
      .home-course li {
        flex: 1 1 auto;
        margin: 0 2px 4px 2px;
        border: solid 5px #fff;
        list-style-type: none;
        background: #fff;
      }
      @media screen and (min0width:768px) {
        .home-course {
          flex-flow: row;
        }
      }
      .home-course a{
        color: #393939;
        text-decoration: none;
      }
      ```

* `デスクトップファーストCSS`
  * 古いブラウザに対応するためなどの理由で以前は主流だった

### ブレイクポイント

* デザインを切り替える画面幅のこと
  * メディアクエリのmin-width:`oo`pxのoに入る数値
  * 標準的な端末の画面幅に合わせて設定するのが基本
    * 小：768px
    * 中：980px ~ 1000px
    * 大：1200px
  * サイトデザインによっては、見た目の印象が良いところに試行錯誤で置く場合もある
  * (小)より小さい場合はシングルコラム、大きい端末は2コラムレイアウトで表示する等
  * 標準的なサイズのタブレットには、原則としてパソコンと同じデザインで表示が好まれる
    * それ以外のブレイクポイントはデザインの微調整に使うことが多く、(小)よりは重要でない
    * [Googleウェブマスター向け公式ブログ](https://webmaster-ja.googleblog.com/2012/11/giving-tablet-users-full-sized-web.html)
  
## レスポンシブWebデザインのサイトを作る

### 作成するページの概要

* レスポンシブWebデザイン
* ブレイクポイント：768px
* 横幅上限：1000px
* IE11以降に対応
* 基本的なレイアウトにはフレックスボックス
* 1ページにつき1つのフォルダを作る
  * 画像フォルダはルートにまとめる(サイト規模が小さいため)
  ```txt
  /
  + contact/ - index.html
  + course/ - index.html
  + qanda/ - index.html
  + css/ - main.css
  + images/ + a.png
  |         + course-wordpress-big.png
  |         :
  |
  + script/ - script.js
  + template/ - index.html
  + apple-touch-icon.png
  + favicon.ico
  + index.html
  ```

### 各ページに共通する基礎部分のHTMLを作成する

* まずトップページから作成する
  * HTMLの基礎部分と、各ページで共通する`<head>~</head>`の部分
  ```html
  <!DOCTYPE html>
  <html lang="ja">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- ファビコン(パソコン向け) -->
    <link rel="shortcut icon" href="/favicon.ico">
    <!-- ファビコン(スマートフォン、タブレット向け) -->
    <link rel="apple-touch-icon" href="/apple-touch-icon.png">
    <meta naem="description" content="子供から大人まで、プログラミングを学ぶならCodera">
    <title>プログラミングスクール</title>
    <link rel="stylesheet" href="css/normalize.css">
    <link rel="stylesheet" href="css/main.css">
  </head>
  <body>
  </body>
  </html>
  ```

* ファビコンの設定
  * ブラウザのアドレスバーやブックマーク等に表示されるアイコン
  * AndroidやiOSの場合は、ブックマークをホーム画面に登録するときのアイコンとしても使われる
  * ico形式 > 作成にはウェブサービスを使うとよい
  * 端末・用途に合わせてサイズ別に作る(最大20)こともできるが、追加作業が手間であり効果も低い

### シングルコラムレイアウトとナビゲーションを組み込む

* 基礎部分ができたら、`<body>~</body>` の部分を作成する
* 完成図をみて、骨格となる大まかなレイアウトの構造と、共通化できる部分を探す
  * ヘッダー、フッターは明らかに共通する
* メイン部分は場所によってコラム数が変わっているが、基本的には「シングルコラム」と考えてよい
* ヘッダーとナビゲーション、フッター、シングルコラムのメイン部分まで作成する
* トップページを作りこむ前にHTMLをコピーし、他のページで使うテンプレートを作成する方針で進める
  ```html
  <!DOCTYPE html>
  <html lang="ja">
  <head>
    ...
  </head>
  <body>

    <header>
      <div class="container header-container">
        <div class="header-inner">
          
        </div>
      </div>
    </header>

    <nav>
      <div class="container nav-container">
        <ul class="navbar">
          <li>
            <a href="./index.html">ホーム</a>
          </li>
          <li>
            <a href="course/index.html">コース紹介</a>
          </li>
          <li>
            <a href="qanda/index.html">よくある質問</a>
          </li>
          <li>
            <a href="contact/index.html">お申込み</a>
          </li>
        </ul>
      </div>
    </nav>

    <section class="main">
      <div class="container">
        <main>

        </main>
      </div>
    </section>

    <footer>
      <div class="container footer-container">
        
      </div>
    </footer>

    <script src="script/script.js"></script>

  </body>
  </html>
  ```
  ```css
  @charset "utf-8";

  /**
   * 全て共通
   */
  html, body {
    font-size: 16px;
    font-family: sans-serif;
    color: #393939;
    background: #efefef;
  }
  body, div, p, h1, h2, h3, h4, ul, figure {
    margin: 0;
    padding: 0;
  }
  p, td, th, li {
    line-height: 1.8;
  }
  img {
    width: 100%;
    height: auto;
  }
  a {
    color: #709a00;
  }
  a:hover {
    color: #95cd00;
  }
  a:active {
    color: #4b6700;
  }
  .img-responsive {
    display: block;
    max-width: 100%;
    height: auto;
  }

  /**
   * 共通の見出し
   */
  main h1 {
    margin-bottom: 1rem;
    border-bottom: 1px dashed #c84040;
    font-weight: normal;
    font-size: 1.6rem;
  }

  .container {
    margin: 0 auto;
    padding-left: 10px;
    padding-right: 10px;
    max-width: 1000px;
  }
  @media screen and (min-width: 768px) {
    .container {
      padding-left: 20px;
      padding-right: 20px;
    }
  }

  /**
   * ヘッダー
   */
  header {
    background: #c84040;
  }
  .header-inner {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  /**
   * ナビゲーション
   */
  nav {
    background: #393939;
  }
  .navbar {
    display: none;
    list-style-type: none;
  }
  .navbar a {
    display: block;
    padding: 0.6rem 0;
    color: #fff;
    text-decoration: none;
  }
  .navbar a:hover {
    background: #c84040;
  }
  @media screen and (min-width: 768px) {
    .navbar {
      display: flex !important;
    }
    .navbar li {
      flex: 1 1 auto;
      text-align: center;
    }
    .navbar a.nav-current {
      background: #c84040;
    }
  }

  /**
   * メインエリア基本レイアウト
   */
  main {
    padding-top: 50px;
    padding-bottom: 50px;
    background: #efefef;
  }
  @media screen and (min-width: 768px) {
    main {
      padding-left: 30px;
      padding-right: 30px;
    }
  }

  /**
   * フッター
   */
  footer {
    background: #c84040;
    font-size: 0.9rem;
    color: #fff;
  }
  .footer-container {
    padding-top: 20px;
    padding-bottom: 20px;
  }
  ```

* ウィンドウ幅いっぱいの背景色を適用するには
  * ナビゲーションやヘッダーなど一部の要素にだけウィンドウ幅いっぱいに背景色を塗る
    * `<body>`の直接の子要素にbackgroundプロパティを適用する
    ```html
    <body>
      <footer> // background:#c84040;
        <div class="container"> // max-width:1000px;

        </div>
      </footer>
    <body>
    ```

### ヘッダーを作成する

* `<header>~</header>`の間に、ロゴとナビゲーション用ボタン(狭いときだけ表示)を配置する
  ```html
  <header>
    <div class="container header-container">
      <div class="header-inner">
        <h1 class="header-logo">
          <a href="index.html">
            <img
              src="images/logo.png"
              srcset="images/logo.png 1x, images/logo@2x.png 2x"
              alt="Codera">
          </a>
        </h1>
        <button class="menu-btn" id="mobile-menu"></button>
      </div>
    </div>
  </header>
  ```
  ```css
  header {
    background: #c84040;
  }
  .header-inner {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  .header-logo {
    padding: 10px;
    width: 160px;
    height: 37px;
  }
  .menu-btn {
    padding: 10px 9;
    border: 1px solid #fff;
    border-radius: 4px;
    width: 40px;
    height: 40px;
    background: url(../images/hamburger.png) no-repeat center center; 
    background-size: contain;
  }
  @media screen and (min-width: 768px) {
    .header-logo {
      padding: 20px 0;
      width: 200px;
      height: 46px;
    }
    .menu-btn {
      display: none;
    }
  }
  ```

* imgタグのsrcset属性
  * ディスプレイの解像度に合わせて表示する画像を切り替えることができる
  * 標準的な解像度のディスプレイ向け(logo.png)と高解像度ディスプレイ用(logo@2x.png)
  * srcset属性に対応していないIE11以前はsrc属性で指定された画像を表示する
  ```html
  <img
    src="通常解像度の画像ファイル.jpg"
    srcset="
      通常解像度の画像ファイル.jpg 1x, 
      高解像度の画像ファイル.jpg 2x">
  ```

* `justify-content`(chp9参照)
  * フレックスアイテムの配置(水平方向の整列方法)を決めるもの
  * center: 中央寄せ
  * flex-start: 左寄せ
  * flex-end: 右寄せ
  * space-around: 均等配置(端に空白あり)
  * space-between: 均等配置(端に空白なし)

### フッターを作成する

* liを横に並べる程度
  ```html
  <footer>
    <div class="container footer-container">
      <ul class="footer-nav">
        <li>
          <a href="course/index.html">コース紹介</a>
        </li>
        <li>
          <a href="qanda/index.html">よくある質問</a>
        </li>
        <li>
          <a href="contact/index.html">お申込み</a>
        </li>
      </ul>
      <p class="footer-copyright">
      $copy; codera
      </p>
    </div>
  </footer>
  ```
  ```css
  footer {
    ...
  }
  .footer-container {
    ...
  }
  .footer-nav {
    list-style-type: none;
  }
  .footer-nav li {
    display: inline;
    padding: 0 1rem 0 0;
  }
  .footer-nav a {
    color: #fff;
    text-decoration: none;
  }
  .footer-nav a:hover {
    opacity: 0.5;
  }
  ```

### テンプレートを作成する

* フッターまで出来上がると、各ページに共通する部分のHTMLとCSSが完成する
  * template/に作業中のindex.htmlをコピーする

### 伸縮するキービジュアルと、メイン部分を仕上げる

* キービジュアルは画面幅に合わせて伸縮するようにする
* 「コース案内」部分の4つのボックスはフレックスボックスで並べる
  * 画面幅が狭いときは縦に、広いときは横一列に並ぶようにする
  ```html
  <div class="home-keyvisual">
    <img
      src="images/keyvisual.jpg"
      alt="Codera"
      class="img-responsive">
  </div>

  <section class="main">
    <div class="container">
      <main>
        <p class="home-maincopy">
        子供から大人まで、<br>
        <span class="home-color1">プ</span>
        <span class="home-color2">ロ</span>
        <span class="home-color3">グ</span>
        <span class="home-color4">ラ</span>
        <span class="home-color1">ミ</span>
        <span class="home-color2">ン</span>
        <span class="home-color3">グ</span>
        を学ぶなら、<strong>Codera</strong>。
        </p>

        <h2 class="home-h2">お知らせ</h2>
        <div class="home-news">
          <ul>
            <li>
              来月から、新コースを続々開講します
            </li>
            <li>
              Web最新動向トークセッション、参加者受付開始
            </li>
            <li>
              今すぐ始めるキャンペーンで入会費が50%OFF!
            </li>
          </ul>
        </div>

        <h2 class="home-h2">コース紹介</h2>
        <ul class="home-course">
          <li>
            <a href="index.html">
              <figure>
                <img src="images/course1.png" alt="HTML&CSS基礎">
                <figcaption>WordPressサイト構築</figcaption>
              </figure>
            </a>
          </li>

          <li>
            <a href="#">
              <figure>
                <img src="images/course2.png" alt="WordPressサイト構築">
                <figcaption>WordPressサイト構築</figcaption>
              </figure>
            </a>
          </li>

          <li>
            <a href="#">
              <figure>
                <img src="images/course3.png" alt="Pythonでデータ解析">
                <figcaption>Pythonでデータ解析</figcaption>
              </figure>
            </a>
          </li>

          <li>
            <a href="#">
              <figure>
                <img src="images/course4.png" alt="Rubyスクレイピング">
                <figcaption>Rubyスクレイピング</figcaption>
              </figure>
            </a>
          </li>
        </ul>
      </main>
    </div>
  </section>
  ```
  ```css
  /**
   * キャッチコピー
   */
  .home-maincopy {
    text-align: center;
    font-size: 1.4rem;
  }
  .home-maincopy strong {
    color: #c84040;
  }
  @media screen and (min-width: 768px) {
    .home-maincopy {
      font-size: 2.4rem;
    }
  }
  .home-color1 {
    color: #f8b173;
  }
  .home-color2 {
    color: #74b9d9;
  }
  .home-color3 {
    color: #8bca85;
  }
  .home-color4 {
    color: #f8817e;
  }

  .home-h2 {
    padding-bottom: 5px;
    margin: 30px 0 10px 0;
    color: #c84040;
    border-bottom: 1px dashed #c84040;
    font-size: 1.3rem;
  }

  /**
   * お知らせ
   */
  .home-news {
    padding: 30px;
    border-radius: 10px;
    background: #fff;
  }

  /**
   * コース紹介
   */
  .home-course {
    display: flex;
    flex-flow: column;
  }
  .home-course li {
    flex: 1 1 auto;
    margin: 0 wpx 4px 2px;
    border: solid 5px #fff;
    list-style-type: none;
    background: #fff;
  }
  @media screen and (min-width: 768px) {
    .home-course {
      flex-flow: row;
    }
  }
  .home-course a {
    color: #393939;
    text-decoration: none;
  }
  .home-course figure:hover {
    opacity: 0.5;
  }
  .home-course figcaption {
    padding: 15px 0;
    font-size: 0.9rem;
    font-weight: bold;
    text-align: center;
  }
  ```

* フレックスアイテムが伸縮するのは、ボックスのコンテンツ領域のみ
  * 上下マージンに畳み込みも発生しない

* パディングやマージンの大きさを「％」で指定してはいけない
  * ブラウザ間で解釈に違いがあり、表示が崩れる可能性がある

* メディアクエリは、切り替えるスタイルのすぐ近くにあるとよい
  * 理解しやすく、管理が楽になる


### コース紹介ページを作成する

* テンプレートHTMLをもとに作成する
  * `<main>~</main>`の中身

* `<meta name="description">`と`<title>`の内容は1ページごとに変える
  * titleはそのページの一番重要な見出し(h1)とほぼ同じ内容にしておく

* 高解像度の画像を背景画像に使用する方法
  * background-sizeプロパティを適用する必要がある
    * 元の画像より大きなボックスに背景を指定する場合
    ```css
    background-size: 50px 50px;
    ```
    * 元の画像より小さなボックスの背景にするには
    ```css
    background-size: contain;
    ```

* ボックスを丸く切り抜く
  * border-radiusプロパティの値を50%にすると、円形に切り抜くことができる

### よくある質問ページを作成する

* `p`に適用されるCSS
  * 背景画像の適用、パディングの適用
  ```html
  <p class="q-and-a question">....?</p>
  <p class="q-and-a answer">...</p>
  ```
  ```css
  .q-and-a {
    margin-top: 1em;
    padding: 8px 0 0 60px;
  }
  .question {
    font-weight: bold;
    color: #6eba44;
    background: url(../images/q.png) no-repeat;
    background-size: 40px 40px;
  }
  .answer {
    margin-bottom: 2em;
    background: url(../images/a.png) no-repeat;
    background-size: 40px 40px;
  }
  ```

* 複数クラスの使用
  * 「共通する部分のスタイル」と「独自のスタイル」を別々に作成し、複数のクラスを指定することがある
  * 一括で修正ができ管理しやすくなる

### お申込みページを作成する

* templateからの作成

## 完成後、必要なら最後の仕上げでパスを書き換える

* フォルダのパスに注意
  * ルート相対パスに置換する(危険な後加工)
  * そもそも開発用Webサーバーで作業する

* Photoshop を使わず、いきなりHTMLとCSSを書く時代のデザイン
  * レスポンシブWebデザインが普及する以前はPhotoshop等の画像編集アプリでデザインを画像ファイルで作成
    * 現在でも健在で、デザイナー/マークアップエンジニアで分業する場合必須作業
    * 画面幅が変わるデザインを、制止した画像ファイルに書き起こすことが困難
  * 最近ではいきなりHTML/CSSを描くケースが増えている
    * デザインが完成した時点でHTML/CSSも出来上がっている
    * どちらも対応できるような、今まで以上に高いスキルが必要になる
  * CSSフレームワーク(よく使われるパーツのCSSがあらかじめ用意されたもの)
    * Bootstrap etc
  * CSSプリプロセッサー(巨大化するCSSを管理しやすくするツール)
    * Sass etc