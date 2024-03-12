# BariPortMobile
## TL; DR;
JAPAN CONNECT HACKTHON 用リポジトリ

### Setup
```bash
brew install xcodegen
brew install rbenv
rbenv install `cat .ruby-version`
make
```

> [!NOTE]
> `rbenv`でのインストールにこけるときはこの辺が参考になります．
> https://autovice.jp/articles/178

### 新しい画面の追加
```bash
make generate-screen
```
で生成されます．
ディレクトリ配置は`機能名/Screens/画面名`で追加されます．

`Feature Name`と`Screen Name`が聞かれるので, 機能名と画面名を入れてください！
`Interactor`は画面とついになる存在ではないですが，テンプレートを使っている以上生成されるので，必要なければ捨てて
`機能名/Logics/ロジック名`で配置して使って行くといいと思います！
