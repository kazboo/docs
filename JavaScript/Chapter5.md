# 大規模開発でも通用する書き方を身に着ける

## 5.1 JavaScriptにおけるオブジェクト指向の特徴

* ES2015での最大の変更点はオブジェクト指向構文

### 5.1.1 クラスではなくプロトタイプ

* インスタンス化という概念はある

* クラスがなく、プロトタイプ(ひな形)という概念だけが存在する

* プロトタイプ
    - あるオブジェクトの元となるオブジェクト
    - JavaScriptではクラスの代わりにプロトタイプを使用して新たなオブジェクトを生成していく
    - より縛りの弱いクラスのようなもの

* JavaScriptのオブジェクト指向は、プロトタイプベースのオブジェクト指向と呼ばれることがある
    - Not クラスベース

### 5.1.2 最もシンプルなクラスを定義する

* 中身を持たない、最もシンプルなクラス
    ```javascript
    var Member = function() {};
    ```
    + 変数Memberに対して空の関数リテラルを代入しているだけであり、これがJavaScriptのクラス
    + このMemberクラスはnew演算子でインスタンス化できる
    ```javascript
    var member1 = new Member();
    ```
    + JavaScriptの世界では、"厳密な意味でのクラス"という概念は存在しない
    + `関数(Functionオブジェクト)`にクラスとしての役割を与えている

* アロー関数ではコンストラクタを定義できない
    ```javascript
    let Member = () => {
        ...
    };
    let member1 = new Member(); // Member is not a constructor
    ```
    + アロー関数はコンストラクタとしてふるまうことはできない(エラーになる)
    + ES2015環境ではclass命令を利用すべき

### 5.1.3 コンストラクタで初期化する

* コンストラクター
    + "オブジェクトを初期化する処理を記述する"ための特殊なメソッド(関数)

* さっきのMember関数もまた、"new演算子によって呼び出され、オブジェクトを生成する"意味で、クラスというよりコンストラクタと呼ぶのが正しい

* コンストラクタの名前は大文字で始めるのが一般的(区別するため)

#### プロパティとメソッド

```javascript
var Member = function(firstName, lastName) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.getName = function() {
        return this.lastName + '' + this.firstName;
    }
};

var mem = new Member('太郎', '田中');
console.log(mem.getName()); // 田中太郎
```

* `this`
    + コンストラクタによって生成されるインスタンス(つまり、自分自身)
    + `thisキーワードに対して変数を指定することで、インスタンスのプロパティを設定できる`

* JavaScriptには厳密にはメソッドという独立した概念はない
    + `値が関数オブジェクトであるプロパティがメソッドとみなされる`

### 5.1.4 動的にメソッドを追加する

* メソッドはコンストラクタで定義するばかりではない

* インスタンス化した後に追加できる
    ```javascript
    var Member = function(firstName, lastName) {
        this.firstName = firstName;
        this.lastName = lastName;
    };

    var mem = new Member('太郎', '田中');
    mem.getName = function() {
        return this.lastName + '' + this.firstName;
    }

    console.log(mem.getName()); // 田中太郎
    ```

* 注意すべき点もある
    ```javascript
    var Member = function (firstName, lastName) {
        this.firstName = firstName;
        this.lastName = lastName;
    };

    var mem = new Member('太郎', '田中');
    mem.getName = function() {
        return this.lastName + ' ' + this.firstName;
    }

    console.log(mem.getName()); // 田中太郎

    var mem2 = new Member('銀時', '坂田');
    console.log(mem2.getName()); // Error: mem2.getName is not a function
    ```
    + 生成されたインスタンスに対してメソッドが追加されている
    + プロトタイプベースのオブジェクト指向の世界では、`同一のクラスをもとに生成されたインスタンスであっても、それぞれが持つメンバーは同一であるとは限らない`
        - このような緩さが、プロトタイプが"より縛りの弱いクラスのようなもの"と述べた理由
        - プロパティも同様

### 5.1.5 文脈によって中身が変化する変数(thisキーワード)

* 呼び出しの方法(文脈)によって中身が変化する変数
    + JavaScript初心者にとってわかりづらい
    + 時としてバグの温床になる

* thisキーワードの参照先
    + トップレベル
        - グローバルオブジェクト
    + 関数
        - グローバルオブジェクト(Strictモードではundefined)
    + call/applyメソッド
        - 引数で指定されたオブジェクト
    + イベントリスナー
        - イベントの発生元
    + コンストラクター
        - 生成したインスタンス
    + メソッド
        - 呼び出し元のオブジェクト(=レシーバーオブジェクト)

* call/applyメソッド
    + 関数(Functionオブジェクト)が提供するメンバー
    + 実行すべき関数funcに渡す引数の指定方法だけ異なる
    ```javascript
    func.call(that[, arg1[, arg2[, ...]])
    func.apply(that, [args])
    ```
    ```javascript
    var data = 'Global data';
    var obj1 = {data: 'obj1 data'};
    var obj2 = {data: 'obj2 data'};
    function hoge() {
        console.log(this.data);
    }

    // 暗黙的にグローバルオブジェクトが渡されたものとみなされる
    // this = global object
    hoge.call(null); // Global data
    // this = obj1
    hoge.call(obj1); // obj1 data
    // this = obj2
    hoge.call(obj2); // obj2 data
    ```

