# PowerQueryLibrary
普段よく使う関数を再利用可能にすることができるようライブラリにまとめたものです。
### 使用方法
使用したいエクセルのブックで下記のクエリを作ります。<br/>
```M
Expression.Evaluate(
    Text.FromBinary(
        Web.Contents(["[githubのpath]")
    )
)
```
クエリの名前は例えばLibraryとします。   
他のクエリでこのLibraryの関数を使いたい場合は、次のようにします。  
  
  【例】List.Allocateを使いたい場合  

  関数を使用する前に、次のコードを入れます。
```M
List.Allocate = Library[List.Allocate],
```
List.Allocateが、ライブラリの中で定義されている関数を使っていても、上記のコードだけで動きます。
