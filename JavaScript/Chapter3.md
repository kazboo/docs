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

* スタックとキュー
  * push/pop/shift/unshift

* ユーザー定義関数で独自の処理を組み込めるメソッド
  * Arrayオブジェクトでは引数に対してユーザー定義関数を指定できるメソッドが用意されている
  * cf) コールバック

* 無名関数の理解が前提

* 1) 配列の内容を順に処理する forEachメソッド
  ```javascript
  array.forEach(callback [,that])
  // array: 配列オブジェクト
  // callback: 個々の要素を処理するための関数
  // that: 関数callbackの中でthis(5.1.5項)が示すオブジェクト
  ```
  ```javascript
  var data = [2, 3, 4, 5];
  data.forEach(function(value, index, array) {
      console.log(value * value); // 結果：4, 9, 16, 25
  });
  ```
  * 配列の要素を順に取り出して、ユーザー定義関数callbackに渡していく
    * value: 要素の値
    * index: インデックス番号
    * array: 元の配列

* 2) 配列をしてされたルールで加工する(mapメソッド)
  ```javascript
  array.map(callback [.that])
  ```
  ```javascript
  var data = [2, 3, 4, 5];
  var result = data.map(function(value, index, array) {
      return value * value;
  });

  // 結果: [4, 9, 16, 25]
  console.log(result);
  ```

* 3) 配列に条件に合致した要素が存在するかを確認する(someメソッド)
  ```javascript
  array.some(callback[.that])
  ```
  ```javascript
  var data = [4, 9, 16, 25];
  var result = data.some(function(value, index, array) {
      return value % 3 === 0;
  })
  if (result) {
      console.log('3の倍数が見つかりました。');
  } else {
      console.log('3の倍数は見つかりませんでした。');
  }
  ```
  * every = 全て合致するか

* 4) 配列の内容を特定の条件で絞りこむ(filter)
  ```javascript
  array.filter(callback [.that])
  ```
  ```javascript
  var data = [4, 9, 16, 25];
  var result = data.filter(function(value, index, array) {
      return value % 2 === 1;
  });

  // 結果：[9, 25]
  console.log(result);
  ```

* 独自のルールで配列を並べ替える(sortメソッド)
  ```javascript
  var ary = [5, 25, 10];
  console.log(ary.sort());
  // 結果：[10, 25, 5] (文字列としてソート)
  console.log(ary.sort(function(x, y) {
      return x - y;
  }))
  // 結果：[5, 10, 25] (数値としてソート)
  ```

* オブジェクト配列のソート
  ```javascript
  // 部長 > 課長 > 主任 > 担当　の順にソートする
  var classes = ['部長', '課長', '主任', '担当'];
  var members = [
      {
          name:'Suzuki',
          clazz:'主任'
      },
      {
          name:'Yamaguchi',
          clazz:'部長'
      },
      {
          name:'Inoue',
          clazz:'担当'
      },
      {
          name:'Wada',
          clazz:'課長'
      },
      {
          name:'Komori',
          clazz:'担当'
      }

  ];

  console.log(
      members.sort(function(x, y) {
          return classes.indexOf(x.clazz) - classes.indexOf(y.clazz);
      })
  )
  ```

## 3.3.2 連想配列を操作する(Mapオブジェクト) (ES6)

* 従来は、オブジェクトリテラルで連想配列を管理するのが基本だった

* Mapオブジェクトの主なメンバー
  * size
  * set(key, val)
  * get(key)
  * has(key)
  * delete(key)
  * clear()
  * keys()
    + 全てのキーを取得
  * values()
    + 全ての値を取得
  * entries()
    + 全てのキー/値を取得
  * forEach(fnc, [,that])
    + マップ内の要素を関数fncで順に処理

* Example
  ```javascript
  // Mapオブジェクトに値を追加
  let m = new Map();
  m.set('dog', 'わんわん');
  m.set('cat', 'にゃー');
  m.set('mouse', 'ちゅー');

  // キー/値を順に取得
  // for (let [key, value] of m.entries()) と同じ
  for (let [key, value] of m) {
      console.log(value);
  }
  ```