* call/applyメソッドを利用することで、argumentsオブジェクトのように"配列に似ているが配列ではない"オブジェクトを配列に変換することもできる
    ```javascript
    function hoge() {
        var args = Array.prototype.slice.call(arguments);
        // argumentsオブジェクトでは使えなかったjoinメソッドを利用できている(Arrayオブジェクトに変換されている)
        console.log(args.join('/'));
    }
    hoge('Angular', 'React', 'Backbone'); // Angular/React/Backbone
    ```

* Array.fromメソッドで配列を変換する(ES2015)
    + Array.prototype.slice.callを使わなくても変換できる
    ```javascript
    let args = Array.from(arguments);
    ```

### 5.1.6 コンストラクターの強制的な呼び出し

* JavaScriptでは関数がコンストラクタとしての役割を担ってる
    + 構文上、コンストラクタを関数としても呼び出せてしまう
    ```javascript
    var Member = funciton(firstName, lastName) {
        // 直接呼び出された場合、thisがグローバルオブジェクトを示してしまう(Strictモードではundefined)
        this.firstName = firstName;
        this.lastName = lastName;
    };

    // 直接呼び出し
    var m = Member('権兵衛', '佐藤');
    console.log(m); // undefined
    console.log(firstName); // 権兵衛
    console.log(m.firstName); // エラー(Cannot read property firstName of undefined)
    ```
    + `Memberオブジェクトは生成されない`
    + 代わりにグローバル変数としてfirstName/lastNameが生成されてしまう
        - `this`がグローバルオブジェクトを示すから
    + あるべき状態ではないので、以下のような仕掛けをすると安全
    ```javascript
    var Member = function(firstName, lastName) {
        // 直接呼び出された場合、thisがグローバルオブジェクトを示す(Strictモードではundefined)
        if (!(this instanceof Member)) {
            return new Member(firstName, lastName);
        }
        this.firstName = firstname;
        this.lastName = lastName;
    };
    ```

## 5.2 コンストラクタの問題点とプロトタイプ

* 共通のメソッドを定義するには少なくともコンストラクタでメソッドを定義する必要があった

* しかし、コンストラクタによるメソッドの追加には`メソッドの数に比例して、無駄なメモリを消費する`問題がある

* コンストラクタはインスタンスを生成するたびに、それぞれのインスタンスのためにメモリを確保します

* 例のgetNameメソッド(関数リテラル)はすべてのインスタンスで中身が同じなので、インスタンス単位でメモリを確保するのは無駄なこと
    + 10、20も持つクラスだったとしたら。。。
    + いちいちインスタンス化のたびにコピーするのは無駄なこと
    ```txt
    MemberClass     MemberInstance1         MemberInstance2
    + firstName     + 'Kouichi'             + 'Kouichi'
    + lasatName     + 'Usui'                + 'Kouichi'
    + getName       + function() {...}      + function() {...}
    ```

### 5.2.1 メソッドはプロトタイプで宣言する(prototypeプロパティ)

* そこで、オブジェクトにメンバーを追加するために、`prototype`というプロパティを用意する

* `prototype`プロパティはデフォルトで空のオブジェクトを参照している
    + これにプロパティやメソッドを追加することができる
    + prototypeプロパティに格納されたメンバはインスタンス化された先のオブジェクトに引き継がれる
    ```txt
    MemberClass     MemberInstance1         MemberInstance2
    + firstName     + 'Kouichi'             + 'Kouichi'
    + lasatName     + 'Usui'                + 'Kouichi'
    + getName <-----+-----------------------+
    ```

```javascript
var Member = function(firstName, lastName) {
    this.firstname = firstName;
    this.lastName = lastName;
};

Member.prototype.getName = function() {
    return this.lastname + '' + this.firstName;
};

var mem = new Member('太郎', '田中');
console.log(mem.getName()); // 田中太郎
```

* プロトタイプベースのオブジェクト指向
    + 様はクラスという抽象的な設計図が存在しないのがJavaScriptの世界である

* JavaScriptの世界にあるのは、あくまで実体化されたオブジェクト
    + 新しいオブジェクトを生成するにもクラスではなくオブジェクトがもとになっている
    + 新しいオブジェクトを作るための原型を表すのが、それぞれのオブジェクトに属するプロトタイプという、特別なオブジェクト

### 5.2.2 プロトタイプオブジェクトを利用することの2つの利点

* メモリの使用量を節減できる

* メンバーの追加や変更をインスタンスがリアルタイムに認識できる

### 5.2.3 プロトタイプオブジェクトの不思議(プロパティの設定)

* プロパティをプロトタイプで定義しても、動作上はインスタンスが個別にプロパティを保有しているように見えるので問題ない

* 本来インスタンス単位で値が異なるはずのプロパティをプロトタイプオブジェクトで宣言する意味はない(読み取り専用は別)

```javascript
var Member = function() {};

Member.prototype.gender = 'Man';
var mem1 = new Member();
var mem2 = new Member();

console.log(mem1.gender + '|' + mem2.gender); // Man|Man
mem2.gender = 'Woman';
console.log(mem1.gender + '|' + mem2.gender); // Man|Woman
```

* 通常は、以下のように使い分け
    + プロパティの宣言
        - コンストラクタで
    + メソッドの宣言
        - プロトタイプで