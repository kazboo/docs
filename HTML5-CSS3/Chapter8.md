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

## 標準的なフォームの例