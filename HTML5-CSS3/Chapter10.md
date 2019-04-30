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

### フルーイドデザイン

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

### メディアクエリ

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