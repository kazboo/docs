# Chapter 1

## Webサイトが表示される仕組み

* ブラウザがリクエストして、Webサーバーがレスポンスする

* ユーザーエージェント
  * ブラウザはユーザーの「代わりになって」処理を行うことから、ブラウザを「ユーザーエージェント」と呼ぶことがある

## URL (Uniform Resource Locator)

```txt
http://     hoge.net              /info/about.html
|--scheme--|--domain(host) name--|------path------|
```


* インターネット上のHTMLや画像などといったリソースの場所を特定するための書式
  * ブラウザがリクエストする際、「どこにある」、「何のデータ」かを的確に指定する必要がある

* スキーム(scheme)
  * このURLが指し示すデータが、Webページ用なのか、メール用なのか等を表すもの

* サブドメイン
  * ドメイン名の前につく文字列
  * [サブドメインとは](https://www.nadukete.net/domain-guide/beginners/subdomain.html)

* 使用可能な文字
  * [URLで使用可能な文字、使用できない文字](http://www.ipentec.com/document/web-url-invalid-char)

* フラグメント識別子
  * [フラグメント識別子とは](http://dohow.jp/website/フラグメント識別子とは？/)

* URL, URN(Uniform Resource Name), URI(Uniform Resource Identifier)
  * [URI, URL, URN](https://qiita.com/Yoji0806/items/98cf3ea933ec62e1c20c)
  * [URL と URI の違い](https://qiita.com/Zuishin/items/3bd56117ab08ec2ec818)

## Webサイトに使われるファイルの種類

* HTML
* CSS
* JavaScript
* 画像(JPEG, GIF, PNG, SVG)
  * JPEG
    * 写真またはグラデーションのあるイラストの場合
  * PNG
    * グラフや図、べた塗の面積が大きいイラストの場合
    * 画像にマスクする場合
  * GIF
    * アニメーション(ページが読み込み中であることを示す、ローディングサイン等)
      * ローディングアニメーション、プリローダーともいわれる

  * SVG(Scalable Vector Graphics)
    * ベクター形式の画像(線や塗りの情報が数式で表され、コンピュータが再現して表示する)
    * データの中身はHTMLに似たSVGという言語
    * JavaScriptを使えば、リアルタイムに書き換えることが可能
    * [SVGとは](https://wemo.tech/1517)
* 動画(MP4)
* 音声(MP3)

## Webサイトのファイル・フォルダ構造

* 原則
  * URLができるだけ短くなるように
  * なるべくURLを見るだけでそのページ内容が想像できるようなフォルダ名・ファイル名をつける
  * 階層はできるだけ浅くする

* 例1) HTMLファイルを可能な限りルート階層に置く
  ```txt
  root/ +- index.html
        +- about.html
        +- contact.html
        +- css/
        +- scripts/
        +- images/
  ```
  * 小中規模(1 - 10 page程度)
  * 一目で見やすく管理しやすい
  * ページ数が増えると管理し辛くなる

* 例2) 1ページにつき1つのフォルダを作る
  ```txt
  root/ +- index.html
        +- about/
            +- index.html
            +- images/
        +- contact/
            +- index.html
            +- images/
        +- css/
        +- scripts/
        +- images/
  ```
  * index.htmlはURLから省略可能なので、URLが長くなるわけではない
  * 大規模サイト向き
  * 最近ではindex.htmlを省略したURLのほうが好まれるため、小規模サイトでもこの構成が増えている

* 動的ページ
  * ブラウザからのリクエストがあったときにWebサーバーに設置されたプログラムがHTMLを生成する
  * 動的HTMLページを実現する技術
    * ASP(Active Server Pages), JSP/Servlet, PHP, Perl etc
  * CMS(Content Management System)
    * 作られたHTMLやリソースなどの画像、PDF等を管理する(Word Press, Drupal etc)
    * [CMSの役割](https://noren.ashisuto.co.jp/investigate/1189432_1860.html)
    * [CMSの種類](https://noren.ashisuto.co.jp/investigate/1189454_1860.html)
    * [OSSCSSの比較](https://www.slideshare.net/dgcircus/drupal-72116828)

## ファイル名・フォルダ名

* 命名ルールの例
  * 半角の英単語、数字、または英単語と数字の組み合わせにする
    * 日本語は使えないわけではないが、通常使用しない
  * 英単語はできるだけ簡単なものを使う
  * 英字は小文字のみを使う
  * 単語の区切り文字が必要な場合はハイフンを使う
    * [URLで使用可能な文字、使用できない文字](http://www.ipentec.com/document/web-url-invalid-char)
    * Googleは検索結果に大きな差はないとしつつも、原則として `-` の使用を進めている
      * [Dashes vs Underscores](https://www.youtube.com/watch?v=AQcSFsQyct8)
  * 画像ファイルを保存しておくフォルダ名は `images` or `img` とする
  * CSSファイルを保存しておくフォルダ名は　`css` にし、ファイル名は `style.css`, `main.css` とする
  * JavaScriptファイルを保存しておくフォルダ名は `script` または `scripts` にし、ファイル名は `scripts.js` 等にする

## ブラウザ

* 本格的なWeb制作ではすべてのブラウザをインストールしておくのが一般的
* スマートフォン向けWebサイトの最終的な確認は実機で行ったほうがいい