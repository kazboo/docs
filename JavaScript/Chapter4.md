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

## 引数の様々な記法

* ES2015で引数に関する仕様が大きく改善している

### JavaScriptは引数の数をチェックしない

* 全て正しく動作する
    ```javascript
    function showMsg(value) {
        console.log(value);
    }

    showMsg(); // (1) undefined
    showMsg('Yamada'); // (2) Yamada
    showMsg('Yamada', 'Suzuki'); // (3) Yamada
    ```
    + `与える引数の数が、関数側で要求する数と異なる場合も、これをチェックしない
    + (3)は切り捨てられるわけではない
        - 内部的には引数情報の１つとして保持されているため、後から利用できる

* 引数情報を管理するのが`arguments`オブジェクト
    + 関数配下でのみ利用できる特別なオブジェクト
    ```txt
    |No.|value    |arguments object   |
    |1  |undefined|                   |
    |2  |Yamada   |[1]Yamada          |
    |3  |Yamada   |[1]Yamada [2]Suzuki|
    ```
    + 関数呼び出しのタイミングで生成され、呼び出し元から与えられた引数の値を保持する
    ```javascript
    // 引数の数をチェックすることができる
    function showMsg(value) {
        if (arguments.length !== 1){
            throw new Error('引数の数が間違っています');
        }
        console.log(value);
    }

    try {
        showMsg('Yamada', 'Suzuki');
    } catch(e) {
        window.alert(e.message);
    }
    ```

* `arguments`と`Arguments`、どちらが正しい？
    + argumentsオブジェクトの実態
        - `Argumentsオブジェクトを参照するargumentsプロパティ`
    + Arguments.length とは記述できない
    + Argumentsオブジェクトは暗黙的に関数内部で生成されるもの(開発者は意識することがない)

* 引数のデフォルト値を設定する
    ```javascript
    function getTriangle(base, height) {
        // JSで構文は用意されていない
        if (base === undefined) base = 1;
        if (height === undefined) height = 1;
        return base * height / 2;
    }

    console.log(getTriangle(5)); // 2.5
    ```

### 可変長引数の関数を定義する

* argumentsオブジェクトの用途の１つ

* 可変長引数の関数
    + 引数の個数があらかじめきまっていない関数
    ```javascript
    function sum() {
        var result = 0;

        for (var i = 0, len = arguments.length; i < len; i++) {
            // argumentsオブジェクトからi番目の要素を取り出す
            var tmp = arguments[i];
            // 要素値が数値であるか確認
            if (typeof tmp !== 'number') {
                throw new Error('引数が数値ではありません:' + tmp);
            }
            result += tmp;
        }
        return result;
    }

    try {
        console.log(sum(1, 3, 5, 7, 9)); // 25
    } catch(e) {
        window.alert(e.message);
    }
    ```

### 明示的に宣言された引数と可変長引数を混在させる

* 例
    ```javascript
    function printf(format) {
        for (var i = 0, len = arguments.length; i < len; i++) {
            console.log(`arguments[${ i }]=${ arguments[i] }`);
            var pattern = new RegExp('\\{' + (i - 1) + '\\}', 'g');
            console.log(pattern);
            format = format.replace(pattern, arguments[i]);
        }
        console.log(format);
    }
    // arguments[0]=こんにちは、{0}さん。私は{1}です。
    // arguments[1]=掛谷
    // arguments[2]=山田
    printf('こんにちは、{0}さん。私は{1}です。', '掛谷', '山田');
    ```

* argumentsオブジェクトには以下の順ですべての引数が格納される
    1. 明示的に宣言された引数
    1. 可変長引数

* `可変長引数だけが、argumentsオブジェクトで管理されるわけではない`

* `無名引数は必要最小限に`
    + コードの可読性という観点から、あまり推奨できない
    + インデックス管理より、名前で管理する引数のほうが直感的
    + 内容や個数があらかじめ想定できる引数についてはできるだけ明示的に

* 以下のように、仮の名前を可変長引数につけておくのもよい
    ```javascript
    // あくまで可変長引数を指定できることを理解できるようにした、便宜的なもの
    function printf(format, var_args) {...}
    ```

### 名前付き引数でコードを読みやすくする

* 名前付き引数とは、次のように呼び出し時に名前を明示的にしてできる引数のこと
    ```javascript
    getTriangle({base:5, height:4})
    ```

* メリット
    + 引数が多くなっても、コードの意味が分かりやすい
    + 省略可能な引数をスマートに表現できる
    + 引数の順番を自由に変更できる

* 以下のケースで有効
    + そもそも引数の数が多い
    + 省略可能な引数が多く、省略パターンにも様々な組み合わせがある

* 実装方法
    ```javascript
    function getTriangle(args) {
        if (args.base === undefined)
            args.base = 1;
        if (args.height === undefined)
            args.height = 1;
    
        return args.base * args.height / 2;
    }

    console.log(getTriangle({base:5, height:4})); // 10
    ```
    + `引数をオブジェクトリテラルで受け取っているだけ`

## ES2015における引数の記法

* ES2015では引数の仕様が大きく変わった
    + 引数のデフォルト値
    + 可変長引数
    + 名前付き引数

* argumentsオブジェクトがほぼ不要となり、JavaScript固有の冗長なコードからも解放される

### 引数のデフォルト値

```javascript
function getTriangle(base = 1, height = 1) {
    return base * height / 2;
}