* オブジェクトリテラルとの違い
  + 任意の型をキーとして利用できる
    - オブジェクト、NaN等もなりえる
  + マップのサイズを取得できる
    - オブジェクトリテラルでは`for...in`ループなどでカウントする
  + クリーンなマップを作成できる
    - オブジェクトリテラルは実体がObjectオブジェクト
    - 標準のプロパティ(キー)が存在している(createメソッドを利用すれば空にすることはできる)

* キーにかかわる3つの注意点
  + キーは`===`で比較される
  + 特別なNaNは特別ではない
    - Mapの世界は、例外的に`NaN===NaN`とみなされる
  + オブジェクトの比較は要注意
    ```javascript
    var m = new Map();
    m.set({}, 'hoge');
    // 結果：undefined
    console.log(m.get({}));
    // 異なる場所で生成されたオブジェクトなので
    ```
    - 正しくやるならば
    ```javascript
    var key = {};
    var m = new Map();
    m.set(key, 'hoge');
    // 結果：hoge
    console.log(m.get(key));
    ```

## 3.3.3 重複しない値の集合を操作する(Setオブジェクト) (ES6)

* キーを弱参照で管理する(WeakSet/WeakMapオブジェクト)
  + キーは参照型でなければならない
  + 列挙できない(必要であれば、自分で管理)
  + 弱参照
    - このマップ以外でキーが参照されなくなると、そのままGCの対象になる
    - 標準のMap/Setではいわゆる強参照でキーを管理する(キーを保持してる限り対象にならない)

## 3.4 日付/時刻データを操作する(Dateオブジェクト)

## 3.4.1 Dateオブジェクトを生成する

```javascript
var d = new Date();
// 他にも「Sun Dec 04 2016 20:07:15」
var d =new Date('2016/12/04 20:06:15');
var d = new Date(2016, 11, 4, 20, 07, 15, 500);
// 1970/01/01 00:00:00 からの経過ミリ秒(タイムスタンプ値)
var d = new Date(1480849635500);
```

* Dateオブジェクトのメンバー
  ```javascript
  var dat = new Date(2016, 11, 25, 11, 37, 15, 999);
  // Sun Nov 25 2016 11:37:15 GMT+0900
  console.log(dat);
  // 2016
  console.log(date.getFullYear());
  // 11
  console.log(date.getMonth());
  // 25
  console.log(date.getDate());
  // 0
  console.log(date.getDay());
  // 11
  console.log(date.getHours());
  // 2
  console.log(date.getUTCHours());
  // 2016-11-25T02:37:15.999Z
  console.log(date.toJSON());
  // 1480849635500
  console.log(date.getTime());
  ```

## 3.4.2 日付/時刻値を加算/減算する

* Dateオブジェクトでは、日付/時刻を直接加算/減算するためのメソッドは用意されていない
  ```javascript
  var dat = Date.now();
  dat.setMonth(dat.getMonth() + 3);
  ```

## 3.4.3 日付/時刻の差分を求める

* 直接の機能を提供していない
    ```javascript
    var date1 = new Date('2019/10/25 12:12:12.999');
    var date2 = new Date('2019/10/30 12:12:12.999');
    var diffTime = date2.getTime() - date1.getTime();

    console.log(diffTime / (1000 * 60 * 60 * 24));
    ```

## 3.5 正規表現で文字を操作する(RegExpオブジェクト)

曖昧な文字列パターンを検索できる仕組み

* 郵便番号(3桁の数字-4桁の数字)
  ```
  [0-9]{3}-[0-9]{4}
  ```

## 3.5.1 JavaScriptで利用可能な正規表現

* 正規表現パターン
  * 正規表現で表された文字列パターンのこと

