# 2 基本的な書き方を身に着ける

## 2.1 JavaScriptの基本的な記法

## 2.1.1 JavaScriptで「こんにちは、世界!」

* サンプル参照
* UTF-8は国際化対応にも優れ、HTML5をはじめとしたさまざまな技術で推奨される文字コード
  * その他の文字コードはAjax通信で外部サービスと連携する際、思わぬ不具合、文字化けの原因になる

## 2.1.2 javaScriptをHTMLファイルに組み込む - script要素

* JavaScriptのコードをHTMLファイルに組み込む
  ```html
  <script type="text/javascript">
  // JavaScriptのコード
  </script>
  ```
  HTML5では`text/javascript`がデフォルトになっているため省略可

* script要素を記述する場所
    1. body要素の配下(任意の位置)
      * script要素での処理結果をページに直接出力するために利用する
      * コンテンツとコードが混在するのは、可読性/保守性の観点からのぞましくない
      * 現在ではほぼ使われない(例外を除いて使うべきでない)
    1. body要素の配下(body閉じタグの直前)
      * ページ高速化の手法として末尾に配置(見た目の描画速度が改善する)
        * 一般的なブラウザはスクリプトの読み込みや実行が完了するまで以降の描画を行わない
        * 読み込み・実行に時間がかかるスクリプトはそのままページ描画の遅れに直結する
      * 一般的に、JavaScriptによる処理はページがすべて準備できてから行うべきものであるはずなので弊害もほぼない
    1. head要素の配下
      * (2)で賄えないケース
      * JavaScriptでは関数を呼び出すためのscript要素よりも、関数定義のscript要素を先に記述していなければならない  
        (関数定義、呼び出しが一つのscript要素にまとまっていてもかまわない)
      * body配下で直接呼び出すための関数を定義したい
        ```html
        <head>
          <script>
          function sample() {}
          </script>
        </head>
        <body>
          <a onClick="sample()">Sample</a>
        </body>
        ```

* (2)を基本とし、まかえないときだけ(3)を利用する
  * (1)は外部のウィジェットを埋め込むなどの状況除けばほとんどない
  * https://qiita.com/mikimhk/items/7cfbd6c94d0f3d7aa51f

* 外部スクリプトをインポートする
  ```html
  <script type="text/javascript" src"path" charset="encoding">
  // path: スクリプトファイルへのパス
  // encoding: スクリプトファイルで利用している文字コード
  </script>
  ```

* コード外部化のメリット
  * レイアウトとスクリプトを分離することで、コードを再利用しやすくする
  * スクリプトを外部化することで、htmlファイルの見通しがよくなる  

* 本格的なアプリ開発ではできる限りJavaScriptは外部ファイル化するべき
  * コード部分が非常に短いなどのケースで、外部化したほうがかえって記述が助長になることもある
  * 状況に応じてページインラインでの記法を使い分ける

* 外部スクリプトとインラインスクリプトを併用する場合の注意点
  * 以下のような書き方はできない
    ```html
    <script type="text/javascript" src="lib.js">
    window.alert("hello, world");
    </script>
    ```
  * src属性を指定した場合、script要素配下のコンテンツは無視されるため
    ```html
    <script type="text/javascript" src="lib.js"></script>
    <script>
    window.alert("hello, world");
    </script>
    ```

* JavaScript機能が無効の環境で代替コンテンツを表示させる
  ```html
  <noscript>...</noscript>
  ```
  * 本来、JavaScriptが動作してない場合でも必要最低限のコンテンツを閲覧できるようにデザインするべき
  * JavaScriptに依存せざるを得ない場合には、有効にしたうえでアクセスしてほしい旨をメッセージ表示する

* JavaScript疑似プロトコル
  * アンカータグのhref要素にスクリプトを埋め込む
  ```html
  <a href="JavaScript:window.alert('Hello World.');">リンクテキスト</a>
  ```

* そのほか、特定の要素に対してイベントハンドラーとしてスクリプトを埋め込む方法もある

