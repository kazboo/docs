# フォーム

## フォームとデータを送受信する仕組み

### フォームとサーバーの関係

* フォームのHTMLの基本構造
  ```html
  <!-- 親要素はaction属性が必須 -->
  <form action="url(ユーザーが入力したデータが送信される先のURL)">
    <!-- フォーム部品(name属性必須)を、必要なだけ -->
    <input
      type="text"
      name="name">
    <input
      type="checkbox"
      name="check"
      value="c1">
  </form>
  ```

* HTML5の仕様ではおよそ25種類のフォーム部品が定義されている
  * よく使うのは10種類くらい

## さまざまなフォーム部品

### テキストフィールド

* テキストフィールド
  ```html
  <form
    action="#"
    method="post">
    <p>
      <lable for="name-field">お名前</label>
      <br>
      <input type="text" name="name" id="name-field">
    </p>
  </form>
  ```
  * method属性
    * リクエスト方式(HTTPリクエストメソッド)を指定
    * get, postを指定可
  * enctype属性
    * application/x-www-form-urlencoded
      * 複数の「フィールド名=入力内容」を&でつないだ形式のデータで、送信されるデータはURLエンコードされる
    * multipart/form-data
    * text/plain
  * https://developer.mozilla.org/ja/docs/Web/HTTP/Methods/POST

* input要素
  * 処理プログラムとの連携のためにname属性が必要
  * 必須ではないが、`label要素との紐づけ`や、`JavaScriptとの紐づけ`に一般的にid属性を追加する

* テキストフィールド
  * 1行で、改行する必要のない比較的短いテキストを入力するためのフォーム部品
  * ユーザーID、名前、住所、タイトルなどの入力に適する

