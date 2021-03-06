# Chapter 2

## HTMLは「タグをつかって文書をフォーマット」するもの

* HTML(Hypertext Markup Language)
  * Webページを作成するための言語
  * 人間にもコンピュータにも理解できるドキュメントの構造を作る
  * 1つのWebページには、1つのHTMLドキュメントが必要

* HTML5になって以前のバージョンよりタグ数がほぼ倍増している
  * 実際に公開されているHTMLを見るかぎり、使うタグの種類はあまり増えていない
    * 多くのタグを正確に使い分けるよりも、できるだけシンプルに描くことを目指す傾向にあるため
  * 色々なタグの使い方を覚えるより、どうやってうまくドキュメントを構造化していくかのほうが重要

* タグの定義・文法を含むHTML全般の仕様は、`W3C(The World Wide Web Consortium)` が決めている
  * 国際的なインターネット関連技術の標準化団体

* W3Cが定めたHTMLの仕様文書にはバージョン番号がついている(=HTMLのバージョン)
  * 最新版はHTML5
    * [HTML5.2](https://www.aura-office.co.jp/blog/html5-2/)
  * 以前のバージョンにはHTML4.01, XHTML1.0がある

* [W3Cで公開されている最新のHTMLの仕様文書(英語)](http://www.w3.org/TR/html51/)

* 以前のバージョンとの違い
  * 新機能やタグの書き方の仕様変更
  * 仕様が厳格に
  * 各ブラウザがW3Cの仕様に沿うようになり、各表示誤差ははるかに小さくなった

## HTMLの一般的な書式

```txt

|-----------要素-----------------|
タグ名        属性      コンテンツ
<a href="http://hoge.jp">HUGA</a>
     開始タグ                終了タグ
        |---------タグ---------|
```

* 属性には2種類
  * そのタグに固有の属性
    * aタグのhref属性など
  * どんなタグにも追加できる属性(グローバル属性)
    * class, id属性など

* 空要素
  * 終了タグがない
  * 特殊な記法
    * XHTML記法: `<br/>`
    * HTML4.01とXHTML1.0は微妙に書式が異なっていた
    * HTML5.0はどちらでもよいことになっている(今回は`/`を書かないようにする) 
  * 例
    * `<meta>` 画面には表示されない、HTMLドキュメント自体の情報を記しておくタグ
    * `<link>` 同上

## HTMLドキュメントの構造

* 要素と要素は階層構造（ツリー構造、木構造）を作る
* 親要素、子要素
* 祖先要素、子孫要素
* 兄弟要素
* x 親要素からはみ出す子要素
  * `<p> hoge <a href="http://hoge.html"> huga </p></a>`

## マークアップの基本的な考え方

* 記事の大見出しを」立てる
  * `<h1> ~ </h1>`

* 中見出しを立てる
  * `<h2> ~ </h2> ... <h6> ~ </h6>`
  * 5,6 はほぼ使わない

* 段落を作る
  * 段落：長い文章の一部分で、文章の先頭から改行までのことをいう
  * `<p> ~ </p>`
  * 1行分のスペースが空く
  * 段落終わりの改行に`<br>`タグを使うのは正しいHTMLとはいえない
  * 段落間のスペースを取り除きたいならCSSで調整する

* 箇条書きを作る
  * `<ul> ~ </ul>` : 非順序リスト(Unorderd List)
    * `<li> ~ </li>` : リストの項目を表示する(List Item)

* リンクを作る
  * `<a> ~ </a>`
  * 太文字のタグ
    * `<b> ~ </b>`
    * タグで囲むテキストが重要な場合には、`<strong> ~ </strong>` を使う
    * 厳密に使い分ける必要はない
      * `<strong>, <em>, <mark>`  
      <strong>strong</strong>, <em>em</em>, <mark>mark</mark>
  * 日本語に斜体がないので使用しない。（メイリオなどは斜体にならない）
  * 下線はリンクと見た目の区別が難しいのでため、原則として`<u>`は使用しない

* 記事をセクションごとにまとめる
  * さらに丁寧なマークアップを目指すなら、記事をセクションごとに分けることができる
  * セクション
    * 「見出しとそれに続く内容」をひとまとめにしたセットのこと
  * `<section> ~ </section>`
    * HTML5で新登場
    * 検索エンジンの検索結果で優遇されるといったわかりやすいメリットもないので、無理して使う必要はない
    ```html
    <section>
      <h2>場所と日時</h2>
      <ul>
        <li>
          <b>場所</b>: xxxタワー 9F
        </li>
        <li>
          <b>日時</b>: 12:00
        </li>
      </ul>
    </section>

    <section>
      <h2>注意事項</h2>
      <ul>
        ...
      </ul>
    </section>
    ```

* 記事全体を`<article>`でまとめる
  * 用途がわかりづらいので、無理して使う必要はない

## HTMLドキュメントの基礎部分をマークアップ
```html
<!DOCTYPE html>
<html lang="ja">

<head>
    <meta charset="utf-8">
    <meta name="description" content="~を紹介します。参加者募集中">
    <title>
        タイトル
    </title>
</head>

<body>
    <article>
    ...
    </article>
</body>

</html>
```

* HTMLファイルを作成する場合は、ファイルの文字コードを`UTF-8`にする
  * 現在のWebサイトではUTF-8にするのが主流
     * サクラエディタはデフォルトがShift-JIS
     * メモ帳は改行コードがCRLFでないと、改行されないため向かない

* DOCTYPE宣言
  * どのバージョンのHTMLで書かれているかを示す
  * `<!DOCTYPE html>` はHTML5の仕様に基づいて書かれていることを示している
  * HTML4.01 : `<!DOCTYPE HTML PUBLIC "-//W3C/DD HTML 4.04 Trasitional//EN" "http://.../loose.dtd">`

* `<html>`タグとlang属性
  * Webページで使用する主な言語を指定する
  * 検索エンジンは、lang属性でそのページの主な言語を判別している可能性がある

* `<head>`タグ
  * HTML自体の情報(メタデータ)を記載する
  * ブラウザウィンドウに表示されることはない
  * bodyの部分を正しく表示させるための記述
  * 検索サイトにそのページの内容を伝えるための記述
  * `<meta charset="utf-8">`
    * このHTMLはUTF-8であることを示している
    * ブラウザはこの行をみてHTMLの文字コードを判断する(ないと文字化けする可能性がある)
    * できるだけ早くブラウザに伝える必要があるので、head開始タグの次の行に記載する
  * `<meta name="description" content="~を紹介します。参加者募集中">`
    * ページの概要を記しておく部分
    * 70~80文字程度の長さで書いておく
    * 検索サイトの検索結果に表示される可能性が高い
  * `<title> ~ </title>`
    * ブラウザウィンドウのタイトル
    * 検索サイトの検索結果に表示される可能性が高い

* `<body>`タグ
  * HTMLを書く作業という作業のほとんどが、bodyにタグとコンテンツを追加していくこと