## 2.1.3 文(Statement)のルール

* 文の末尾にセミコロンをつける
  * 省略することもできる(非推奨)
    * 区切りが不明確になるため、一般的には良いスタイルとはいえない

* 文の途中で空白や改行/タブを含めることも可能
  ```javascript
  window.
    alert
      ('Hello, world');
  ```
  * この場合は改行を加えてもかえってコードが冗長になるだけで意味はない
  * `長い分の場合はコードを見やすくすることができる`
  * 文脈次第では問題が発生する場合がある

* 大文字/小文字が厳密に区別される

* 複数の文を単一行で書くこともできる(非推奨)
  * デバッガなどによるコードの追跡が難しくなる(ステップ機能)

## 2.1.4 コメントを挿入する

* 概要をわかりやすくする
  * 何を目的としたコードなのか
  * 複雑な処理の場合、そのコードが何をしているのか

* コメントの種類
 ```javascript
 // comment
 /* comment */
 /** comment */
 ```

* コメントアウト/コメントイン

* まずは優先的に `//` を使う
  * 終了を表す`*/`が、正規表現リテラルの中で発生する可能性がある
  ```javascript
  /*
  var result = str.match(/[0-9]*/);
  */
  ```

## 2.2 変数/定数

## 2.2.1 宣言

* 宣言
  * 変数の名前をJavaScriptに登録し、かつ値を格納するための領域をメモリ上に確保する
  ```javascript
  // var命令
  var 変数名[=初期値],...
  // 例
  var msg;
  var x, y;
  
  var message = 'Hello, world';
  var x = 10;
  ```

* 厳密には、JavaScriptでは変数の宣言は必須ではない
  * JavaScriptが暗黙的に変数を宣言(=領域を確保)してくれる
  * 後述する理由から、宣言の省略は原則として避けるべき

* let命令
  * ES6で追加される
  ```javascript
  let msg;
  let x, y;
  let greeting = 'Hello, World';
  ```
  * 構文はvarと同じ
  * 違いは？
    * 同名の変数を許可しない(Identifier 'msg' has already been declared)
    * ブロックスコープを認識する
      * let命令のほうがより細かく変数の有効範囲を管理できる

* ES6(ES2015)を利用できる環境では、できるだけlet命令を優先して利用することが推奨される

## 2.2.2 識別子の命名規則

* 識別子：スクリプトを構成する要素につけられた名前のこと
* 最低限知っておくべき命名規則
  * 1文字目は英字/アンダースコア/ドル記号のいずれか：_name, $msg
  * 2文字目以降は、1文字目で使える文字、もしくは数字のいずれか：msg1, _name0
  * 変数名に含まれる英字の大文字/小文字は区別される
  * JavaScriptで意味を持つ予約語でないこと
    * 以下も避けるべき(エラーにはならないが、もともと定義されていた機能が使えなくなる)
      * 将来的に予約語として採用される可能性があるキーワード(enum, await)
      * JavaScriptですでに定義されているオブジェクトやそのメンバー名(String, eval)

* 読みやすいコードのために
  * 名前からデータの中身が類推しやすい
    * o: name, title
    * x: a1, b1
  * 長すぎず、短すぎず
    * o: keyword
    * x: kw, keyword_for_site_search_...
  * 1文字目の「_」は特別な意味を持つ場合があるので使わない
  * あらかじめ決められた記法で統一する
    * x: lastName, first_name, MiddleName
  * 基本的には英単語とする

* 識別子の主な記法
  * camelCase記法 > 変数/関数名
  * Pascal記法 > クラス(コンストラクタ)名
  * アンダースコア記法 > 定数名

## 2.2.3 定数を宣言する

* 途中で中身を変更できない入れ物
* ただの数値は意味をなさない
  * 1.08
  * 一般的にはただの数値(リテラル)は自分以外の人間にとっては意味を持たない謎の値=マジックナンバー
* 同じ値がコードに散在する
  * 1.08というリテラルが散在していたとしたら