* label要素
  * フォーム部品にラベルをつけるためのタグ
  * ラベルをクリックすればフォーム部品を選択できるようになる
  * 一般的なスクリーンリーダーでは、ラベルのテキストを読み気た後に、関連するフォーム部品が入力可能な状態になる
  * ユーザビリティ(使いやすさ、利便性のこと)とアクセシビリティ(どんな人でも操作できること)のどちらの観点からも、必ずlabelを使ってフォーム部品と関連づけるべき
  * 関連付ける方法は2つ(機能的な違いはない)
    ```html
    <label for="name-field">Name</label>
    <input type="text" name="name" id="name-field">
    ```
    ```html
    <form action="#" method="post">
        <p>
            <label>
                お名前
                <br>
                <input type="text" name="name" id="name-field">
            </label>
        </p>
    </form>
    ```
  * form属性
    * HTML5で追加された、ラベル（label要素）が所属するform要素を指定する属性
    * form属性を指定しない場合は、直近の祖先要素であるform要素が所属フォームとなる
    ```html
    <label form="formId">
        Name: <input type="checkbox" name="name" value="value" form="formId">
    </label>

    <form id="formId">
        <p>
            <input type="submit" value="送信">
        </p>
    </form>
    ````

* 必須項目のマークアップ
  必須項目のフォーム部品のラベルには「必須」などと書いておく(一般的にはspanタグ)
  ```html
  <head>
    <style>
    .required {
        padding: 0.5em;
        font-size: 0.75em;
        color: #ff0000;
    }
    </style>
  </head>
  <body>
      <form action="#">
          <p>
              <label for="name-field">
                  Name<span class="required">*必須</span>
              </label>
              <br>
              <input type="text" name="name" id="name-field" required>  
          </p>
      </form>
  </body>
  ```

* required属性
  * その項目が入力必須であることを示し、ユーザーが入力をせずに送信ボタンをクリックすると警告が表示される

* ブール属性
  * required属性のように、設定する値がないもの
  * checked, selected, autofocus, disabledなど

* テキストフィールドのサイズをCSSで調整する
  * できるだけ大きく、入力テキストのフォントサイズも大きく
    * 小さなスマホには効果的
  * テキストフィールドのボックスモデルを変更
    * box-sizingプロパティ
      * widthプロパティで設定する幅に、パディングとボーダーの領域が含まれるようにする
    * テキストフィールドにボーダー、パディング設定が適用済みの場合に有用

* テキストフィールドにCSSを適用する
  * 幅、フォント以外にもテキストフィールドの角を丸くしたり、入力可能な状態になったときに背景色をつけることもできる
  * border-radiusプロパティ
  * 属性セレクタ
    * `input[type="text"]`
  * :focusセレクタ(疑似クラス)
    * 選択され、入力可能な状態になった(フォーカスされた)状態

* テキストフィールドに似た、別の用途のフォーム部品
  * パスワードフィールド(`type="password"`)
    * ユーザーが入力した文字をすべて点で表示する
  * メールアドレスフィールド(`type="email"`)
    * メールアドレスではないテキストを入力すると警告のポップアップなどが出る
  * 電話番号フィールド(`type="tel"`)
    * 電話番号を入力するためのフィールド
    * メールアドレス同様、スマホで閲覧するとそれぞれの入力に適したキーボードが自動的に表示される
  * 数値を入力するためのフィールド(`type="number"`)
    * 少なめの数を入力してもらうのに使うとよい
    * フィールドの隣にボタンが表示される(IE/Edgeは表示されない)
  * 部品が何も表示されない(`type="hidden"`)
    * フォームから何らかのデータを処理プログラムに送信するために使われる
      * ex) コメントID, ログインしているかを確認するための情報等

### テキストエリア

* 複数行のテキストを入力できるフォーム部品
  * 自由記述欄
  * 終了タグがあるので注意が必要
  ```html
  <p>
      <label for="comment">お問い合わせの内容</label>
      <br>
      <textarea name="comment" id="comment"></textarea>
  </p>
  ```

* テキストエリアのサイズ調整
  ```css
  input, textarea {
      box-sizing: border-box;
  }
  textarea {
      margin: 0.5em 0;
      border: 1px solid #ccc;
      padding: 0.75em;
      width: 100%;
      height: 12em;
      font-size: 16px;
      color: #999;
  }
  ```

* 業務で使ったCSSプロパティ
  * resizeプロパティ
    * 横方向の拡大を禁止
      ```css
      textarea {
          resize: vertical;
      }
      ```
      テキストエリアを右寄せにして拡大機能を使うと拡大しづらかったりする。  
      noneを指定すると完全に固定できる。
  * white-spaceプロパティ
    * 要素内のホワイトスペースをどのように扱うか設定する

### ラジオボタンとチェックボックス

* ２つ以上の選択項目を用意するので、pではなく、ul、liでマークアップするのがいい
  ```html
  <form action="#">
      <p class="label-p">時刻の設定</p>
      <!-- ラジオボタン -->
      <ul class="input-group">
          <li>
              <input
                type="radio"
                name="duration"
                id="r1"
                value="1"
                checked>
              <label for="r1">今すぐ出発</label>
          </li>
          <li>
              <input
                type="radio"
                name="duration"
                id="r2"
                value="2"
                checked>
              <label for="r2">出発時刻</label>
          </li>
      </ul>
      <!-- チェックボックス -->
      <ul class="input-group">
          <li>
              <input
                type="checkbox"
                name="option"
                id="c1"
                value="1"
                checked>
              <label for="c1">今すぐ出発</label>
          </li>
          <li>
              <input
                type="checkbox"
                name="option"
                id="c1"
                value="2"
                checked>
              <label for="c2">出発時刻</label>
          </li>
      </ul>
  </form>
  ```

* ラジオボタン、チェックボックスの使い方
  * 同じ設問に属する項目のグループには、同じname属性(name名)をつけておく必要がある
  * 個々の項目には異なる値のvalue属性をつけておく必要がある

* ラジオボタンとチェックボックスの違い
  * ラジオボタン
    * 同じ設問に属するグループの中で選択できるのは1つだけ
    * どれも選択しない状態には戻せない
    * 回答の強制力が強く、事実上の入力必須項目
    * 業務にて、ラジオボタンを再選択できるようしてほしいという要望もあった。JavaScriptで対応は可能だが。。
  * チェックボックス
    * 複数回答ができる設問(オプション設定など)

* 項目を横に並べる
  * CSSで調整する
  inputやlabelの親要素であるliのdisplayプロパティをinlineにするのが一番簡単
  ```html
  <style>
  body {
      margin: 0;
  }
  form {
      padding: 16px;
  }
  .label-p {
      margin-bottom: 0;
  }
  .input-group {
      margin: 0;
      padding: 0;
      list-style-type: none;
  }
  .horizontal li {
      display: inline;
      margin-right: 1em;
  }
  </style>
  ```

### プルダウンメニュー(ポップアップメニュー)

* 多数の選択肢の中から1つだけ
  ```html
  <p>
    <label for="month">有効期限</label>
    <br>
    <select name="month" id="select">
      <option value="" selected>月</option>
      <option value="01">01</option>
      :
      <option value="12">12</option>
    </select>
    /
    <select name="yaer" id="select">
      <option value="" selected>年</option>
      <option value="2015">2015</option>
      :
      <option value="2020">2020</option>
    </select>
  </p>
  ```

### ボタン(送信ボタン)

* 送信ボタン
  ```html
  <form action="#">
    <p>
      <input
        type="submit"
        name="submit" 
        value="送信する"
        id="submit">
    </p>
  </form>
  ```

* 送信ボタンの見た目を変える
  ```html
  <style>
  input[type="submit"] {
      border: 1px solid #0086f9;
      border-radius: 6px;
      padding: 12px 48px;
      font-size: 16px;
      background: linear-gradient(0deg, #0086f9, #b6d6f7);
      color: #fff;
      font-weight: bold;
  }
  input[type="submit"]:hover {
      background: linear-gradient(0deg, #2894f9, #d2e4f7);
  }
  input[type="submit"]:active {
      background: linear-gradient(0deg, #0074d8, #b6d6f7);
  }
  ```
  送信ボタンやbutton要素は疑似クラスも使用できるので、かなり自由にデザイン変更できる

* CSSのグラデーション
  * backgroundプロパティにグラデーションを指定することができる
    ```css
    background: linear-gradient(グラデーションの角度deg, 開始色, 終了色);
    ```

* button要素([MSDN](https://developer.mozilla.org/ja/docs/Web/HTML/Element/button)
  * input要素よりもずっと簡単に整形できる
  * ボタンがサーバーにデータを送信するためのものでない場合は、type属性を設定することを忘れないように注意
  ```html
  <button
    class="favorite styled"
    type="button">
    Add to favorites
  </button>
  ```

* a要素によるボタン
  * リンクそのものをボタンらしくする
  ```html
  <style>
  .btn-circle-stitch {
    display: inline-block;
    text-decoration: none;
    background: #87befd;
    color: #FFF;
    width: 120px;
    height: 120px;
    line-height: 120px;
    border-radius: 50%;
    text-align: center;
    vertical-align: middle;
    overflow: hidden;
    box-shadow: 0px 0px 0px 5px #87befd;
    border: dashed 1px #FFF;
    transition: .4s;
  }

  .btn-circle-stitch:hover {
    background: #668ad8;
    box-shadow: 0px 0px 0px 5px #668ad8;
  }
  </style>
  <a href="#" class="btn-circle-stitch">BUTTON</a>
  ```

## 標準的なフォームの例