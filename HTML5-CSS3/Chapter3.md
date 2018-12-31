# CSSの基礎知識とページデザインの実践例

## HTMLに表示のためのスタイル情報を追加するのがCSS

* CSS(Cascading Style Sheets, スタイルシート)
  * HTMLはページのスタイルやレイアウトを調整する機能は持っていない
  * HTMLがブラウザに表示されるときの見た目を調整する

* CSSのバージョン
  * CSSの仕様もW3Cが決めていて、仕様文書も公開されている
  * 現在の最新はCSS2.1(現在CSS2.2が策定中)
  * CSS3: CSS2.1以降に登場した新しい機能の数々をまとめてCSS3と呼んでいる
    * CSS2.1をベースに新機能がどんどん追加されている
    * CSS2.1とCSS3は完全な互換性がある
    ```txt
    +----+- - +----+----+
    |    |    |    |    |
    |    |    |    |    |
    +----+- - +----+    | CSS2.1以降の新機能はすべてCSS3と呼ばれ、今も追加中
    CSS2.1    |CSS2.1   |
              +---------+
               CSS3
    ```

## CSSの基本書式

```css
/* セレクタ 宣言ブロック プロパティ 値 */
h1 {
    font-size: 18px;
}
```

* セレクタ
  * CSSにはHTMLの「どこに」「どんな」スタイルを適用するかが書かれている
  * 「どこに」あたる部分がセレクタ
  * スタイルを適用したい「要素」を選択する
  * セレクタには多数のバリエーションがある
    * タイプセレクタ: タグ名で要素を選択する

* 宣言ブロック
  * 「どんな」スタイルを適用するのかを記述する

* プロパティとその値
  * 値の後ろには必ずセミコロンを書く

* CSSの対応状況を調べる方法
  * [caniuse.com](http://caniuse.com)

* どんなブラウザが使われているか調べるには
  * [StatCounter Global Stats](http://gs.statcounter.com)
  * [総務省情報通信白書](http://www.soumu.go.jp/johotsusintokei/whitepaper)

## 新規にCSSファイルを作成し、HTMLにCSSを読み込む

* HTMLとは別に専用の外部CSSファイルを用意するのが一般的
  * ファイル名をstyle.cssとする
  * HTMLファイル同様、文字コードはUTF-8
  ```css
  /* 必ずCSSの1行目に書く */
  @charset "utf-8";
  ```
  * HTMLファイルを編集して、style.cssを読み込むようにする
  ```html
  <head>
    <meta charset="utf-8">
    <meta name="description" content="hoge">
    <link rel="stylesheet" href="style.css">
    <title>hoge</tile>
  </head>
  ```
  * HTML4.01, XHTML1.0ではtype属性も必要だったが、HTML5では不要
  ```html
  <!-- HTML5ではtype属性不要 -->
  <link rel="stylesheet" href="style.css" type="text/css">
  ```

* CSSを適用する別の方法
  * タグ自体に直接置く
    * 公開するWebサイトではまず使わない
      * タグごとにCSSを記述するとHTMLが複雑になり、管理が大変になる
      * style属性を使うと詳細度が非常に高くなり、後でCSSを上書きするのが難しくなるため
  * `<style>`タグをつかってHTMLに書く
    ```html
    <head>
      <style>
      p {
          color: #ff0000;
          font-weight: bold;
      }
      </style>
    </head>
    ```
    * 実際のWebサイトで使うことは多くないが、そのHTMLにしか使わない短いCSSを描く必要があるとき等に補助的に使う場合がある

## ページ全体のフォントを指定する

* CSSを編集する際の基本
  1. ページ全体のスタイルを調整するCSSから書いていく
  1. 特定の場所にだけ適用されるスタイルを追加する
  * 最終的なCSSソースが短く、シンプルになる
  ```css
  @charset "utf-8";
  /* ページ全体のフォントをゴシック体にする */
  /* 子要素、子孫要素にも適用される */
  body {
      font-family: sans-serif;
  }
  ```

* `CSSの継承`
  * ある要素に指定されたプロパティの値が、その子要素、子孫要素にも適用されること
  * 値が子要素に継承されるかどうかは、プロパティごとに決められている
    * フォント関係(ファミリー、サイズ、色)のプロパティは継承する
    * 背景色、背景画像などのプロパティは継承しない
    * ボックスモデル関係のプロパティは継承しない
    * そのほかの多くのプロパティは継承しない


## 見出しタグのフォントサイズを指定し、段落の間のスペースを無くす

```css
body {
    font-family: sans-serif;
}
h1 {
    font-size: 21px;
}
h2 {
    font-size: 18px;
}
/* すべてのp要素の上下マージンを0にする */
p {
    margin-top: 0;
    margin-bottom: 0;
}
```

## 箇条書きの先頭の「・」を消す

```html
<ul>
  <li> ... </li>
</ul>

<ul class="info">
  <li> ... </li>
  <li> ... </li>
</ul>
```

```css
/* クラス名が.infoの要素のみにスタイルを適用する(classセレクタ) */
.info {
    list-style-type: none;
}
```

* classセレクタ
  * ピリオドに続けてクラス名を記述する
  * 同じクラス名を持つ要素すべてにスタイルを適用するセレクタ

* セレクタはclassセレクタをメインに使用する
  * 特定の要素にスタイルを適用するときはclassセレクタをメインに使用する

## プロフィールのセクションを線で囲み、見出しを調整する

```html
<section class="profile">
  <h2>プロフィール</h2>
  <p> ... </p>
</section>
```

```css
/* classセレクタ */
.profile {
    padding: 16px;
    border: 1px solid #095cdc;
}
/* 子孫セレクタ */
.profile h2 {
    margin-top: 0;
    margin-bottom: 0;
}
```

* 子孫セレクタ
  * 特定の場所にある要素だけを絞り込むのに使われる

* タイプセレクタ、クラスセレクタ、子孫セレクタはよく使う3大セレクタ
  * CSSの管理がしやすくなる