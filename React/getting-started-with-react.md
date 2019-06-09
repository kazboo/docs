# getting-started-with-react

https://www.taniarascia.com/getting-started-with-react/

## React

* ReactはJavaScriptライブラリ(GitHubには10万以上のスターがある、最も人気のあるものの1つ)
* Reactはフレームワークではありません
* ReactはFacebookによって作成されたオープンソースプロジェクト
* ReactはフロントエンドにUIを構築するために使用される
* ReactはMVCアプリケーションのビューレイヤ

## Setup and Installation

* There are a few ways to set up React.
    + Static HTML File
    + Create React App

### Static HTML File

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />

    <title>Hello React!</title>

    <script src="https://unpkg.com/react@16/umd/react.development.js"></script>
    <script src="https://unpkg.com/react-dom@16/umd/react-dom.development.js"></script>
    <script src="https://unpkg.com/babel-standalone@6.26.0/babel.js"></script>
  </head>

  <body>
    <div id="root"></div>

    <script type="text/babel">
      // React code will go here
      class App extends React.Component {
        render() {
          return <h1>Hello world!</h1>
        }
      }

      ReactDOM.render(<App />, document.getElementById('root'))
    </script>
  </body>
</html>
```

* React - the React top level API
* React DOM - adds DOM-specific methods
* Babel - a JavaScript compiler that lets us use ES6+ in old browsers
* JSライブラリをHTMLに読込み、React/Babelをその場でレンダリングする方法は効率的でなく、保守が困難

### Create React App

* Reactアプリを構築するために必要なものがすべてあらかじめ設定されている環境
    + Create a live development server
    + Use [Webpack](https://ferret-plus.com/6337) to automatically compile React, JSX, and ES6
    + Auto-prefix CSS files
    + Use ESLint to test and warn about mistakes in the code

## JSX: JavaScript + XML

* 今扱っていたのはHTMLではなく、JSX(JavaScript XML)

* JSXを使用するとHTMLのように見えるものを書くことができる
    + 独自のXMLのようなタグを作成して使用することもできる
    ```javascript
    // JSX
    const heading = <h1 className="site-heading">Hello, React</h1>

    // JSX以外
    const heading = React.createElement(
        'h1',
        {
            className: 'site-heading'
        },
        'Hello, React!'
    )
    ```
    + 注意点
        - `class`はJavaScriptの予約語、代わりに`className`を使用する
        - JSXのプロパティとメソッドはcamelCase
        - 自己終了タグが必要(`<img />`)
    + JavaScriptの式は、変数、関数、プロパティを含む中カッコを使用してJSX内に埋め込むことができる
        ```javascript
        const name = 'Tania';
        const heading = <h1>Hello, {name}</h1>
        ```
    + 通常のJavaScriptより書きやすい、理解しやすい

## Components

* Reactのほとんどは`Component`から成田ている
    ```javascript
    import React, { Component } from 'react'

    class App extends Component {
      render() {
        return (
          <div className="App">
            <h1>Hello, React!</h1>
          </div>
        )
      }
    }
    export default App
    ```

* `Component`をファイルに分割することは必須ではない

### Class Components

```javascript
import React, { Component } from 'react'

class Table extends Component {
  render() {
    return (
      <table>
        <thead>
          <tr>
            <th>Name</th>
            <th>Job</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>Charlie</td>
            <td>Janitor</td>
          </tr>
          <tr>
            <td>Mac</td>
            <td>Bouncer</td>
          </tr>
          <tr>
            <td>Dee</td>
            <td>Aspiring actress</td>
          </tr>
          <tr>
            <td>Dennis</td>
            <td>Bartender</td>
          </tr>
        </tbody>
      </table>
    )
  }
}

