# motd用のファイル作成

## 完了済み

* 導師
* 戦士
* モンク
* 黒魔道士
* 白魔道士

## チェック待ち

* ナイト
* 赤魔道士
* 賢者
* 忍者
* たまねぎ剣士
* シーフ
* 学者

* 魔界幻士
* 幻術士
* 空手家

## datの元作成

    ./convert_gif2ansi.sh gif/file.gif

datとtxtが生成されます

datの色の識別が上手くいかない場合は、./png2ansi.pyに読ませるcolor paletteを作成します。
palette.default.json を参考にしてください
convert_gif2ansi.sh に条件分岐を付けておきましょう

ANSI Colorではbgcolorとして使えるのは8色(40-47)しかありません。
そのため、茶色など発色しないものは別の色に換えるしかありません。

## 作ったdatを手直し

生成されたファイルは16 x 24です

空文字行 x 2 を上下に追加、左に 1 列、右に 2 列追加します。

width x hight = 19 x 28 になります。
追加した空白のうち、上下右の一番外側の一行、一列は空白文字のままにします。

導師を参考にしてください
よくわからない場合は、

    ./convert_gif2ansi.sh gif/doushi_stand.gif

を実行して差分を見てください

## dat の確認

    ./ansi_escape.pl dat/file.dat でデータ確認

## txt の生成

datが良い感じになったら.txtを生成します。

    ./ansi_escape.pl dat/file.dat > motd/file.txt

## gifファイルの取得元

http://www.biwa.ne.jp/~tak-n/dot/ff3/
