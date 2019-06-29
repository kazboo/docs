# 繰り返し利用するコードを1箇所にまとめる

## 関数とは

* 与えられた入力(パラメータ)に基づいて何らかの処理を行い、その結果を返す仕組み

* JavaScriptはデフォルトの関数を多く提供している

* アプリ開発者が自分で関数を定義することもできる
    + `ユーザー定義関数`
        - function命令で定義する
        - Functionコンストラクタ経由で定義する
        - 関数リテラル表現で定義する
        - アロー関数で定義する(ES2015)

### function命令で定義する

* 構文
    ```javascript
    function 関数名(引数, ...) {
        ...
        return 戻り値;
    }

    // 例
    function getTriangle(base, height) {
        return base * height / 2;
    }
    ```

* 関数名はcamelCase形式で定義するのが基本

* 戻り値
    + 戻り値がない場合、return命令は省略可
        - デフォルトで`undefined`を返す

### Functionコンストラクター経由で定義する

* 構文
    ```javascript
    var 変数名 = new Function(引数,...,関数の本体);
    // 例
    var getTriangle = new Function('base', 'height', 'return base * height/2;');
    // 仮引数を１つにまとめることも可能
    // var getTriangle = new Function('base, height', 'return base * height/2;');
    console.log(getTriangle(5, 2));
    ```

* 特別な理由がない限り、メリットはない

* あるとすると
    + 引数や関数本体を文字列として定義できる
    ```javascript
    var param = 'hegith, width';
    var formula = 'return height*width/2;';
    var diamend = new Function(param, formula);
    ```
    + 動的に生成することができる

* eval同様、`乱用すべきではない`
    + 外部から任意のコードを実行できてしまう可能性がある

* 使う場合、以下で使うのは避ける
    + while/for等のブロック中
    + 頻繁に呼び出される関数の中

* 実行パフォーマンスの低下の一因となる可能性がある
    + Functionコンストラクタは呼び出されるたびコード解析、関数オブジェクト生成を行うため

* JavaScript関数は原則として以下で定義する
    + function命令
    + 関数リテラル
    + アロー関数

### 関数リテラル表現で定義する

* JavaScriptにおいて関数はデータ型の一種
    + 関数はリテラルとして表現する
    + 関数リテラルを変数に代入する
    + 関数リテラルをある関数の引数として渡す
    + 関数を戻り値として返す

* 構文
    ```javascript
    var getTriangle = function(base, height) {
        return base * height/2;
    };
    console.log('三角形の面積:' + getTriangle(5, 2)); // 結果:5
    ```

### アロー関数で定義する(ES2015)

* アロー関数(Arrow Function)を利用することで、関数リテラルをよりシンプルに記述できる
    ```javascript
    let getTriangle = (base, height) => {
        return base * height/2;
    }
    ```
    ```javascript
    let getTriangel = (base, height) => base * height/2;
    ```
    ```javascript
    let getCircle = radius => radius * radius * Math.PI;
    ```
    ```javascript
    let show = () => console.log('こんにちは、世界!');
    ```

* オブジェクトリテラルを返す場合は注意
    ```javascript
    // 括弧が必要
    let func = () => ({hoge:'ほげ'});
    // undefined (関数ブロックの中に、ラベルと文字列式がある状態)
    let func = () => {hoge:'ほげ'});
    ```

## 関数定義における4つの注意点

## 2) 関数はデータ型の一種

* 以下はただしい
    ```javascript
    // getTriangleという変数に、関数型のリテラルを格納する
    var getTriangle = function(base, height) {
        return base * height / 2;
    }
    conosloe.log(getTriangle(5, 2)); // 5
    getTriangle = 0;
    console.log(getTriangle); // 0
    ```
    + JavaScriptでは`関数はデータ型の一種`
    + 以下のようなコードを記述することもできる
    ```javascript
    var getTriangle = function(base, height) {
        return base * height / 2;
    };
    console.log(getTriangle);
    /*
    格納された関数定義がそのまま文字列として出力される
    (厳密には、FunctionオブジェクトのtoStringメソッドが呼び出される)
    function(base, height) {
    return base * height / 2;
    }
    */
    ```
    + 丸かっこは、関数を実行するという意味も持ち合わせている
    
### 3) function命令は静的な構造を宣言する

* 関数定義が変数定義である、と考えると以下はエラーとなるはずだが、そうはならない
    ```javascript
    console.log('三角形の面積:' + getTriangle(5, 2));

    // 呼び出しより後に定義される
    function getTriangle(base, height) {
        return base * height / 2;
    }
    ```
    + functionが動的に実行される命令ではなく、静的な構造を宣言するためのキーワードであるから
        - function命令はコードを解析/コンパイルするタイミングで関数を登録している

* `<script>`要素は呼び出し側より先に記述する
    + 関数を定義したスクリプトブロックは、`呼び出し側のスクリプトブロック前`あるいは`同じスクリプトブロック`に記述されなければいけない
        - ブラウザはscript要素の単位で、順にスクリプトを処理していくため

### 4) 関数リテラル/Functionコンストラクタは実行時に評価される

