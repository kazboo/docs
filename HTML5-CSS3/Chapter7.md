# テーブル

## テーブルを作成する

テーブルを使うべきコンテンツは？

### 基本的なテーブルのマークアップ

* table: テーブルの親要素
* tr: テーブルの行
* th: テーブルの列(セル)、見出し
* td: テーブルの列(セル)、データ、通常のセル
* th, td の中にはどんなタグでも含めることができる
* テーブルの各列の幅は、コンテンツが収まる最小限の長さに自動調整される
  * 基本的に自動調整に任せておくほうが良い
  * `ウィンドウサイズの違いに対応しやすくなり、レスポンシブWebデザインとの相性も良くなる`

### 最低限テーブルらしく見せるためのCSS

```css
table {
    border-collapse: collapse;
}
th, td {
    border: 1px solid #8fbac8;
    padding: 8px;
}
```

* border-collpaseプロパティ
  * 罫線をセルごとに引くか、セルの間を一本にまとめるかを指定する

* テーブルのボックスモデルは特殊
  * table
    * margin:適用可
    * border:適用可
    * padding:適用不可
  * tr
    * borderのみ適用可
  * th, td
    * margin:tableにborder-collapse:separateが適用されているときのみ可
    * border:適用可
    * padding:適用可

### セルを横方向に結合する

* colspan属性
  * td or th 要素

* テーブル行に一本だけ罫線を引く
  ```css
  .checkout .total {
      border-top: 1px solid #8fbac8;
  }
  ```

* 実体参照
  * HTML要素のコンテンツに使用できない文字(`", <, >, $`)、文字化けする可能性がある文字(￥マーク、バックスラッシュ)
    * ダブルクォート : `&quot;`
    * 円記号：`&yen`
    * コピーマーク：`&copy`

### セルを縦方向に結合する

* rowspan属性
  * td or th 要素

* セルに背景を指定する
  * table tr td(th) の順に塗りつぶされる

## アクセシビリティを考慮したテーブル

### アクセシビリティの重要性

* アクセシビリティの重要性
  * Webサイトにおけるアクセシビリティ
    * どんな人でも等しく情報を取得できること
    * 目が見えない、視力が弱い、高齢者 etc
  * 可能な範囲でアクセシビリティを向上させる対策をとることは可能
  * 取り組みやすい対策 
    * img要素にalt属性をつけること
    * テーブルのアクセシビリティを向上させること

* テーブルのアクセシビリティを向上
  * テーブルにキャプションをつける
  * 見出しセルとデータセルの関連性を明確にする

### テーブルにキャプションをつける

* captionタグをつかう
  ```html
  <table>
    <caption>ホテルの予約状況</caption>
    <tr>
      <th>宿泊施設</th>
      <th>6日</th>
      <th>7日</th>
      <th>8日</th>
    </tr>
    <tr>
      <td>グランドホテル</td>
      <td>〇</td>
      <td>〇</td>
      <td>×</td>
    </tr>
  </table>
  ```
  * 必ずtable開始タグのすぐ次の行に書く
  * 可能な限り記載すること
  * スクリーンリーダーに読ませると実感する(わかりやすさが全然違う)


### 見出しセルと通常セルを関連付ける その1

* スクリーンリーダーは基本的にテーブルをセルごとに読み上げる
  * 土の見出しに関連したものかわかりやすくする

* 見出しセルにid属性、通常セルにheaders属性をつけておく(全てのブラウザが対応しているわけではない)
  * その2の方法と比較して、複雑なテーブルでも正確に関係性を記述できる
  ```html
  <table>
    <caption>...</caption>
    <tr>
      <th id="row1">宿泊施設</th>
      <th id="row2">6日</th>
    </tr>
    <tr>
      <td headers="row1">グランドホテル</td>
      <th headers="row2">〇</td>
    </tr>
    <tr>
      <td headers="row1">ホテルバークサイド</td>
      <td headers="row2">×</td>
    </tr>
  </table>
  ```
  * tdのheaders属性
    ```html
    <td headers="関連する見出しのid名 関連する見出しのid名 ...">
    ```

