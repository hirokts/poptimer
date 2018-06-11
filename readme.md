## 概要

Ubuntu上で、5分間もしくは指定の分数や秒数でのデスクトップ通知を行うだけのコマンドです。

## インストール
```
sudo cp ./poptimer.sh /usr/local/bin/poptimer
sudo chmod +x /usr/local/bin/poptimer
```

## 使い方
```
Usage: poptimer [-m <minutes>] [-s <seconds>]

オプション:
  -h, --help
  -s, --time-seconds <seconds>     [任意] *オプション指定時は秒数を設定
  -m, --time-minutes <seconds>     [任意] *オプション指定時は分数を設定
```

## デスクトップのお気に入りに追加して任意のタイミングで起動する
```
cp ./poptimer.desktop ~/.local/share/applications/
```
1. super keyでpoptimerなどと検索する
（アイコンはUbuntu標準のやつを流用しています）

2. 右クリックでお気に入りに追加


