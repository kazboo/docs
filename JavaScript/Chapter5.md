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
    + プロパティの宣言: `コンストラクタで`
    + メソッドの宣言: `プロトタイプで`

### プロトタイプオブジェクトの不思議(2) - プロパティの削除 -

```javascript
var Member = function() {};
Member.prototype.sex = 'man';

var mem1 = new Member();
var mem2 = new Member();

console.log(mem1.sex + '|' + mem2.sex); // man|man
mem2.sex = 'women';
console.log(mem1.sex + '|' + mem2.sex); // man|woman

// インスタンスmem1のプロパティを削除しようとするが、mem1はsexプロパティを持たない
// delete演算子は何もしない(=プロトタイプまでさかのぼって削除することはない)
delete mem1.sex
// mem2は地自身でsexプロパティを持つのでdelete演算子はこれを削除する
delete mem2.sex
// mem1は暗黙の参照をたどって、プロトタイプオブジェクトのsexプロパティを返す
console.log(mem1.sex + '|' + mem2.sex); // man|man
```

* `インスタンス側でのメンバーの追加、削除といった操作がプロトタイプオブジェクトにまで影響を及ぼすことはない`

* プロトタイプオブジェクトのメンバーを削除
    ```javascript
    delete Member.prototype.sex
    ```
    + `全てのインスタンスのsexプロパティが削除されてしまう`

* プロトタイプで定義されたメンバーを`インスタンス単位で`削除したい場合、定数undefinedを用いる方法がある
    ```javascript
    var Member = function() { };

    Member.prototype.sex = 'man';

    var mem1 = new Member();
    var mem2 = new Member();
    console.log(mem1.sex + '|' + mem2.sex); // man|man
    mem2.sex = undefined;
    console.log(mem1.sex + '|' + mem2.sex); // man|undefined
    ```

    + あくまでメンバーの存在自体はそのままに、値を強制的に未定義としているにすぎない
    + `for ... in` では表示されることになる

### 5.2.5 オブジェクトリテラルでプロトタイプを定義する

* ドット演算子を使ってプロトタイプにメンバーを追加する方法は正しい構文だが、メンバーが多くなってくるとコードが冗長になり、好ましくない
    + どこからどこまでが同じオブジェクトのメンバー定義であるのか、一見して見えにくい可読性の問題

* オブジェクトのリテラル表現を使う
    ```javascript
    var Member = function(firstName, lastName) {
        this.firstName = firstName;
        this.lastName = lastName;
    };

    Member.prototype.getName = function() {
        return this.lastName + '' + this.firstName;
    };

    Member.prototype.toString = function() {
        return this.lastName + this.firstName;
    };
    ```
    ```javascript
    var Member = function(firstName, lastName) {
        this.firstName = firstName;
        this.lastName = lastName;
    }
    Member.prototype = {
        getname:function() {
            return this.lastName + '' + this.firstName;
        },
        toString:function() {
            return this.lastName + this.firstName;
        }
    };
    ```

* メリット
    + Member.prototype.~ のような記述を最小限に抑えられる
    + 結果、オブジェクト名に変更があった場合にも影響箇所を限定できる
    + 同一オブジェクトのメンバー定義が1つのブロックに収められているため可読性が向上する

* プロトタイプ定義する場合にはリテラル表現を利用することが推奨される

### 5.2.6 静的プロパティ/静的メソッドを定義する

* 静的プロパティ/静的メソッド
    + インスタンスを生成しなくてもオブジェクトから直接呼び出せるプロパティ/メソッド

* プロトタイプオブジェクトには登録できない
    + プロトタイプオブジェクトはあくまで`インスタンスから暗黙的に参照されることを目的としたオブジェクト`

```javascript
var Area = function() {};

// 静的プロパティversion
Area.version = '1.0';

// 静的メソッドtriangle
Area.triangle = function(base, height) {
    return base * height / 2;
};

// 静的メソッドdiamond
Area.diamond = function(width, height) {
    return width * height /2;
};
```

* 静的プロパティ/静的メソッドを定義するときの2つの注意点
    + 静的プロパティは、基本的に読み取り専用の用途で
        - クラス単位で保有される情報
        - そのスクリプト内のすべてに変更が反映されてしまう
    + 静的メソッドの中では、thisキーワードは使えない(使っても意味がない)
        - インスタンスメソッドの中でのthisキーワードはインスタンス自身を表す
        - `静的メソッドの中ではコンストラクタ(関数オブジェクト)を表す`
        - `静的メソッドからインスタンスプロパティの値にアクセスすることはできない`ので注意
    
* グローバル変数/関数はできるだけ減らすこと
    + そのために関連する機能や情報は静的メンバーにまとめること


## 5.3 オブジェクトの継承(プロトタイプチェーン)

* 差分プログラミング
    + 元となるクラスからの差分の機能だけを記述するようになる

* 継承元となるクラスをスーパークラス(or 基底クラス)

* 継承によってできたクラスのことをサブクラス(or 派生クラス)

### 5.3.1 プロトタイプチェーンの基礎

* この継承の仕組みをJavaScriptの世界で実現しているのが`プロトタイプチェーン`