### 見出しセルと通常セルを関連付ける その2

* 見出しセル(th)にscope属性を追加する方法
  ```html
  <table>
    <caption>caption</caption>
    <tr>
      <th scope="col">...</th>
      <th scope="col">...</th>
      <th scope="col">...</th>
    </tr>
    <tr>
      <td>グランドホテル</td>
      <td>〇</td>
      <td>〇</td>
    </tr>
  </table>
  ```

* th要素のscope属性
  * その見出しに関連する通常セルが同じ列(col)の方向にあるのか、同じ行(row)の方向にあるのかを示す

* 読み上げ機能をテストするには
  * OS搭載の読み上げ機能
    * Windows8以降のナレーター
      * Win + Enter
    * Windows10
      * Win + Ctrl + Enter
    * Mac, iOSのVoiceOver
    * AndroidのTalkBack

## テーブルのデザインバリエーション

* テーブルに使われるお決まりのテクニック

### 偶数行・奇数行で背景色を変える

* 奇数行にだけ背景色を指定する
  ```html
  <style>
  .price tr:nth-child(odd) {
      background: #e3ecf5;
  }
  </style>
  <table class="price">
    <caption>...</caption>
    <tr>
      <th>room</th>
      <th>day</th>
    <tr>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>

      <td>...</td>
      <td>...</td>
    </tr>
  </table>
  ```

* :nth-child(n)セレクタ
  * ()内の条件式にあうものだけを選択する

* :nth-child(n)セレクタの書式例  
  :より前にあるセレクタで選択された要素のうち、指定の要素を選択する(n =  0, 1, 2, 3, ...)
  * :nth-child(odd)
  * :nth-child(even)
  * :nth-child(2n)
  * :nth-child(2n+1)
  * :nth-child(3n)
  * :first-child
  * :last-child

### 横スクロール可能なテーブルにする

* 横スクロール可能なテーブルにする
  * テーブルは横にも縦にも大きくなるため、スマートフォンのような小さな画面での表にはあまり向いていないい
    * 基本的にスマホでは避けるべき

* どうしてもスマートフォンでテーブルを表示させる必要がある場合は、テーブルを横スクロールできるようにするのが一般的
  ```html
  <style>
  .table-wrapper {
      overflow-x: scroll;
  }
  table {
      border-collapse: collapse;
  }
  .price {
      width: 1000px;
  }
  .price caption {
      text-align: left;
  }
  .price th, td {
      border: 1px solid #8fbac8;
      padding: 8px;
  }
  .price th {
      white-space: nowrap;
  }
  </style>
  <div class="table-wrapper">
    <table class="price">
    <caption>...</caption>
    <tr>
      <td>...</td>
      <th>...</th>
      <th>...</th>
    </tr>
    <tr>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    </table>
  </div>
  ```

* overflow-xプロパティ
  * その要素のコンテンツがボックスの横方向からはみ出たときの表示方法を決めるもの
  * 通常、インラインでもブロックボックスでもコンテンツが収まるように幅も高さもサイズが調整される
    * width, heightプロパティなどで固定されている場合、コンテンツがはみ出る

* overflow
  * overflow-x
  * overflow-y
  * 指定値
    * visible
      * ボックスを無視して表示
    * scroll
      * スクロール可能にする
    * hidden
      * 表示しない

* white-spaceプロパティ
  * ソース中のホワイトスペース（連続する半角スペース・タブ）・改行の表示方法を指定する際に使用する
  * 指定値(ホワイトスペース、改行表示、ボックスサイズ指定時の自動改行)
    * normal
      * o, 半, o
    * pre
      * o, o, x
    * nowrap(どうしても改行したくないときなどに使う)
      * x, 半, x
    * pre-wrap
      * o, o, o
    * pre-line
      * x, o, o
  * [参考:white-space](http://www.htmq.com/style/white-space.shtml)