* 宣言
  ```javascript
  const 定数名 = 値;
  // 例
  const CONSUMPTION_TAX = 1.08;
  ```

* じつはES2015以前でも利用できた
  * あくまで一部のブラウザによる拡張仕様で、全てのブラウザで利用できるわけではなかった

## 2.3 データ型

* 動的型付け(dynamic typing)
  * まったく意識しなくてよいわけではない
  * 厳密な演算や比較を行う局面ではそれなりにデータ型を念頭に置く必要がある

## 2.3.1 JavaScriptの主なデータ

* JavaScriptで扱うことができる主なデータ型
  * 基本型
    * 数値型(number)
    * 文字列型(string)
    * 真偽型(boolean)
    * シンボル型(symbol, ES2015) 
    * 特殊型(null/undefined)
  * 参照型
    * 配列(array)
    * オブジェクト(object)
    * 関数(function)

* 基本型と参照型の違い
  * 基本型の変数には値そのものが直接に格納される
  * 参照型の変数は参照値(値を実際に格納しているメモリ上のアドレス)を格納する

## 2.3.2 リテラル

* リテラル
  * データ型に格納できる値そのもの、また、値の表現方法

### 数値リテラル

* 数値リテラル
  * 整数リテラル
    * 10進数リテラル: 100
    * 16進数リテラル: 0xFF55cc
    * 8進数リテラル: 0o600
    * 2進数リテラル: 0b11, 0b101
  * 浮動小数点リテラル: 1.5, 3.14e5

* ES6(ES2015)以前のJavaScriptでも「0666」で8進数リテラルを表現できた
  * 標準の機能ではなく、実装によって対応がわかれるため、利用すべきではない

* リテラル接頭語
  * 大文字小文字を区別しない
  * 8進が「0O」だと区別し辛い

* 本質的に違いは見かけ上のものに過ぎない
  * 18, 0b10010, 0o22, 0x12, 1.8e1

### 文字列リテラル

* シングルクォート、ダブルクォート
* エスケープシーケンス(`\+文字`)で表現することができる
  * 特別な意味を持つ文字(キーボートから直接に表現できない文字など)
  ```javascript
  \\ 改行
  window.alert('Hello JavaScript!\nTake it easy.');
  ```

### テンプレート文字列(ES6)

* 以下の文字列表現が可能になる
  * 文字列への変数の埋め込み
  * 複数行にまたがる(=改行文字を含んだ)文字列

* バッククォートで文字列をくくる
  ```javascript
  let name = 'Tanaka';
  let str = `こんにちは、${name}さん。
  強もいい天気ですね。`;
  console.log(str);
  ```
  * コードがシンプルになる(ここでは文字列連結や、エスケープシーケンスが不要になる)

### 配列リテラル

* データの集合
  * カンマ区切りの値をブラケットでくくった形式で表現する
  ```javascript
  var data = ['JavaScript', 'Ajax', 'ASP.NET'];
  console.log(data[0]);

  // 入れ子に配列を持つこともできる
  var data = ['JavaScript', ['jQuery', 'prototype.js'], 'ASP.NET'];
  // 結果：jQuery
  console.log(data[1][0]);
  ```

### オブジェクトリテラル

* オブジェクト
  * 名前をキーにアクセスできる配列
  * ハッシュ、連想配列ともよばれる
  * 配列に対し、文字列をキーにアクセスできるため、データの視認性(可読性)が高いのが特徴
  ```javascript
  var obj = {x:1, y:2, z:3};
  // オブジェクトリテラルの個々のプロパティにアクセス
  // (1)ドット演算子：オブジェクト名.プロパティ名
  console.log(obj.x);
  // (2)ブラケット構文：オブジェクト名['プロパティ名']
  console.log(obj['x']);
  ```
  * ES6では連想配列を専門に扱う仕組みとしてMapが追加された

### 関数リテラル(function)

* JavaScriptでは関数もデータ型の一種として扱われる

### 未定義値(undefined)