```javascript
var Animal = function() {};

Animal.prototype = {
    walk:function() {
        console.log('とことこ');
    }
};

var Dog = function() {
    // Animalコンストラクタを現在のthisで呼び出しなさい
    // ここではAnimalコンストラクタは空なのでなくても問題ない
    // プロパティの定義などしている場合は、基底クラスのコンストラクタを処理した後、派生クラス独自の初期化処理を記述してください
    Animal.call(this);
};

// Dogオブジェクトのプロトタイプとして、Animalオブジェクトのインスタンスをセット
// Dogオブジェクトのインスタンスから、Animalオブジェクトで定義されたwalkを呼び出せるようになる
Dog.prototype = new Animal();
Dog.prototype.bark = function() {
    console.log('わんわん!');
}

var d = new Dog();
d.walk(); // とことこ
d.bark(); // わんわん！
```

* 流れ
    1. Dogオブジェクトのインスタンスdからメンバーの有無を検索する
    1. 該当するメンバーが存在しない場合には、Dogオブジェクトのプロトタイプ、つまりAnimalオブジェクトのインスタンスを検索する
    1. そこでも目的のメンバーが見つからない場合には、さらにAnimalオブジェクトのプロトタイプを検索する

* `プロトタイプにインスタンスを設定`することで、インスタンス同士を`暗黙の参照`で連結し、`互いに継承関係を持たせる`ことができる

* このようなプロトタイプの連なりを`プロトタイプチェーン`という

* プロトタイプチェーンの終端は`Object.prototype`
    + すべてのオブジェクトのルートとなるのは`Objectオブジェクト`
    + 全てのオブジェクトは、暗黙的にObjectオブジェクトを継承し、Object.prototypeを参照する

* 現在のインスタンスのプロパティだけを列挙する
    + for..in命令を利用することで、オブジェクトが持つメンバーを列挙する
    + プロトタイプを利用している場合もプロトタイプチェーンをたどる
        - ただし、enumerable属性がfalseであるメンバーは除く
    + もしプロトタイプを参照せずに、現在のインスタンスが持つプロパティだけを列挙したい場合は、以下のようにhasOwnPropertyメソッドを利用する
        - ahasOwnPropertyメソッドは指定されたプロパティが現在のインスタンス自身が持つメンバーであるかをtrue/falseで返す
        ```javascript
        for(var key in obj) {
            if (obj.hasOwnProperty(key)) {
                console.log(key);
            }
        }
        ```

* 基底クラスのコンストラクタを呼び出す
    + 基底クラスでプロパティの定義など、何かしらの初期化処理を行っている場合には、まず基底クラスのコンストラクタを処理した後、派生クラス独自の初期化処理を記述すること
    + 基底クラスのコンストラクタに引数を渡す場合、以下のようにする
    ```javascript
    Animal.call(this, 'hoge', 'hoo');
    ```

### 5.3.2 継承関係は動的に変更可能

* プロトタイプチェーンはJavaScriptではいわゆる"継承"機能を実現する仕組み
    + Javaのようなオブジェクト指向(継承)を学んできた人は要注意
        - あくまで静的なもの(途中変更はできない)
    + JavaScriptでは動的なもの
        - 同一のオブジェクトが、あるタイミングではオブジェクトXを継承しており、次のタイミングではオブジェクトYを継承しているということも可能

```javascript
var Animal = function) {};
Animal.prototype = {
    walk:function() {
        console.log('トコトコ');
    }
};

var SuperAnimal = function() {};
SuperAnimal.prototype = {
    walk:function() {
        console.log('ダダダダダ!');
    }
};

var Dog = function() {};
Dog.prototype = new Animal();
var d1 = new Dog();
d1.walk();

Dog.prototype = new SuperAnimal();
var d2 = new Dog();
d2.walk(); // ダダダダダ！
d1.walk(); // トコトコ  < Animalオブジェクトのwalkメソッドが呼び出される
```

* JavaScriptのプロトタイプチェーン
    + インスタンスが生成された時点で固定され、その後の変更にかかわらず保存される

### 5.3.3 オブジェクトの型を判定する

* JavaScriptでは厳密な意味での「クラス」という概念はない
    + あるオブジェクトをもとにしたインスタンスが、必ずしも同じメンバーを持つとは限らないのがJavaScriptの世界

* クラスベースのオブジェクト指向でいうところの型という概念も正確には存在しない
    + 以下の機能を利用することで緩く型を判定できる
        1. 元となるコンストラクタを取得する(constructorプロパティ)
            ```javascript
            // Animalクラスと、これを継承したHamsterクラスを準備
            var Animal = function() {};
            var Hamster = function() {};
            Hamster.prototype = new Animal();
            var a = new Animal();
            var h = new Hamster();
            console.log(a.constructor === Animal); // true
            console.log(h.constructor === Animal); // true
            console.log(h.constructor === Hamster); // false < 判別するにはinstanceofを使う
            ```
        1. 元となるコンストラクタを判定する(instanceof演算子)
            + オブジェクトが特定のコンストラクターによって生成されたインスタンスであるかどうかを判定
            ```javascript
            console.log(h instanceof Animal); // true
            console.log(h instanceof Hamster); // true
            ```
        1. 参照しているプロトタイプを確認する(isPrototypeOfメソッド)
            + instanceofと似ているが、オブジェクトが参照しているプロトタイプを確認するために利用
            ```javascript
            console.log(Hamster.prototype.isPrototypeOf(h)); // true
            console.log(Animal.prototype.isPrototypeOf(h)); // true
            ```
        1. メンバーの有無を判定する(in演算子)
            + 型そのものより、特定のメンバーに関心がある場合に利用するのが確実
            ```javascript
            var obj = {
                hoge: function() {},
                foo: function() {}
            };
            console.log('hoge' in obj); // true
            console.log('piyo' in obj); // false
            ```

