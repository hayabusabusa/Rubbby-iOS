<div align="center">
    <img src="https://user-images.githubusercontent.com/31949692/74712339-66534b80-5269-11ea-8fbe-6c25506e095e.png"  title="Header">
</div>

## アプリについて
# TODO:アプリについて書く

## 事前準備
### アプリケーションIDについて
本アプリではgoo様より公開されている [ひらがな化API](https://labs.goo.ne.jp/api/jp/hiragana-translation/) を利用しています。  
上記APIを使用するためには**アプリケーションID**が必要になるため、事前に発行して準備をお願いいたします。  

また、コード上で使用するためのファイルをGitの管理対象から外しているため、  
以下のコマンドを実行してファイルを追加してください。

```Shell
make inject-app-id APP_ID=/*YOUR_APP_ID*/
```

### Carthageについて
本アプリではライブラリの管理ツールとして [Carthage](https://github.com/Carthage/Carthage) を使用しています。  
初回プロジェクトビルド時はライブラリのビルドが必要なので、以下のコマンドを実行してライブラリのビルドを実行してください。  

```Shell
carthage bootstrap --platform iOS
```

## 構成
本アプリでは **MVVM** アーキテクチャーを採用しています。  
**Model**、**View**、**ViewModel**の3つの層で分かれていて、それぞれ以下のような構成になっています。

```
ProjectRoot
    ┠ Model
    ┃   ┠ Entity # APIのレスポンスなど
    ┃   ┠ Network # MoyaなどのAPI関連
    ┃   ┠ Repository # APIやデータベースの処理を取りまとめ
    ┃   ┗ Translator # Entity -> Viewに表示するデータへの変換
    ┠ View # ViewControllerとStoryboard、xibのUI関連
    ┗ ViewModel # ViewModelのみ
```

## 使用ライブラリ
- [RxSwift](https://github.com/ReactiveX/RxSwift)
- [Moya](https://github.com/Moya/Moya)
- [NVActivityIndicatorView](https://github.com/ninjaprox/NVActivityIndicatorView)
- [IQKeyboardManager](https://github.com/hackiftekhar/IQKeyboardManager)

## 参考にしたOSS
MVVMアーキテクチャーでアプリを開発するにあたって、以下のOSSを参考にしました。

### [kickstarter](https://github.com/kickstarter/ios-oss)  
`UIStoryboard`から`UIViewController`を[生成する部分](https://github.com/kickstarter/ios-oss/blob/master/Kickstarter-iOS/Library/Storyboard.swift)、  
`UIStoryboard`を使用した場合の`UIViewController`へ[依存するオブジェクトの渡し方](https://github.com/kickstarter/ios-oss/blob/master/Kickstarter-iOS/Views/Controllers/BackingViewController.swift#L45)を参考にしました。

### [GiTiny](https://github.com/k-lpmg/GiTiny)
MVVMにおける**ViewModel**の作り方を参考にしました。  
**ViewModel**に**Input**と**Output**を`associatedType`として持つ[protocol](https://github.com/k-lpmg/GiTiny/blob/master/GiTiny/Sources/Application/Protocols/ViewModelType.swift)を継承させて、**View**側から使用する際には必ず**Output**を経由させるような作りになっています。

### [Wei Wallet](https://github.com/popshootjapan/WeiWallet-iOS)
`UIViewController`間の遷移を参考にしました。  
**ViewModel**から**Output**として`Driver<Void>`を公開し、  
**View**側で`drive`してイベントが発行されたタイミングで遷移するようになっています。  

## デザイン
[Figma](https://www.figma.com/)を使用してアプリのアイコンの作成、画面のデザインなどを行いました。  