export default Table
```

### Simple Components

* `class`を使わない
   ```javascript
   // table header
   const TableHeader = () => {
     return (
       <thead>
         <tr>
           <th>Name</th>
           <th>Job</th>
         </tr>
       </thead>
     )
   }

   // table body
   const TableBody = () => {
     return (
       <tbody>
       :
       </tbody>
     )
   }

   // Table class
   class Table extends Component {
     render() {
       return (
         <table>
           <TableHeader />
           <TableBody />
         </table>
       )
     }
   }
   ```

* クラスコンポーネントには`render()`を含める必要があり、`戻り値は親要素を1つだけ`返すことができる

* 比較
  ```javascript
  // Simple Component
  const SimpleComponent = () => {
    return <div>Example</div>
  }
  // Class Component
  class ClassComponent extends Component {
    render() {
      return <div>Example</div>
    }
  }

  // note: returnは1行だけならカッコは不要
  ```

## Props

* 現状データはハードコーディングされている
    + データ処理に`Props`と呼ばれるプロパティや状態を利用する

* `React DevTools`で`Table`コンポーネントを見るとデータの配列が表示される
    + ここに格納されているデータは`仮想DOM`と呼ばれる
        - データを実際のDOMと同期させるための高速で効率的な方法

```javascript
// App.js
class App extends Component {
  render() {
    const characters = [
      {
        name: 'Charlie',
        job: 'Janitor',
      },
      :
    ]

    return (
      <div className="container">
        <Table characterData={ characterData } />
      </div>
    )
  }
}

// Table.js

class Table extends Component {
    render() {
        const { characterData } = this.props

        return (
            <table>
                <TableHeader />
                <TableBody characterData={ characterData } />
            </table>
        )
    }
}

const TableBody = p => {
    // リスト項目を操作する際、キー(index)を使用するとよい
    const rows = p.characterData.map((row, index) => {
        // テーブル行にマッピングする
        return (
            <tr key={ index }>
                <td>{ row.name }</td>
                <td>{ row.job }</td>
            </tr>
        )
    })
    return <tbody>{ rows }</tbody>
}
```

* `props`はデータの受け渡しとして効率的な方法だが、Componentはpropsを変更できない(read-only)
    + [参照](https://ja.reactjs.org/docs/components-and-props.html)

## State

* Componentからprivateなデータを更新できる
    + データを変更するには`this.setState()`を使用する
    + 単に`this.state.property`に新しい値を適用しても機能しない
    + The onClick function must pass through a function that returns the removeCharacter() method、 そうしないと自動的に実行されてしまう.
    ```javascript
    <button onClick={() => props.removeCharacter(index)}>Delete</button>
    // onClick={props.removeCharacter(index)} とした場合
    // Cannot update during an existing state transition (such as within `render`). 
    // Render methods should be a pure function of props and state
    ```

```javascript
class App extends Component {
  state = {
    characters: [
      {
        name: 'Charlie',
        // ther rest of the data.
      }
    ],
  }

  render() {
    return (
      <div className="container">
        <Table
          characterData={ characters }
          removeCharacter={ this.removeCharacter } />
      </div>
    )
  }
  
}

removeCharacter = index => {
  const { characters } = this.state

  this.setState({
    characters: characters.filter((character, i) => {
      return i !== index
    }),
  })
}

// Table.js
class Table extends Component {
  render() {
    const { characterData, removeCharacter } = this.props

    return (
      <table>
      <TableHeader />
      <TableBody
        characterData={ characterData }
        removeCaracter={ removeCharacter }
        />
      </table>
    )
  }
}

const TableBody = p => {
    // リスト項目を操作する際、キー(index)を使用するとよい
    const rows = p.characterData.map((row, index) => {
        // テーブル行にマッピングする
        return (
            <tr key={ index }>
                <td>{ row.name }</td>
                <td>{ row.job }</td>
                <td>
                    <button
                        onClick={() => p.removeCharacter(index) }>
                        Delete
                    </buttion>
            </tr>
        )
    })
    return <tbody>{ rows }</tbody>
}
```

## Submitting Form Data

*  (JavaScript)コンストラクタでthisを使う場合、superの呼び出しを強制する
    ```javascript
    class From extends Component {
        constructor(props) {
            // (JavaScript)コンストラクタでthisを使う場合、superの呼び出しを強制する
            
            // thisはまだ使えない
            super(props)
            // 今なら使える
            this.initialState = {
                name: '',
                job: '',
            }

            this.state = this.initialState
        }
    }
    ```

* このフォームの目的
    + フォーム内のフィールドが変更されるたびにFormの状態を更新すること
    + 送信すると、そのすべてのデータがApp状態に渡され、それによってTableが更新される