* 関数リテラル(or Functionコンストラクタ)で書き換えたらどうなる
    ```javascript
    console.log('面積' + getTriangle(5, 2));

    var getTriangle = function(base, height) {
        return base * height / 2;
    }
    ```
    + 実行時エラー(getTriangle is not a function)
    + function命令とは異なり、`関数リテラル/Functionコンストラクタは実行時に評価される`
    + 関数リテラルとFunctionコンストラクタの間にも解釈の違いがある

## 変数はどの場所から参照できるか(スコープ)

* スコープ
    + スクリプト全体から参照できるグローバルスコープ
    + 定義された関数の中でのみ参照できるローカルスコープ

* ブロックスコープ
    + ES2015から追加された概念

### 変数宣言にvar命令が必要な理由

```javascript
scope = 'Global Variable';

function getValue() {
    scope = 'Local Variable';
    return scope;
}

console.log(getValue()); // Local Variable
console.log(scope); // Local Variable
```

* 両方とも"Local Variable"になってしまう
    + JavaScriptでは`var命令を使わずに宣言された変数は全てグローバル変数とみなす`
    + "変数を定義する場所がスコープを決める"という説明が"やや嘘"
    + 正確には`var命令で定義された変数は、定義する場所によって変数のスコープがきまる`
    + `ローカル変数を定義するには必ずvar命令を使用する`

* "関数内でグローバル変数を書き換える"ような用途を除いては、原則var命令を省略すべきではない

### ローカル変数の有効範囲

```javascript
var scope = 'Global Variable';

function getValue() {
    console.log(scope); // ???
    var scope = 'Local Variable';
    return scope;
}

console.log(getValue()); // Local Variable
console.log(scope); // Grobal Variable
```

* ???で出力される値は？
    + `undefined`
    + JavaScriptでは、ローカル変数は`関数全体で有効`なので、???の時点で`scope`変数はすでに有効になっている
    + ローカル変数が確保されているだけなので、`scope`変数の中身は未定義である
    + この挙動を`変数の巻き上げ(hoisting)`という

* `変
数の巻き上げ`を避ける意味でも、`ローカル変数は関数の先頭で宣言する`のが好ましい
    - この作法は`変数はできるだけ利用する場所の近くで宣言する`という他の言語に反するため要注意
    - これにより、"直感的な変数の有効範囲"と"実際の有効範囲"とが食い違うこともなくなる

### 仮引数のスコープ(基本型と参照型の違いに注意)

* 仮引数は、"基本的に"ローカル変数として処理される
    ```javascript
    // 基本型
    var value = 10;

    function decrementValue(value) {
        value--;
        return value;
    }
    console.log(decrementValue(100)); // 99
    console.log(value); // 10
    ```

* 参照型ではどうか
    ```javascript
    var value = [1, 2, 4, 8, 16];

    function deleteElement(value) {
        value.pop() // 末尾削除
        return value;
    }

    console.log(deleteElement(value)); // [1, 2, 4, 8]
    console.log(value); // [1, 2, 4, 8]
    ```
    + グローバル変数valueとローカル変数valueは変数としては異なるが、参照しているメモリ上の場所が等しくなる(参照渡し)

### ブロックレベルのスコープは存在しない(ES2015以前)

* Java
    ```java
    if (true) {
        int i = 5;
    }
    System.out.println(i); // Error
    ```

* JavaScript(ES2015以前)
    ```javascript
    if (true) {
        var i = 5;
    }

    console.log(i); // 5
    ```

* "変数の意図せぬ競合を防ぐ"という意味でも、変数のスコープをできるだけ必要最小限にとどめることは重要
    + JavaScriptでも疑似的にブロックスコープを実現できる
    ```javascript
    // 即時関数
    (function() {
        var i = 5;
        console.log(i);
    }).call(this);

    console.log(i); // スコープ外なのでエラー
    ```

### ブロックスコープに対応したlet命令

* let命令はブロックスコープに対応した変数を宣言する
    ```javascript
    if (true) {
        let i = 5;
    }

    console.log(i); // Error
    ```
    + `スコープはできる限り限定すべき`という一般的なプログラミングのルールからすれば利用するのが望ましい

* `const`で定義された定数もブロックスコープを持つ

* 即時命令は使わない
    + ES2015では必要なくなる
    ```javascript
    {
        let i = 5;
        console.log(i); // 結果 5
    }
    console.log(i); // 変数はスコープ外なのでエラー
    ```

* `switch`ブロックでのlet宣言に注意
    ```javascript
    switch(x) {
        case 0: 
            let value = 'x:0';
        case 1:
            let value = 'x:1'; // 変数名の重複エラー
    }
    ```
    + このようなケースではswitchブロックの外で最初に変数valueを宣言しておくようにする

## 関数リテラル/Functionコンストラクタにおけるスコープの違い

* いずれも匿名関数を定義するための機能を提供するもの
    + 関数の中で利用した場合、スコープの解釈が異なる
    ```javascript
    var scope = 'Global Variable';

    function checkScope() {
        var scope = 'Local Variable';

        var f_lit = function() {
            return scope;
        };

        console.log(f_lit()); // Local Variable

        var f_con = new Function('return scope;');
        console.log(f_con()); // Global Variable
    }

    checkScope();
    ```
    + Functionコンストラクタ配下の変数は、その宣言場所にかかわらず、常にグローバルスコープとみなされる
        - 前述通り、原則としてFunctionコンストラクタを利用しないことを前提
    
* 関数3つの記法は必ずしも意味的に等価でない