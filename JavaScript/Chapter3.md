# 3 基本データを操作する -組み込みオブジェクト -

## 3.1 オブジェクトとは

* 1つのものを表現するために、複数の属性情報を持つ(もの全体が主体)

* 連想配列として使い分ける場合、それぞれの意味合いは全く違う
  * 連想配列 = 複数要素の集合体

* オブジェクト指向
  * プログラム上で扱う対象をオブジェクト(モノ)に見立てて、オブジェクトを中心としてコードを組み立てていく手法

## 3.1.1 オブジェクト=プロパティ+メソッド

## 3.1.2 オブジェクトを利用するための準備 -new演算子-

* オブジェクト指向の世界では、後述する例外を除いて、もともと用意されたオブジェクトを直接利用することを認めていない
  * オリジナルのオブジェクトには手を加えず、複製したコピーを操作することで競合を防ぐ(インスタンス化)

* インスタンス化
  ```javascript
  // 初期化メソッドのことをコンストラクターという
  var 変数名 = new オブジェクト名(引数...);
  ```

## 3.1.3 静的プロパティ/静的メソッド

* インスタンス化せずに利用できる
  * 理由については、5.2.6項
  * インスタンス変数から呼び出すとエラー

* 静的プロパティ/静的メソッド ⇔ インスタンスプロパティ/インスタンスメソッド

## 3.1.4 組み込みオブジェクト

* 組み込みオブジェクト(Built-in Object)
  * 多くのオブジェクトが公開されている中の最も基本的なもの

* 本書で扱うJavaScript
  * コアJavaScript(全てのJavaScript環境で利用可能)
    * 制御構文、関数、オブジェクトなどの基本機能
    * 組み込みオブジェクト(基本機能を備えたオブジェクト)
      * Array, Date, String, RegExp, Number, Error ...
  * 特定の環境でのみ利用可能な機能
    * ブラウザーオブジェクト(ブラウザー環境で利用可能なオブジェクト)
      * Window, Navigator, Location, History ...
    * DOMオブジェクト(HTML/XML操作のためのオブジェクト群)
    * その他

* オブジェクト
  * (Global)
  * Object
  * Array
  * Map/WeakMap(ES6)
    * 連想配列を操作するための手段を提供
  * Set/WeakSet(ES6)
    * 一意な値の集合を管理するための手段を提供
  * String
  * Boolean
  * Number
  * Function
  * Symbol(ES6)
    * シンボルを操作するための手段を提供
  * Math
  * Date
  * RegExp
  * Error/XxxxxError
  * Proxy(ES6)
    * オブジェクトの挙動をカスタマイズする手段を提供
  * Promise(ES6)
    * 非同期処理を実装するための手段を提供

* 基本データ型ではnew演算子を利用しない
  ```javascript
  // 生成することは可能
  var str = new String('Hello !');
  ```
  * ほとんどの場合、冗長であるだけでむしろ有害
  ```javascript
  var flag = new Boolean(false);
  if (flag) {
      console.log('flagはtrueです');
  }
  // 結果：flagはtrueです
  ```
  * `JavaScriptがnull以外のオブジェクトをtrueとみなす`ためにおこる挙動
  * `基本データ型をnew演算子を使ってインスタンス化するのは原則として避けるべき`

* ラッパーオブジェクト
  * 組み込みオブジェクトの中でも特に基本県である文字列、数値、論理値を扱うためのオブジェクト
  * 単なる値に過ぎない基本型のデータを包み(ラップして)、オブジェクトとしての機能(メソッド)を追加するためのオブジェクト

* JavaScriptは基本データ型とラッパーオブジェクトを自動的に相互変換するため、開発者がこれを意識する必要はない

## 3.2 基本データを扱うためのオブジェクト

## 3.2.1 文字列を操作する Stringオブジェクト

* 文字列型(string)の値を扱うためのラッパーオブジェクト