* ある変数の値が定義されていないことを表す値
  * ある変数が宣言済みであるものの、値を与えられていない
  * 未定義のプロパティを参照しようとした
  * 関数で値が返されなかった

### ヌル(null)

* 空である状態を表すための値

* 意図した空を返す場合はnull、そうでなければundefined、とまずは理解しておく

## 2.4 演算子

* オペレーター(演算子)
  * 与えられた変数、リテラルに対してあらかじめ決められた何らかの処理を行うための記号

* オペランド(被演算子)
  * 演算子によって処理される変数、リテラル

## 2.4.1 算術演算子

* 前置演算(Pre Increment)/後置演算(Post Increment)

* 小数点を含む計算には要注意
  ```javascript
  // 結果 0.6000000000000001
  console.log(0.2 * 3);
  ```
  * 内部的に数値を2進数で演算しているための誤差
    * Java：https://qiita.com/TKR/items/52635175654b9b818b89
    * 0.2は2進数の世界では0.00110011...という無限循環小数となる
    ```javascript
    // false
    console.log(0.2 * 3 === 0.6);
    ```
    * 厳密に結果を得る必要がある場合
    ```javascript
    // 1. 値をいったん整数にしてから演算する
    // 2. 1.の結果を再び少数に戻す

    // 結果 0.6
    console.log(0.2 * 10 * 3 / 10); 
    // 結果 true
    console.log(0.2 * 10 * 3 === 0.6 * 10);

    // 値を何倍するかは有効桁数によって決まる
    // 例) 0.2351
    // 1. 100倍して23.51としたものを演算する
    // 2. 最終的な結果を小数点以下で四捨五入する
    // 3. 2.の結果を100で除算して、再び小数点数に戻す
    ```
  
## 2.4.2 代入演算子

* 基本型と参照型による代入の違い(`=`演算子)
  * 基本型
    * 互いに別物なので、片方の変更はもう片方には影響しない
  * 参照型
    * 互いに同じ場所を見ているので、片方の変更はもう片方にも影響する

* 定数は「再代入できない」
  ```javascript
  const TAX = 1.08;
  TAX = 1.1; // error
  ```

* 以下は？
  ```javascript
  const data = [1, 2, 3];
  // エラー
  data = [4, 5, 6];
  // そのまま動作する
  data[1] = 10;
  ```
  * 定数は「変更できない(=読み取り専用)」というわけではない

### 分割代入(配列)(destructuring assignment)(ES6)

* 配列・オブジェクトを分解し、配下の要素・プロパティを個々の変数に分解するための構文

* 従来
  ```javascript
  var data = [56, 40, 26, 82, 19, 17, 73, 99];
  var x0 = data[0];
  var x1 = data[1];
  var x2 = data[2];
  // 略
  ```

* 分割代入
  ```javascript
  var data = [56, 40, 26, 82, 19, 17, 73, 99];
  let [x0, x1, x2, x3, x4, x5, x6, x7] = data;
  // 結果：56
  console.log(x0);
  // 略
  // 結果：99
  console.log(x7);
  ```
  * `...`演算子を利用することで、個々の変数に分解されなかった残りの要素をまとめて配列として切り出すことも可能
  ```javascript
  var data = [56, 40, 26, 82, 19, 17, 73, 99];
  let [x0, x1, x2, ...other] = data;
  // 結果：[82, 19, 17, 73,  99]
  console.log(other);
  ```

* 分割代入で変数の入れ替えをすることもできる(一時退避する必要がない)
  ```javascript
  let x = 1;
  let y = 2;
  [x, y] = [y, x];
  ```

* その他用途
  * 関数に名前付きの引数を引き渡す
  * 関数から複数の戻り値を返す

### 分割代入(オブジェクト)(ES6)

* オブジェクトのプロパティを変数に分解することもできる
  ```javascript
  let book = {title:'Javaポケットリファレンス', publish:'技術評論社', price:2680};
  // memoのように、デフォルト値を設定しておくこともできる
  let {price, title, memo = 'なし'} = book;

  // 結果：Javaポケットリファレンス
  console.log(title);
  // 結果：2680
  console.log(2680);
  // 結果：なし
  console.log(memo);
  ```

