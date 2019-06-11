# JSXの導入

* 文字列でも、HTMLでもない
    ```javascript
    const element = <h1>Hello, world!</h1>;
    ```
    + JSXと呼ばれる、JavaScriptの構文の拡張
    + JSXと一緒にReactを使うのがおすすめ

* 使う理由
    + 技術を分離するのではなく、関心を分離する
    + 単にマークアップとロジックを別々のファイルに書くのではない
    + マークアップとロジックを両方含む、疎結合の`コンポーネント`という単位を用いる

## JSXに式を埋め込む

```javascript
const name = 'Jsoh Perez';
const element = <h1>Hello, {name}</h1>;

ReactDOM.render(
    element,
    document.getElementById('root')
);
```

* あらゆるJavaScriptの式をJSX内で中カッコに囲んで使用できる
    + `2 + 2`, `user.firstName`, `formatName(user)`

```javascript
function formatName(user) {
    return user.firstName + ' ' + user.lastName;
}

const user = {
    firstName: 'Harper',
    lastName: 'Perez'
};

// 自動セミコロン挿入の落とし穴にはまらないよう、カッコで囲むことが推奨される
const element = (
    <h1>
        Hello, {formatName(user)}!
    </h1>
);

ReactDOM.render(
    element,
    document.getElementById('root')
);
```

## JSXもまた式である

* コンパイルの後、JSXの式は普通のJavaScriptの関数呼び出しに変換される
    + if, for, 変数, 関数内で扱えるということ
    ```javascript
    function getGreeting(user) {
        if(user) {
            return <h1>Hello, {formatName(user)}!</h1>;
        }
        return <h1>Hello, Stranger.</h1>;
    }
    ```

## JSXで属性を指定する

* 文字列リテラルを属性として指定するために、引用符を使用できる
    ```javascript
    const element = <div tabIndex="0"></div>;
    ```

* 属性にJavaScript式を埋め込むために中括弧を使用できる
    ```javascript
    const element = <img src={user.avatarUrl}></img>;
    ```
    + 中括弧を囲む引用符を書かないように注意

* JSXはHTMLよりJavaScriptに近いもの
    + ReactDOMはキャメルケースのプロパティ命名規則を使用する
        - `class` > `className`, `tabindex` > `tabIndex`

## JSXで子要素を指定する

* タグが空の場合、XMLのように`/>`で閉じることができる(閉じるのはXML同様必須)
    ```javascript
    const element = <img src={user.avatarUrl} />
    ```

* JSXのタグは子要素を持つことができる
    ```javascript
    const element = (
        <div>
          // 子要素
          <h1>Hello!</h1>
          <h2>Good to see you here.</h2>
        </div>
    )
    ```

## JSXはインジェクション攻撃を防ぐ

* JSXにユーザーの入力を埋め込むことは安全である
    ```javascript
    const title = response.potentiallyMaliciousInput;
    // This is safe.
    const element = <h1>{title}</h1>;
    ```
    + デフォルトではReactDOMはJSXに埋め込まれた全ての変数をレンダリング前にエスケープする
        - アプリに明示的に書かれた以外のコードはイジェクトされないことが保証される
    + レンダリングの前にすべてが文字列に変換される
        - XSS攻撃の防止に役立つ

## JSXはオブジェクトの表現である

* BabelはJSXを`React.createElement()`にコンパイルする
    ```javascript
    // 以下は等価
    const element = (
        <h1 className="greeting">
          Hello, world!
        </h1>
    );

    const element = React.createElement(
        'h1',
        {className: 'greeting'},
        'Hello, world!'
    );

    // createElementは以下のようなオブジェクトを生成する
    const element = {
        type: 'h1',
        props: {
            className: 'greeting',
            children: 'Hello, world!'
        }
    }

    // React要素と呼ばれる
    ```

* Reactはこれらのオブジェクトを読み取り、DOMを構築して最新に保つ