* 分類
  * 基本
    * `ABC`
      + `ABC`という文字列
    * `[ABC]`
      + A,B,Cのいずれか`1文字`
    * `[^ABC]`
      + A,B,C以外のいずれか`1文字`
    * `[A-Z]`
      + A～Zの間の`1文字`
    * `A|B|C`
      + A,B,Cのいずれか
  * 量指定
    * `X*`
      + 0文字以上のX(`fe*`は`f`, `fe`, `fee`等にマッチ)
    * `X?`
      + 0または1文字のX(`fe?`は`f`, `fe`にマッチ, `fee`にはマッチしない)
    * `X+`
      + 1文字以上のX(`fe+`は`fe`, `fee`等にマッチ, `f`にはマッチしない)
    * `X{n}`
      + Xとn回一致
    * `X{n,}`
      + Xとn回以上一致
    * `X{m,n}`
      + Xとm～n回一致
  * 位置指定
    * `^`
      + 行の先頭に一致
    * `$`
      + 行の末尾に一致
  * 文字セット
    * `.`
      + 任意の1文字に一致
    * `\w`
      + `[A-Za-z0-9_]`と同じ
    * `\W`
      + 文字以外に一致(`[^\w]`と同じ)
    * `\d`
      + 数字に一致(`[0-9]`と同じ)
    * `\D`
      + 数字以外に一致(`[^\d]`と同じ)

* URLを表す正規表現パターン(完全なURLを表すものではないが、基本的なものにはマッチ)
  ```regexp
  http(s)?://([\w-]+\.)+[\w]+(/[\w- ./?%&=]*)?
  ```

## 3.5.2 RegExpオブジェクトを生成する方法

* 2つの方法
  * (1) RegExpオブジェクトのコンストラクターを経由する
  * (2) 正規表現リテラルを利用する
  ```javascript
  // (1)
  var p = new RegExp(' http(s)?://([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&=]*)?','gi');
  // (2)
  var p = /http(s)?:\/\/([\w-]+\.)+[\w-]+(\/[\w- .\/?%&=]*)?/gi;
  ```

