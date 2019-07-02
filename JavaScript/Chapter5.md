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