* 入れ子となったオブジェクトを分解する
  ```javascript
  let book = {
    title:'Javaポケットリファレンス',
    publish:'技術評論社',
    price:2680,
    other: {
      keywd:'Java SE 8',
      logo: 'logo.jpg'
    }
  };
  let { title, other, other:{ keywd }} = book;
  // 結果：Javaポケットリファレンス
  console.log(title);
  // 結果：{ keywd: "Java SE 8", logo:"logo.jpg" }
  console.log(other);
  // 結果：Java SE 8
  console.log(keywd);
  ```

* 変数の別名を指定する
  ```javascript
  let book = { title:'Javaポケットリファレンス', publish:'技術評論社' };
  let { title: name, publish: company } = book;
  // 結果：Javaポケットリファレンス
  console.log(name);
  // 結果：技術評論社
  console.log(company);
  ```

* 宣言のない代入
  ```javascript
  let price, title, memo;
  // 代入
  ({ price, title, memo = 'なし' } = book );
  ```

## 2.4.3 比較演算子

* 等価演算子(==)
  * 値が等しい場合はtrue
  * データ型によってことなる(なんとか等しい止めなせないか、と試みる)
  * 同じ
    * 文字列、数値、論理型
      * 双方の値が等しいかを判定
    * 配列、オブジェクト
      * 参照先が等しいかを判定
    * null、undefined
      * 双方ともnull・undefined、またはnullとundefinedの比較は全てtrue
  * 異なる
    * 文字列、数値、論理型
      * 文字列・論理型を数値に変換したうえで判定
    * オブジェクト
      * 基本型に変換したうえで判定

* 以下はすべてtrue
  ```javascript
  console.log('3.14E2' == 314);
  console.log('0x10' == 16);
  console.log('1' == 1);
  ```

* 同値演算子(===)
  * 値が等しくてデータ型も同じ場合はtrue
  ```javascript
  // 以下はすべてfalse
  console.log('3.14E2' === 314);
  console.log('0x10' === 16);
  console.log('1' === 1);
  ```
  * 寛容さはかえってバグの下になる状況のほうが多いので、できるだけ`===`演算子を利用することを推奨する

## 2.4.4 論理演算子

* 以下の値も暗黙的にfalseとみなされる
  * 空文字列
  * 数値の0, NaN(Not a Number)
  * null, undefined
  * 「falsyな値」と呼ぶこともある
  * 上記以外の値がすべてtrueとみなされる

* ショートカット演算(短絡演算)
  * 以下は等価
  ```javascript
  if (x === 1) { console.log('こんにちは'); }
  x === 1 && console.log('こんにちは');
  ```
  * 原則として避けるべき
    * 条件分岐であることが一見してわかりにくいから
    * 右式が実行されるかどうかがあいまいになるため、思わぬバグの温床になりかねない
  * ショートカット演算の使いどころ
  ```javascript
  var msg = '';
  // msgがfalsyな値だった場合、デフォルト文を代入する
  msg = msg || 'こんにちは、世界！';
  // msg = (msg === undefined ? 'こんにちは、世界!' : msg);
  console.log(msg);
  ```

## 2.4.5 ビット演算子

## 2.4.6 その他の演算子

* その他の演算子
  * ,(カンマ)
    * 左右の式を続けて実行
  * delete
    * オブジェクトのプロパティや配列の要素を削除
      * 配列の要素を削除した場合、該当する要素が削除されるだけで、インデックス番号は変わらない
      * プロパティそのものが削除されるだけで、プロパティが参照するオブジェクトが削除されるわけではない
      * 明示的に宣言された変数を削除することはできない
      ```javascript
      var data1 = 1;
      console.log(delete data1); // false
      console.log(obj); // 1

      data2 = 10;
      console.log(delete data2); // true
      console.log(data2); // error(data2は存在しない)
      ```
  * instanceof
    * オブジェクトが指定されたクラスのインスタンスかを判定
  * new
    * 新しいインスタンスを生成
  * typeof
    * オペランドのデータ型を取得
      * 配列、オブジェクト、ラッパーオブジェクトはいずれも`object`
      ```javascript
      var num = 1;
      console.log(typeof num); // number
      ```
  * void
    * 未定義値を返す