console.log(getTriangle(5)); // 2.5
```

* 他の引数、関数の結果などを指定することもできる
    ```javascript
    function multi(a, b = a) {
        return a * b;
    }
    console.log(multi(10, 5)); // 50
    console.log(multi(3)); // 9
    ```
    + 自身より前に定義されたものだけ

* `注意点`
    + デフォルト値が適用される場合、されない場合
        - 適用されるのは引数が明示的に渡されなかった場合だけ
        ```javascript
        function getTriangle(base = 1, height = 1) {...}
        console.log(getTriangle(5, null)); // 0
        ```
        - undefinedは例外で、デフォルト値が適用される
    + デフォルト値を持つ仮引数は、引数リストの末尾に(構文規則ではない)
        - 挙動がわかりにくく、バグの原因にもなる
        ```javascript
        function getTriangle(base = 1, height) {...}
        console.log(getTriangle(10)); // 10 x undefined / 2 でNaN
        ```

* 必須の引数を宣言する
    ```javascript
    function required() {
        throw new Error('value is not specified.');
    }

    function hoge(value = required()) {
        return value;
    }

    hoge(); // Error: value is not specified.
    ```

### 可変長引数の関数を定義する(ES2015)

* 仮引数の前に`...`を付与する
    + 英語では`Rest Parameter`と表記される
    + 渡された任意個数の引数を配列としてまとめて受け取る
    ```javascript
    function sum(...nums) {
        let result = 0;
        for (let num of nums) {
            if (typeof num !== 'number') {
                throw new Error('数値ではありません' + num);
            }
            result += num;
        }
        return result;
    }

    try {
        console.log(sum(1, 3, 5, 7, 9));
    } catch(e) {
        window.alert(e.message);
    }
    ```
    + 関数が可変長引数を受け取ることがわかりやすい
    + 全ての配列操作が可能(真正のArrayオブジェクト)
        - `arguments`オブジェクトの実体はArrayオブジェクトではない

### ...演算子による引数の展開(ES2015)

* `...`演算子は実引数で利用することで個々の値に展開できる
    ```javascript
    console.log(Math.max(15, -3, 78, 1)); // 78
    console.log(Math.max([15, -3, 78, 1])); // NaN

    // ES2015以前(applyメソッドが必要)
    console.log(Math.max.apply(null, [15, -3, 78, 1])); // 78

    // ES2015以降
    console.log(Math.max(...[15, -3, 78, 1])); // 78
    ```

### 名前付き引数でコードを読みやすくする(ES2015)

* ES2015では分割代入(2.4.2)を利用することでシンプルに表現できる
    ```javascript
    function getTriangle({base = 1, height = 1}) {
        return base * height / 2;
    }

    console.log(getTriangle({base:5, height:4}));
    console.log(getTriangle({height:4}));
    ```
    
## 4.6 関数呼び出しと戻り値

### 4.6.1 複数の戻り値を個別の変数に代入する(ES2015)

* 配列/オブジェクトとして１つにまとめて返す
    ```javascript
    function getMaxAndMin(...nums) {
        return [Math.max(...numbs), Math.min(...nums)];
    }

    let result = getMaxAndMin(10, 35, -5, 78, 0);
    console.log(result); // [78, -5]

    // 分割代入の利用：意味のある名前をつけわかりやすくする
    let [max, min] = getMaxAndMin(10, 35, -5, 78, 0);
    console.log(max);
    console.log(min);

    // 片方不要な場合
    let [, min] = getMaxAndMin(10, 35, -5, 78, 0);
    ```

### 4.6.2 関数自身を再帰的に呼び出す(再帰関数)

* 自然数nの階乗を求めるためのユーザー定義関数
    ```javascript
    function factorial(n) {
        if (n != 0)
            return n * factorial(n - 1);
        
        return 1;
    }
    ```

### 4.6.3 関数の引数も関数(高階関数)

* JavaScriptの関数はデータ型の一種
    + 関数を引数、戻り値として扱う関数を`高階関数`という
        - forEach, map, filter
    ```javascript
    function arrayWalk(data, f) {
        for (var key in data) {
            f(data[key], key);
        }
    }

    function showElement(value, key) {
        console.log(key + ' : ' + value);
    }

    var ary = [1, 2, 4, 8, 16];
    arrayWalk(ary, showElement);
    ```
    + ユーザー定義関数(具体的な処理内容)を自由に差し替えることが最大の目的

* コールバック関数とは
    + 呼び出し先の関数の中で呼び出される関数のこと
    + 後で呼び出されるべき処理

### 4.6.4 使い捨ての関数は匿名関数で

* 匿名関数は高階関数と密接な関係を持っている
    + 高階関数においては、引数として与えられる関数が`その場限り`でしか利用されないことがよくある
    + その場合、匿名関数(関数リテラル)として記述したほうがコードがシンプルになる
    ```javascript
    function arrayWalk(data, f) {
        for (var key in data) {
            f(data[key], key);
        }
    }

    var ary = [1, 2, 4, 8, 16];
    arrayWalk(
        ary,
        function(value, key) {
            console.log(key + ':' + value);
        }
    );
    ```
    + 呼び出し元との関係がわかりやすくなる
    + 意図せぬ名前の重複を回避できる

## 4.7 高度な関数のテーマ

### 4.7.1 テンプレート文字列をアプリ仕様にカスタマイズする(タグ付きテンプレート文字列) ES2015

* テンプレート文字列(``～``)を利用することで文字列リテラルに変数を埋め込める
    + 変数をそのまま埋め込むだけでなく、なにかしら加工したうえで埋め込みたい
        - `<, >` を `&lt; ,&gt;`に置き換えるエスケープ等
    
* `タグ付きテンプレート(Tagged template strings)`
    ```javascript
    function escapeHtml(str) {
        if(!str) return '';
        str = str.replace(/&/g, '&amp;');
        str = str.replace(/</g, '&lt;');
        str = str.replace(/>/g, '&gt;');
        str = str.replace(/"/g, '&quot;');
        str = str.replace(/'/g, '&#39;');
        return str;
    }

    /**
     * templates:
     *   [0]Hello,
     *   [1]!
     * values:
     *   [0]name (=<"Mario" & \'Luigi\'>)
     */
    function e(templates, ...values) {
        let result = '';
        for (let i = 0, len = templates.length; i < len; i++) {
            result += templates[i] + escapeHtml(values[i]);
        }
        return result;
    }

    let name = '<"Mario" & \&Luigi\>';
    console.log(e`Hello, ${ name } !`);
    // Hello, &lt;&quot;Mario&quot; &amp; &#39;Luigi&#39;&gt;!
    ```
    + 実体は単なる関数呼び出しに過ぎない
        ```javascript
        関数名`テンプレート文字列`
        ```
    + 以下の条件を満たしていなければいけない
        - 引数として以下を受け取ること
            - テンプレート文字列(分解したもの)
            - 埋め込む変数(可変長引数)
        - 戻り値として加工済みの文字列を返すこと

### 4.7.2 変数はどのような順番で解決されるか(スコープチェーン)

* Globalオブジェクト
    + JavaScriptではスクリプトの実行時に、内部的にGlobalオブジェクトを生成する
    + 基本的にプログラマが意識する必要がない
    + グローバル変数/関数を管理するための`便宜的`なオブジェクト
    + グローバル変数/関数はGlobalオブジェクトのプロパティやメソッドであると言い換えられる

* ローカル変数
    + `Activation Object(Callオブジェクト)のプロパティ`である

* Callオブジェクト
    + 関数呼び出しの都度、内部的に自動生成されるオブジェクト
    + 関数内で定義されたローカル変数を管理するための`便宜的`なオブジェクト
    + argumentsプロパティもCallオブジェクトのプロパティ

* 変数が解決されるメカニズムが見えてくる
    + `スコープチェーン`
        - Globalオブジェクト、Callオブジェクトを生成の順に連結したリストのことを言う
        ```txt
        [グローバルオブジェクト]
        +                          スクリプト全体
         ++[Callオブジェクト]++
                              +    関数内部
         function xxxxx() {    +                 
                              [Callオブジェクト]
                                   入れ子となった関数の内部

                                  function xxxxx() {

                                  }
         }
        ```
        - JavaScriptではそれぞれのスコープ単位にGlobalオブジェクト、Callオブジェクトが生成される

* JavaScriptでは、子のスコープチェーンの先頭に位置するオブジェクトから順にプロパティを検索する
    + マッチするプロパティが初めて見つかったところで、その値を採用している
    ```javascript
    var y = 'Global';
    function outerFunc() {
        var y = 'Local Outer';

        function innerFunc() {
            var z = 'Local Inner';
            console.log(z);
            console.log(y);
            console.log(x);
        }
        innerFunc();
    }
    outerFunc();
    ```
    + 先頭から、内部のCallオブジェクト、外部のCallオブジェクト、Globalオブジェクト

### 4.7.3 その振る舞いオブジェクトのごとし(クロージャ)

* クロージャ
    + ローカル変数を参照している関数内関数のこと
    ```javascript
    // 引数や戻り値が関数である関数のことを「高階関数」
    function closure(init) {
        var counter = init;

        return function() {
            return ++counter;
        }
    }

    var myClosure = closure(1);
    console.log(myClosure()); // 2
    console.log(myClosure()); // 3
    console.log(myClosure()); // 4
    ```
    + closure関数から返された匿名関数がローカル関数counterを参照し続けている
    + そのため、closure関数の終了後もローカル変数counterは保持され続ける
    + 以下のスコープチェーンが匿名関数が有効である間は保持される
        - 匿名関数を表すCallオブジェクト
        - closure関数のCallオブジェクト
        - グローバルオブジェクト

* クロージャは`記憶領域を提供する仕組み`ともいえる
    
* 呼び出しごとに生成されたCallオブジェクトは別物
    + それぞれのCallオブジェクトに属するローカル変数counterも別物
    ```javascript
    function closure(init) {
        var counter = init;

        return function() {
            return ++counter;
        }
    }

    var myClosure1 = closure(1);
    var myClosure2 = closure(100);

    console.log(myClosure1()); // 2
    console.log(myClosure2()); // 101
    console.log(myClosure1()); // 3
    console.log(myClosure2()); // 102
    ```
    ```txt
            [Global]-(myClosure1, myClosure2)
            +       +
           +         +
       [Call1-1]  [Call2-1]
        + cnt=1         +  cnt = 100
       +                 +
    [Call1-2]       [Call2-2]
    関数リテラル     関数リテラル
    (クロージャ)     (クロージャ)
    ```
    + Callオブジェクトは関数呼び出しのたびに生成される