* 文字列の抽出や加工、検索
  * 検索
    * indexOf(substr[,start])
    * lastIndexOf(substr[,start])
    * startsWith(search[,pos]):(ES6)
    * endsWith(search[,pos]):(ES6)
    * includes(search[,pos]):(ES6)
  * 部分文字列(抽出)
    * charAt(n)
    * slice(start[,end])
    * substring(start[,end])
    * substr(start[,cnt])
    * split(str[,limit])
  * 正規表現
    * match(reg)
    * replace(reg, rep)
    * search(reg)
  * 大文字/小文字
    * toLowerCase()
    * toUpperCase()
  * コード変換
    * charCodeAt(n): n+1番目の文字をLatin-1コードに変換
    * codePointAt(n): n+1番目の文字をUTF-16エンコードされたコードポイント値に変換(ES6)
  * その他
    * concat(str)
    * repeat(n):文字列をn回だけ繰り返したものを取得(ES6)
    * trim()
    * length

* サロゲートペア文字の長さをカウントする
  * lengthプロパティは日本語(マルチバイト文字)も1文字としてカウントする
  ```javascript
  var msg = '𠮟る';
  console.log(msg.length); // 3
  ```
  * サロゲートペア
    * Unicode(UTF-8)は1文字2Byte
    * 2Byteで表現できなくなってきたため、4Byteで表現することで扱える文字数を拡張した
    * 「𠮟」が4Byte=2文字、「る」が1文字
  * 正しくカウントするには
  ```javascript
  var msg = '𠮟る';
  var len = msg.length;
  // [上位サロゲート(前半の2Byte)][下位サロゲート(後半の2Byte)]
  var num = msg.split(/[\uD800-\uDBFF][\uDC00-\uDFFF]/g).length - 1;
  console.log(msg.length - num);
  ```

## 3.2.2 数値を操作する -Numberオブジェクト-

* 数値型(number)の値を扱うためのラッパーオブジェクト
  * 数値整形の機能、読み取り専用プロパティなど

* プロパティ
  * *MAX_VALUE
  * *MAX_SAFE_INTEGER:(ES6)
  * *MIN_VALUE
  * *MIN_SAFE_INTEGER:(ES6)
  * *EPSILON
  * *NaN
  * *NEGATIVE_INFINITY
  * *POSITIVE_INFINITY

* メソッド
  * toString(rad)
  * toExponential(dec)
  * toFixed(dec)
  * toPrecision(dec)
  * *isNaN(num):(ES6)
  * *isFinite(num):(ES6)
  * *isInteger(num):(ES6)
  * *isSafeInteger(num):(ES6)
  * *parseFloat(str):(ES6)
  * *parseInt(str[,radix]):(ES6)

* Numberオブジェクトの定数
  * POSITIVE_INFINITY/NEGATIVE_INFINITY
    * JavaScriptで表現可能な数値の範囲を超えた場合の戻り値として利用される
  * NaN(Not a Number)
    * 「0を0で除算した」など不正な演算が行われた場合などに数値として表現できない結果を表すために使用される
    * `自分自身を含む全ての数値と等しくない` 性質を持つ
    ```javascript
    console.log(Number.NaN === Number.NaN); // false
    ```
    * NaNを検出するには、`Number.isNaN`を使用する必要がある
  * MAX_SAFE_INTEGER/MIN_SAFE_INTEGER
    * 安全に演算できる範囲の整数値の上限/下限を表す
    ```javascript
    console.log(Number.MAX_SAFE_INTEGER + 1); // 9007199254740992
    console.log(Number.MAX_SAFE_INTEGER + 2); // 9007199254740992(不正)
    ```

* 数値形式を変換する`toXxxxxメソッド`
  ```javascript
  var num1 = 255;

  num1.toString(16); // ff
  num1.toString(8); // 377

  var num2 = 123.45678
  console.log(num2.toExponential(2)); // 1.23e+2
  console.log(num2.toFixed(3)); // 123.457
  console.log(num2.toFixed(7)); // 123.4567800
  console.log(num2.toPrecision(10)); // 123.4567800
  console.log(num2.toPrecision(6)); // 123.457
  ```

