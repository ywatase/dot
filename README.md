# motd用のファイル作成

## 完了済み

 doushi

## datの元作成

    ./convert_gif2ansi.sh file.gif

datとtxtが生成されます

datが上手くいかない場合は、./png2ansi?.pyを作成し、カラー調整します。
convert_gif2ansi.sh に条件分岐を付けておきましょう

## 作ったdatを手直し

width x hight = 20 x 28 にします
doushiを参考にしてください

## dat の確認

    ./ansi_escape.pl file.dat でデータ確認

## txt の生成

datが良い感じになったら.txtを生成します。

    ./ansi_escape.pl file.dat > file.txt
