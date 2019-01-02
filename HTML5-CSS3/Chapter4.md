# テキストの装飾

## 見出しや本文のフォントサイズを調整する

### CSSの単位

* px(ピクセル)
  * ディスプレイの1ピクセル(画素)を1pxとする単位
  * フォントサイズやボックスの大きさを指定するのによく使われる
    * ピクセルの大きさはディスプレイによって異なる
    * ノートパソコンのディスプレイはデスクトップパソコンよりも1pxが小さい
    * スマートフォンのディスプレイはノートパソコンよりも1pxの大きさがさらに小さい
  * `現代的なWebサイト`
    * パソコン向け：14 ~ 16pxが一般的
    * スマートフォン向け：16px以上にすることが一般的

* em(エム)
  * 1文字の大きさを1emとする単位
  * フォントサイズやボックスの大きさを指定するのによく使われる
  * `親要素に指定されたフォントサイズを1emとする`
  * 要素が入れ子になっている場合、予想外のフォントサイズになることがある
    * フォントサイズの制御が難しくなる

* %(パーセント)
  * 「基準となる長さ」に対するパーセンテージを指定する
  * 主にボックスの大きさを指定するのに使われる
  * em同様、注意が必要

* rem(ルートエムまたはレム)
  * `<html>`タグに指定されたフォントサイズを1remとする単位
    * ルートは常に`<html>`を指す
  * フォントサイズを相対的に指定するのに便利

* vw(ビューポート・ウィズ)
  * ビューポート(ウィンドウサイズまたは端末の画面サイズ)の幅の1/100を1vwとする単位

* vh(ビューポート・ハイト)
  * ビューポートの高さの1/100を1vhとする単位

* よくつかわれるのは`px, em, %, rem`の4つ

* Webページのフォントサイズを決める方法は、大きく分けて2通りある
  * タグごとにフォントサイズを指定する方法
  * すべてのフォントサイズを相対的に決める方法

### タグごとにフォントサイズを指定する方法

* 継承の問題もおこらず、シンプルで分かりやすいのが特徴
  * CSSが解読しやすい
  * どの要素が何ピクセルで表示されるのか一目瞭然
  * Photoshop等の画像処理ソフトで作成したページのデザインをHTMLで再現することが目標の場合これが一般的

```html
<style>
body {
    font-size: 14px;
}
h1 {
    font-size: 20px;
}
h2 {
    font-size: 16px;
}
</style>
```

### すべてのフォントサイズを相対的に決める方法

* `<html>`要素に対して「基準のフォントサイズ」を単位pxで設定する
  * font-sizeプロパティは継承する

* em, %の継承の問題を気にすることなく、すべての要素のフォントサイズを相対的に決められる
  * `<html>`要素に指定したフォントサイズを変えるだけで、全フォントサイズを一括で変更できる
    * CSSの管理や修正がしやすくなる
  * 特にレスポンシブWebデザインでパソコン向けとスマートフォン向けでフォントサイズを変えたい時に威力を発揮する

```html
<style>
html {
    font-size: 14px;
}
h1 {
    font-size: 1.4rem;
}
h2 {
    font-size: 1.14rem;
}
</style>
```

## 読みやすい行間にする

### テキストの行間を調整する

```html
<style>
/* 子要素に継承さるので、bodyに設定しておけば一括で調整できる */
body {
    line-height: 1.7;
}
</style>
```

```txt
---------------------------------------
軽量で持ち運びも楽で、 | フォントサイズ   line-height
---------------------------------------
```

* 一般に1.5 ~ 1.8程度
  * 見出しなどはそれより小さい1.2くらいにすることもある
  * 主なブラウザのline-heightプロパティの初期値は1.5あたりに設定されている

## 段落のテキストをリード文だけ太字にする

* リード文
  * 記事の概要を記した短いテキストのこと
  * 通常は記事本体の前に掲載される

### クラス名セレクタを利用する

* リード文を表すタグはないので、段落の`<p>`にクラス名をつけて代用する

```html
<style>
body {
    line-weight: 1.7;
}
.lead {
    font-weight: bold;
}
</style>
<p class="lead">hogehoge... </p>
```

* font-weightプロパティ
  * bold, normal(一般的)
  * 100, 200, 300, 400, 500, 600, 700, 800, 900(Google Fonts等のWebフォントでは使用する場合もある)
    * `= 400`: 通常の太さ
    * `> 400`: 通常より太い
    * `< 400`: 通常より小さい 

## 表示するフォントを設定する

* Webページに表示するフォントは以下から選ぶ
  * 閲覧するコンピュータにインストールされているフォント
  * Webフォント

* 最近はWebフォントを選ぶことも増えてきた
  * まだコンピュータにインストールされているフォントから選ぶケースも少なくない
    * しかしWindows, Mac, Android, iOSのすべてにインストールされているフォントはない
    * どんな機器から閲覧されても問題ないように、いくつかの候補を挙げておく必要がある

### 一般的なフォント指定の方法

* 日本語のWebサイトでは通常、画面上でも読みやすいゴシック体を選ぶ
  ```html
  <!-- ゴシック体の典型的な記述パターン -->
  <style>
  body {
      line-height: 1.7;
      font-family:
        "Hiragino Kaku Gothic ProN",
        "ヒラギノ角ゴ ProN",
        Meiryo,
        "MS　Pゴシック",
        sans-serif;
  }
  </style>
  ```
  最近は省略した形が多い
  ```html
  <style>
  body {
      line-height: 1.7;
      font-family: sans-serif;
  }
  </style>
  ```
  微妙に表示かかわるブラウザもある(Edge, Safari)
  (全角文字は日本語フォント、半角英数字は欧文フォントになる)

* font-familyに複数フォントが指定されている場合
  * ブラウザは1番目のものから順にコンピュータにインストールされているか調べ、最初に見つかったもので表示する

* sans-serif: 日本語では「ゴシック体」という意味

* フォントの種類は大きく分けて2種類
  * セリフ体(serif)
  * サンセリフ体(sans-serif)

* セリフ体
  * 横線が細く、縦線のほうが太い
  * 筆が止まるところにアクセントがあるデザイン

* サンセリフ体
  * 字の横線と縦線の太さに大きな差がない
  * 筆が止まるところにアクセントがない
  * フランス語：サン(ない)セリフ(アクセント)

* 印刷物などでは、長い文章はセリフ体・明朝体のほうが読みやすいとされる
  * 英語のニュースサイト等

* 日本語は形状が複雑な明朝体は、コンピュータの画面では読み辛いため、ゴシック体が使われることがほとんど

### Webフォントを使用する

## テキストの行揃えを変更する

### 見出しのテキストを中央揃えにする

## ２行目移行を1文字下げる

### クラスセレクタ利用する

## テキスト色を変更する

### ページ全体のテキスト色を変更する

### 部分的にテキスト色を変更する

### id属性、class属性の使い方

## 見出しにサブタイトルをつける

### 見出しにサブタイトルをつける