## 2.4.7 演算子の優先順位と結合則

### 結合則

* 演算子を左から右、右から左いずれの方向で結合するか

## 2.5 制御構文

## 2.5.1 if命令

* 紛らわしい
  ```javascript
  var x = 1;
  var y = 2;
  if (x === 1)
    if (y === 1) console.log('変数x, yはともに1です');
  else
    console.log('変数xは1ではありません。');
  
  // '変数xは1ではありません。'　が表示される
  ```

## 2.5.2 switch命令

* `同値演算子(===)`による多岐分岐
* 同じような条件式を繰り返し記述しなくてもよい分、コードが読みやすくなる
  ```javascript
  switch(式) {
    case 値1:
      ...
    case 値2:
      ...
    ...
    default:
      ...
  }
  ```
* フォールスルー

## 2.5.3 while命令

* 後置判定、前置判定

## 2.5.4 無限ループ

* ブラウザに極端な負荷を与える

## 2.5.5 for命令

* カンマ演算子
  ```javascript
  for (var i = 1, j = 1; i < 5; i++, j++) {
    console.log(i * j);
  }
  // 1, 4, 9, 16
  ```
  * ごく単純な場合に限る(多用すべきでない)

## 連想配列(オブジェクト)の要素を順に処理する(for...in命令)

* 構文
  ```javascript
  for (仮遠陬 in 連想配列) {
    命令群
  }
  ```
  * 仮変数に格納されるのが要素値そのものでないことに注意
  ```javascript
  var data = {
    apple: 150,
    orange: 100,
    banana: 120
  };

  // dataのキー名を順に取り出し、変数keyにセットしながらループを繰り返す
  for (var key in data) {
    console.log(key + '=' + data[key]);
  }
  // apple=150
  // orange=100
  // banana=120
  ```

* 配列ではfor...in命令は利用しない(可能ではある)
  ```javascript
  var data = ['apple', 'orange', 'banana'];
  Array.prototype.hoge = function() {}
  for (var key in data) {
    console.log(data[key]);
  }
  // 結果：apple, orange, banana, function(){}
  ```

* for...in命令では処理の順序も保証されない

* 仮変数にはインデックス番号が格納されるだけなので、シンプルにはならない
  * 値そのものではないので、かえって誤解を招く

* 連想配列(オブジェクト)を操作するにとどめ、配列の列挙にはfor命令、もしくはfor...of命令を使用するべき

* 初期化式で配列のサイズを取得する
  ```javascript
  var data = ['apple', 'orange', 'banana'];
  // for (var i = 0; i < data.length; i++) {...} でもかける
  for (var i = 0, len = data.length; i < len; i++) {
    console.log(data[i]);
  }
  // 結果：apple, orange, bananaを順に出力
  ```
  * ループの都度、プロパティにアクセスしなければならないため、性能が劣化する
  * 対象が配列ではなく、NodeListオブジェクトである場合、IE7などのレガシーブラウザでは影響が顕著

## 配列などを順に処理する(for...of命令) (ES6)

* 配列、オブジェクト(NodeList, argumentsなど)、イテレーター/ジェネレータ(列挙可能なオブジェクト)
  ```javascript
  for (仮変数 of 列挙可能なオブジェクト) {
    ループ内で実行する命令
  }
  ```
  ```javascript
  var data = ['apple', 'orange', 'banana'];
  Array.prototype.hoge = function() {}
  for (var value of data) {
    console.log(value);
  }
  // 結果：apple, orange, bananaを順に出力
  ```
  * for...in命令では仮変数にキー名(インデックス番号)が渡されていたのに対し、値を列挙している