* 文字列を数値に変換する(ES6)
  * JavaScriptはデータ型に寛容な言語だが、自動変換が時として思わぬバグの温床となるときがある
  * 明示的にデータ型を変換する
  ```javascript
  console.log(Number(n));
  console.log(Nubmer.parseFloat(n));
  console.log(Nubmer.parseInt(n));
  ```
  * Globalオブジェクトの同名のメンバーとして提供されていたが、Numberに集約された
    * 今後はNumberオブジェクトのそれを優先的に利用すること

* 算術演算子による文字列/数値の変換
  ```javascript
  // 文字列連結の性質(自動で文字列型に変換)
  console.log(typeof(123 + '')); // string
  // 減算の性質(自動で数値型に変換)
  console.log(typeof('123' - 0)); // number
  ```

* 論理型への変換
  ```javascript
  var num = 123;
  // ! 演算子はオペランドとして論理型を要求する
  console.log(!!num); // true
  ```

## 3.2.3 シンボルを作成する Symbolオブジェクト(ES6)

* シンボル(モノの名前)を作成するための型

* シンボルの性質
  ```javascript
  // シンボルの作成(Symbol命令：new演算子ではない > TypeError)
  let sym1 = Symbol('sym');
  let sym2 = Symbol('sym');

  console.log(typeof sym1); // symbol
  console.log(sym1.toString()); // Symbol(sym)
  console.log(sym1 === sym2); // false

  console.log(sys1 + ''); // Cannot convert a Symbol value to a string
  ```

* シンボルを定数の値として利用する
  ```javascript
  // 従来
  const MONDAY = 0;
  const TUESDAY = 1;
  ...
  const SUNDAY = 6;

  // エラーにはならない
  if (week === MONDAY) {...};
  // 可読性を考えれば0で比較するのは望ましくな
  // JANUARY = 0 のような定数が現れた場合に同じ値の定数が同居するのはバグ混入のもと
  if (week === 0) {...};
  ```
  * シンボルを利用する
  ```javascript
  const MONDAY = Symbol();
  ...
  const SUNDAY = Symbol();
  ```
  * 同名であってもユニークになる(引数を渡した場合も同様)
  * その他、プライベートプロパティ、イテレータを定義するためにシンボルを利用することもできる

## 3.2.4 基本的な数学演算を実行する -Mathオブジェクト-

* ES6で追加
  * 基本
    * clz32(num)
    * sign(num): 指定した値が整数の場合は1、負数の場合は-1、0の場合は0
  * 切り上げ/切り捨て
    * trunc(num): 小数部分を単純に切り捨て
  * 平方根
    * cbrt(num): 立方根
    * hypot(x1, x2, ..): 引数の二乗和の平方根
  * 三角関数
    * cosh(num), sinh(num)など：ハイパーボリック系
  * 対数/指数関数
    * log10(num), exp(num)など：対数、指数系

* with命令
  * 同じオブジェクトを繰り返し呼び出す場合、コードがシンプルになる
  ```javascript
  with(console) {
      log(Math.abs(-100);
      log(Math.max(20, 40, 60);
      log(Math.min(20, 40, 60);
      ...
  }
  ```
  * デメリット
    * ブロック内の処理速度が低下する
    * そもそもコードが読みにくくなる(=withによって修飾されるメソッドがあいまいになりやすい)
  * 実際のアプリで使うべきではない

## 3.3 Array/Map/Setオブジェクト

* Map/SetはES6で追加

* Array
  * インデックスで管理
  * 重複OK

* Map
  * キー/値の組で管理
  * キーの重複NG

* Set
  * 値に順番はない
  * 値の重複はNG

## 3.3.1 配列を操作する

```javascript
// 初期化
var ary = ['sato', 'takae', 'nagata'];
var ary = new Array('sato', 'takae', 'nagata');
var ary = new Array();
// 曖昧になりやすい(要素の長さ？要素そのもの？)
var ary = new Array(10);
// 曖昧さを回避するため、最大限配列リテラルを利用したほうが良い
var ary = [];
```

* 破壊的なメソッド
  * その実行によってオブジェクト(ここでは配列)そのものに変更を及ぼすメソッドのこと
  * reverse/sortなどのメソッドは、戻り値としても並べ替え後の配列を返すが、元の配列もソートされているので注意