* 備考
  * オプション
    + g
      - 文字列全体に対してマッチするか(無指定の場合、1度マッチした時点で処理を終了)
    + i
      - 文字列/小文字を区別するか
    + m
      - 複数行に対応するか(改行コードを行頭/行末と認識)
    + u
      - Unicode対応
  * コンストラクター構文では`\`をエスケープすること
    + JavaScriptの文字列リテラルにおいて、`\`は意味を持った予約文字
  * 正規表現リテラルでは`/`をエスケープすること
    + `/`は正規表現パターンの開始と終了を表す予約文字

## 3.5.3 正規表現による検索の基本

* 文字列からURLを抽出するためのサンプル
  ```javascript
  var str = 'サポートサイトはhttp://www.wings.msn.to/です。';
  str += 'サンプル詳解サイトHTTP://www.web-deli.com/もよろしく!';

  // 「文字列全体」を「大文字/小文字の区別なし」で検索
  var p = /http(s)?:W([\w]+\.)+[\w]+(V[\w- .V?%&=]*)?/gi;
  var result = str.match(p);

  for (var i = 0, len = result.length; i < len; i++) {
      console.log(result[i]);
  }
  // http://www.wings.msn.to/
  // HTTP://www.web-deli.com/
  ```

* グローバル検索(gオプション)
  + gオプション外した場合
  ```text
  1) 最初に一致した文字列が見つかったところで終了
  http://www.wings.msn.to/
  2) サブマッチ文字列(a)
  undefined
  3) サブマッチ文字列(b)
  msn.
  4) サブマッチ文字列(c)
  /
  ```
  + サブマッチ文字列
    - 正規表現パターンの中で丸かっこで示された部分

* マルチラインモード(mオプション)
  ```javascript
  var p = /^[0-9]{1,}/g;
  var str = '101匹ワンちゃん。\n7人の小人';

  var result = str.match(p);
  for (var i = 0, len = result.length; i < len; i++) {
      console.log(result[i]);
  }
  // 101

  var p = /^[0-9]{1,}/gm;
  // 101
  // 7
  ```
  * マルチラインモードを有効にした場合、正規表現パターン`^`は行頭を表すことになる
  * 行末を表す`$`についても同様

* Unicodeに対応する(uフラグ)
  + RegExpオブジェクトでもサロゲートペアを認識できるようになる
  + uフラグを削除すると、`𠮟`が1文字と認識されなくなる

## 3.5.5 matchメソッドとexecメソッドの挙動の違い

* 一度の実行で1つの実行結果しか返さず、マッチした文字列全体とサブマッチ文字列を配列として返す
  + gオプションなしと同様
  + 以下のようにすれば可能
  ```javascript
  var p = ...;
  var str = '..';
  str += '..';

  // execは最後にマッチした「文字位置」を記憶する機能を持っている
  while((result = p.exec(str)) !== null) {
      console.log(result[0]);
  }
  ```

## 3.5.6 マッチングの成否を検証する

* regexp.testメソッド
  ```javascript
  // true or false
  regexp.test(str)
  ```

## 3.5.7 正規表現で文字列を置き換える

* str.replaceメソッド
  ```javascript
  // 正規表現全体を()で囲んでおく
  var p = /(...)/gi;
  var str = '...';

  // 「$1, $2, ...」といった特殊変数を埋め込める点に注目
  // サブマッチ文字列を保存するための変数
  // $1: http://www.wings.msn.to/
  // $2: なし
  // $3: msn.
  // $4: /
  console.log(
      str.replace(p, '<a href="$1">$1</a>');
  );
  ```

## 3.5.8 正規表現で文字列を分割する

* str.splitメソッド
  ```javascript
  str.split(sep [,limit]);
  ```
  ```javascript
  var p = /[\/\.\-]/gi;

  // ["2016", "12", "04"]
  console.log('2016/12/04'split(p));
  
  // ["2016", "12", "04"]
  console.log('2016-12-03'.split(p));

  // ["2016", "12", "04"]
  console.log('2016.12.04'.split(p));
  ```

## 3.6 全てのオブジェクトのひな形(Objectオブジェクト)

* 他のオブジェクトに対して、オブジェクトの共通的な性質/機能を提供する
  + すべてのオブジェクトの基本オブジェクトである

* 組み込みオブジェクトは持ちろん、すべてのオブジェクトでObjectオブジェクトの機能は利用できる
  + 例外的に引き継がないものもある(Object.create参照)

## 3.6.1 オブジェクトを基本型に変換する

* toString/valueOfメソッド
  + toString > 文字列を返す
  + valueOf > 文字列以外の基本型の値が返されることを期待して使われる

* アプリ開発者が自分で呼び出す状況は少ない
  + 「+」演算子などでは、暗黙的にtoStringメソッドが呼び出される

* 例
  ```javascript
  var ary = ['prototype.js', 'jQuery'];

  // 結果：prototype.js,jQuery,Yahoo! UI
  console.log(ary.toString());
  // 結果：["prototype.js", "jQuery", "Yahoo! UI"]
  console.log(ary.valueOf());
  ```

* toStringメソッドは意味のある情報を返さない
  + 個々のオブジェクトで、toStringを定義するようにしたりする
  + デバッグ/テストでオブジェクトの内容確認が簡単に

* valueOfメソッドは自分自身を返すだけ
  + Dateオブジェクトはタイムスタンプ値を返している
  + オブジェクトが基本型として表せる値を持っているなら、個々に定義する

## 3.6.2 オブジェクトをマージする(ES6)

* 既存のオブジェクトをマージする

* assignメソッド
  ```javascript
  Object.assign(target, source, ..)
  ```
  + sourceで指定されたオブジェクトのメンバをtargetにコピーする
  ```javascript
  let pet = {
      type:'スノーホワイトハムスター',
      name:'キラ',
      description: {
          birth:'2014-02-15'
      }
  };

  let pet2 = {
      name:'山田きら',
      color:'白',
      description:{
          food:'ひまわりのタネ'
      }
  };

  let pet3 = {
      weight: 42,
      photo: 'http:///www.wings.msn.to/img/ham.jpg'
  };

  Object.assign(pet, pet2, pet3);
  console.log(pet);
  /* 
  {
      color: "白",
      description: {
          food: "ひまわりのタネ"
      },
      name: "山田きら",
      photo: "http://www.wings.msn.to/img/ham.jpg",
      type: "スノーホワイトハムスター",
      weight: 42
  }
  */
  ```
  + 同名のプロパティはあとのもので上書きされる(name)
  + 再帰的なマージは非対応(description)
  + 元のオブジェクトに影響を及ぼしたくない場合
  ```javascript
  let merged = Object.assign({}, pet, pet2, pet3);
  ```

## 3.6.3 オブジェクトを生成する

* createメソッド
  ```javascript
  // オブジェクトリテラル(匿名オブジェクトを生成する最もシンプルな手段)
  var obj = { x:1, y:2, z:3 };

  // 明示的にObjectオブジェクトをインスタンス化(var obj={}; は引き継いでるため完全に空ではない)
  var obj2 = new Object();
  obj2.x = 1;
  obj2.y = 2;
  obj2.z = 3;

  // Object.createメソッド
  var obj3 = Object.create(
      // Objectオブジェクトの機能を引き継いだオブジェクトを生成しなさい(5.2節)
      // nullを渡すことで、Objectオブジェクトを引き継がずに生成する(完全に空のオブジェクト)
      Object.prototype,
      {
        // { プロパティ名: {属性名: 値, ...}, ...}
        x: {
            // 値
            value: 1,
            // 書き換え可能か(default: false)
            writable: true,
            // 属性(writable以外)の変更やプロパティの削除が可能か(default: false)
            configurable: true,
            // 列挙(for .. inなど)を可能とするか(default: false)
            enumerable: true
            // get(ゲッター関数)
            // set(セッター関数) etc...
        },
        y: { value: 2, writable: true, configurable: true, enumerable: true },
        z: { value: 3, writable: true, configurable: true, enumerable: true },
      }
  };
  ```

* JavaScriptには、引数としてオブジェクトリテラルを渡すような状況がよくある
  + ちょっとしたときにクラスをいちいち定義する必要がなくなり、コードをシンプルに記述できる

## 3.6.4 不変オブジェクトを定義する

* 不変オブジェクト
  + 最初にインスタンスを生成したあと、一切の状態(値)を変更できないオブジェクトのこと
  + 意図しない変更を防ぎ、簡単に実装/利用できる > バグの混入を防ぎ堅牢なコーディングにつながる

* 例
  ```javascript
  // 非strictモードだと、prevent/seal/freezeメソッドの制約にもかかわらず例外が発生しない
  // (無条件に無視されるだけで、通知されない)
  // 挙動としてわかりにくいので、利用する場合はStrictモードを有効にするべき(IE9は効かない)
  'use strict';

  var pet = { type: 'スノーホワイトハムスター', name:'キラ' };

  // weightプロパティを変更できない
  // Object.preventExtensions(pet);
  // typeプロパティを削除できない
  // Object.seal(pet);
  // nameプロパティは読み取り専用
  // Object.freeze(pet);

  // 既存のプロパティ値を変更
  pet.name = 'Yamada Akira';
  // 既存のプロパティを削除
  delete pet.type;
  // 新規のプロパティを追加
  pet.weight = 42;;
  ```

## 3.7 JavaScriptプログラムでよく利用する機能を提供する(Globalオブジェクト)

## 3.7.1 Numberオブジェクトに移動したメソッド

## 3.7.2 クエリ情報をエスケープ処理する(encodeURI/encodeURIComponent関数)

## 3.7.3 動的に生成したスクリプトを実行する(eval関数)