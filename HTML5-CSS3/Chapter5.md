# リンクの設定と画像の表示

## テキストにリンクを追加する

* リンクを別タブで開く
  ```html
  <a href="http://www.google.com" target="_blank">GOOGLE</a>
  ```
  * target属性はリンク先を開くウィンドウを指定する属性(基本_blankが使われる)
    * [target-new](https://www.osaka-kyoiku.ac.jp/~joho/html5_ref/css/target-new_css.php)
    * [target=_brankの危険性](https://edge.sincar.jp/web/target_blank-security/)
      ```html
      <a href="https://www.hoge.com" target="_blank" rel="noopener">〜</a>
      ```

* Webページで一番大事なのは「リンクされていること」
  * 多くの人にページを見てもらうこと
  * Webサイトのすべてのサイトは相互リンクするようにする
    * クローラーもWebページに含まれるリンクをたどって世界中のページを巡回している
       * つながっていないページには巡回できない

* サイト内リンク、内部リンク
  * 同一サイト内の別のページにリンクすること
  * Webサイトの開発がしやすくなるため、主に相対パスが使われる
    * 作成中は相対パスで書いておき、CMSに組み込む段階や、Webサーバーにアップロードする直前に検索置換で絶対パスやルート相対パスに変換することもある

* 同階層のindex.htmlを省略して指定するときは`./`と書く
  * `index.html`は省略しなくてもかまわないが、サイト全体で統一するようにする
    * 現在では、省略するケースのほうが多い
    * アクセス解析ツールで別のページとして認識してしまい、うまくデータが取れなくなる可能性がある
      * Google Analyticsなど

* `ルート相対パス`
  * そのサイトのルートディレクトリを起点とするパスの指定方法
  * CMSを利用するときや、大規模サイトなどでよく使われる
  * 作業用PCではリンクがつながらなくなる
    * 公開直前に検索置換か、開発用のWebサーバーを設置して作業する

* 現在のWebサイトはルート相対パスを使ったり、index.htmlを省略したり、CMSを導入するプロジェクトが増えている

* ページ内の特定の場所へリンク(ページ内リンク)する
  ```html
  <body>
    <ul>
      <li><a href="#headline1037">hoge1</a></li>
    </ul>
    <h2 id="headline1036">hoge1</h2>
  </body>
  ```
  hrefが`#`だけのリンクは、常にページの最上部に移動する
  ```html
  <a href="#">ページトップに戻る</a>
  ```

* id名のつけ方ベストプラクティス
  * id属性は極力使わないが、ページ内リンク、JavaScriptで扱う場合必須
  * 命名の大原則
    * ルールを決めておけば命名が楽になる
    * ID : 個体を識別するための番号。重複してなければよい。
      * HTMLの仕様でも、id名に意味がある必要はないとされている
  * IDのつけ方1: 見出しのテキストをそのままid名にする
    ```html
    <h2 id="おかしいなと思ったら">おかしいなと思ったら</h2>
    ```
    * 日本語を扱うことが可能
    * 半角スペースは扱えないため、ハイフンなどで代用する
  * IDのつけ方2: そのHTMLを描いている瞬間の時刻をid名にする
    ```html
    <h2 id="headline1156">おかしいなと思ったら</h2>
    ```
    * id名の1文字目が数字だとCSSのidセレクタが使えなくなる(極力使わないが、念のため)

## テキストリンクにCSSを適用する

* リンクの状態に合わせて表示を変える
  ```html
  <style>
  /* 疑似クラスなしのaに設定したスタイルは、リンクがどの状態であっても適用される */
  a {
      color: #0073bc;
  }
  /* aタグでかつhref属性がついている要素にスタイルが適用される(通常の状態) */
  a:link {
      color: #0073bc;
  }
  /* aタグで、かつリンク先が訪問済みの時にスタイルが適用される */
  a:visited {
      color: #02314c;
  }
  /* その要素にマウスポインタが重なっている(ホバー状態)時にスタイルが適用される */
  a:hover {
      color: #b7dbf2;
  }
  /* その要素の上でマウスボタンがクリックされている(アクティブ状態)ときにスタイルが適用される */
  a:active {
      color: #4ca4e8;
  }
  </style>
  ```
  * `a`はタイプセレクタ
  * `:`疑似クラスと呼ばれるセレクタ
    * サンプル通りの順番で書かないと、思った通りにスタイルが適用されない
      ```
      :link { ... }
      :visited { ... }
      :hover { ... }
      :active { ... }
  * 実践では`:link`と`:visited`は`省略されることが多い`
    * `:link`は疑似クラスなしの`a`とほぼ変わらない
    * `:visited`は実際に多くのサイトは使用していない
      * 訪問済みとそうでないリンクが混在してページ内の色数がふえると、デザイン上美しく見えない

* 下線を消す
  ```html
  <style>
  a {
      color: #0073bc;
      text-decoration: none;
  }
  a:hover {
      color: #b7dbf2;
      text-decoration: underline;
  }
  </style>
  ```
  * ホバーしたときだけ下線がつく
    * この表現はテキスト色を変えるのと同じくらい良く使われる
  * text-decorationプロパティ
    * テキストに下線や打消し線を引くプロパティ
      * `none`, `underline`, `overline`, `line-through`
    * 通常のテキストにも使えるが、リンクと区別がつかなくなるのでやめたほうが良い
  * スマートフォンのホバーの扱い
    * ホバー時に適用されるCSSはあまり意味がない
      * ホバーの反応が遅れたりする
      * 参考) ハイライト機能
        ```css
        a {
            -webkit-tap-highlight-color: rgba(243, 151, 45, 0.5);
        }
        ```

* 別タブで開くリンクの後ろにアイコンを表示する
  * リンクの内、別タブで開くように設定されたものにだけ、リンクテキストの後ろにアイコンを表示する
    ```html
    <style>
    a[target="_blank"]::after {
        content: url(../../images/opentab.png);
    }
    </style>
    ```
    * `属性セレクタ`
      ```css
      /* `a` タイプセレクタ, `[target="_blank"]` 属性セレクタ, `::after` 疑似要素 */
      a[target="_blank"]::after { }
      ```
      * タグに設定されている属性を条件にして要素を選択できるセレクタ
      * タイプセレクタやclassセレクタでは選択しづらい場合に使用する
      * 使用例)
        * チェックがついているラジオボタンやチェックボックスの背景色を変更する
          ```css
          [checked] {}
          ```
        * `https://`で始まるリンクテキストの前にアイコンを表示する
          ```css
          a[href^="https://"] {}
          ```
        * リンク先がPDFファイルの時に、テキストの後ろにアイコンを表示する
          ```css
          a[href$=".pdf"] {}
          ```
    * `疑似要素`
      * `::after`は疑似要素と呼ばれるセレクタ
      * 選択している要素のコンテンツの後ろに、画像・テキスト等HTMLに書かれていないコンテンツを挿入することができる
        ```css
        セレクタ::after {
            content: url(画像のURL);
        }
        セレクタ::before {
            content: "※";
        }
        ```
      * CSS2.1では`:before`, `:after`と表現されたが、CSS3で2つになった
        * 古いブラウザをサポートする場合は、コロン一つで書く(IE8以前もの)

## 画像を表示する

* alt属性とアクセシビリティ
  * 画像の代わりに表示されるテキストを指定する
    * 画像のリンク切れ等
  * 視覚障碍者が利用するスクリーンリーダーはこのalt属性のテキストを読み上げる

* オリジナルとは異なるサイズで表示する
  * レスポンシブWebデザインでレイアウトを組む場合、レイアウトだけでなく画像サイズも伸縮させることがある
  * CSSでwidth, height属性を無視して伸縮できる
  * img-responsiveをclass属性に追加・削除するだけで切り替えられるため便利
  ```html
  <style>
  .img-responsive {
    display: block;
    max-width: 100%;
    height: auto;
  }
  </style>
  <img
    src="../images/img12.jpg"
    width="300"
    height="200"
    alt="サンプル"
    class="img-responsive">
  ```
  * サムネイル表示にも使える(CSSで200pxに固定)
  ```html
  <style>
  .img-responsive {
    display: block;
    max-width: 100%;
    height: auto;
  }
  .thumbnail {
    width: 200px;
  }
  </style>
  <div class="thumbnail">
    <img
      src="../images/12.jpg"
      width="300"
      height="200"
      alt="サンプル"
      class="img-resonsive">
  </div>
  ```

  * 参考) display: block
    * [【CSS】displayの使い方を総まとめ！inlineやblockの違いは？](https://saruwakakun.com/html-css/basic/display)


## 画像にリンクをつける

* 画像の下にテキストを付け加える
  ```html
  <a href="http://studio947.net">
    <div>
      <img
        src="../images/image0320.jpg"
        width="300"
        height="200"
        alt="サンプル">
    </div>
    <p>サンプルテキスト</p>
  </a>
  ```

* `<a>~</a>`に含めることができるコンテンツ
  * HTML5ではどんな要素でも含められるようになった
  * 以前はテキストを修飾するものだけ

* 画像にホバーしたときに表示を変える
  ```html
  <style>
  a:hover img {
    opacity: 0.5;
  }
  </style>
  ```

* 子孫セレクタを使用するときは、必ずしもHTMLの構造をなぞる必要はない
  ```html
  <style>
  a:hover div img {

  }
  * セレクタ数が少ないほうがHTMLに修正が入った時でも対応しやすい

* opacity(オパシティ)プロパティ
  * 0~1(0:完全に見えない、1:完全に不透明)

* ホバーしたときに画像に枠線をつける
  ```html
  <style>
  .frame {
    padding: 8px;
    border: 1px solid transparent;
  }
  a:hover .frame {
    border: 1px solid #ccc;
  }
  </style>
  <img src="../../images/image0320.jpg"
    width="396"
    height="292"
    alt="積み木"
    class="frame">
  ```

## 画像にテキストを回り込ませる

* 画像にテキストを回り込ませることは少なくなった
  * しかしニュースサイトでは多く採用されている

* 実用的な回り込みの方法
  ```html
  <style>
  p {
    margin: 0 0 1em 0;
  }
  .float-box {
    float: left;
    margin-right: 1em;
    margin-botton: 0.5em;
    vertical-align: baseline;
  }
  .float-clear {
    overflow: hidden;
  }
  </style>
  <body>
    <!-- 回り込みを解除するための親要素 -->
    <div class="float-clear">
      <!-- テキストコンテンツが回り込む要素 -->
      <div class="float-box">
        <!-- 画像コンテンツ -->
        <img
          src="../../images/orangedrip.png"
          width="157"
          height="140"
          alt="">
      </div>
      <!-- テキストコンテンツ -->
      <p>
        hoge hoge
      </p>
    </div>
  </body>
  ```

* 回り込みを実現するfloatプロパティ
  * `left` このスタイルが適用された要素は左に配置され、テキストはその周りに回り込む
  * `right` 右に配置
  * `none` 回り込まない。レスポンシブWebでデザインで使うことがある

* 回り込みを解除する`overflow: hidden`
  * `いったんどこかの要素にfloatを設定すると、後続の要素は回り込み続けるため、レイアウトが崩れる原因になり危険`
    * 設定した回り込みは、必ずどこかで解除する
  * `clear`プロパティを使うのが基本的だが、実践レベルのマークアップには向かないため、あまり使用されない
    * その代わりに、`回り込みを解除するための親要素`に`overflow: hidden`を適用する
    * `本来別の用途のプロパティ`。CSS仕様上解除できることから、広く使われている