## 2.5.8 ループを途中でスキップ/中断(break/continue)

### ネストされたループを一気に脱出する(ラベル構文)

* 一度、積が30を超えたら、九九表の出力そのものを停止したい
  ```javascript
  kuku:
  for (var i = 1; i < 10; i++) {
    for (var j = 1; j < 10; j++) {
      var k = i * j;
      if (k > 30) {
        break kuku;
      }
      document.write(k + '&nbsp');
    }
    document.write('<br>');
  }
  ```

* ループ内でswitchを使う場合は要注意

## 2.5.9 例外を処理する(try...catch...finally命令)

* 呼び出し側に起因する処理では、例外の発生を完全に防ぐことはできない
  ```javascript
  try {
    ...
  } catch(例外情報を受け取る変数) {
    例外が発生したときに実行される命令
  } finally {
    例外の有無にかかわらず、最終的に実行される命令
  }
  ```
  ```javascript
  var i = j;
  try {
    i = i * j;
  } catch(e) {
    // Errorオブジェクト
    // j is not defined
    console.log(e.message);
  } finally {
    console.log('処理は完了しました');
  }
  ```

* 例外処理はオーバーヘッドが大きい
  * ループ処理の中でtry..catchブロックを記述するのは避けるべき

* 例外を発生させる
  ```javascript
  var x = 1;
  var y = 0;

  try {
    if (y === 0) {
      throw new Error('0で除算しようとしました。');
    }
    var z = x / y;
  } catch(e) {
    console.log(e.message);
  }
  ```
  * throw 命令
  ```javascript
  throw new Error(エラーメッセージ)
  ```

* Errorオブジェクトの代わりに以下を使うことができる
  * EvalError
    * 不正なeval関数
  * RangeError
    * 指定された値が許容範囲を超えている
  * SyntaxError
    * 文法エラー
  * TypeError
    * 指定された値が期待されたデータ型ではない
  * URIError
    * 不正内URI

## 2.5.10 JavaScriptの危険な構文を禁止する(Strictモード) (IE9)

* 仕様としては存在するが、現在では安全性や効率面で利用すべきでない構文が存在する
  * 以前は、落とし穴を開発者が学んで、避けるようにコーディングしなければならなかった
  * Strictモードは、JavaScriptの落とし穴を検出し、エラーとして通知してくれる仕組み

* Strictモードによる制限(変数)
  * var命令の省略を制限
  * 将来的に追加予定のキーワードを予約語に追加
  * 引数/プロパティ名の重複を禁止
  * undefined/nullへの代入禁止

* Strictモードによる制限(命令)
  * with命令の利用を禁止
  * arguments.calleeプロパティへのアクセスを禁止
  * eval命令で宣言された変数を、周囲のスコープに拡散しない

* メリット
  * 非Strictモードのコードよりも高速に動作する場合がある
  * 将来のJavaScriptで変更される点を禁止することで、今後の移行が簡単になる
  * JavaScriptの「べからず」を理解する手掛かりになる

* スクリプトの先頭、もしくは関数の先頭に追加
  ```javascript
  // "use strict"; でも可能
  'use strict';
  // 任意のコード
  ```
  ```javascript
  function hoge() {
    'use strict';
    // 任意のコード
  }
  ```

* Strictモードの対応ブラウザ
  * IEではバージョン10以降でのみ対応
  * 新規の開発では、できるだけStrictモードを有効にすることが推奨される

* 外部スクリプトを非同期にロードする(async/defer属性)
  * 一般的なブラウザではスクリプトの読み込み/実行が完了するまで、以降のコンテンツを描画しない
  * body閉じタグの直前に記述する以外に、モダンブラウザが対象ならばasync属性(HTML5)を利用してもよい
  ```html
  <script src="lib.js" async></script>
  <script src="app.js" async></script>
  ```
  * ただし、実行順序が保証されない
    * asyncの代わりにdefer属性を指定するとよい
    * スクリプトの実行を文書の解析終了後まで遅延させる