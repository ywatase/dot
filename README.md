# motd用のファイル作成

## 完了済み

* 導師
* 戦士
* モンク
* 黒魔道士
* 白魔道士

## datの元作成

    ./convert_gif2ansi.sh gif/file.gif

datとtxtが生成されます

datの色の識別が上手くいかない場合は、./png2ansi?.pyを作成し、カラー調整します。
convert_gif2ansi.sh に条件分岐を付けておきましょう

ANSI Colorではbgcolorとして使えるのは8色(40-47)しかありません。
そのため、茶色など発色しないものは別の色に換えるしかありません。

## 作ったdatを手直し

width x hight = 20 x 28 にします
導師を参考にしてください

## dat の確認

    ./ansi_escape.pl dat/file.dat でデータ確認

## txt の生成

datが良い感じになったら.txtを生成します。

    ./ansi_escape.pl dat/file.dat > motd/file.txt
