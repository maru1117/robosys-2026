 #!/bin/bash
 # SPDX-FileCopyrightText: 2026 Takehiro Marumo
 # SPDX-License-Identifier: BSD-3-Clause

 ng () {                               # 関数ngの定義（P18と同じ）
         echo ${1}行目のテスト失敗
         res=1                          # 失敗したことを記録
 }

 res=0                                  # 0: 失敗なし（ngが呼ばれると1になる）

out=$(seq 5 | ./plus)
[ "$?" = 0 ]      || ng "$LINENO"
[ "${out}" = 15 ] || ng "$LINENO"

### STRANGE INPUT ###
out=$(echo あ | ./plus)           #計算できない値を入力してみる
[ "$?" = 1 ]      || ng "$LINENO" #終了ステータスが1なのを確認
[ "${out}" = "" ] || ng "$LINENO" #上の行と入れ替えるとダメ（なぜ？）

out=$(echo | ./plus)              #なにも入力しない
[ "$?" = 1 ]      || ng "$LINENO" #これも異常終了する
[ "${out}" = "" ] || ng "$LINENO"

### kondate NORMAL INPUT ###
# 表記ゆれ（たまご・とり肉・タマネギ・ごはん）と全角スペース対応の確認
out=$(echo "たまご とり肉 タマネギ ごはん" | ./kondate)
expected=$(printf "オムライス\n卵かけご飯\n目玉焼き\n親子丼")
[ "$?" = 0 ]               || ng "$LINENO"
[ "${out}" = "${expected}" ] || ng "$LINENO"

# -m 1 オプション（不足食材1つまで許容）の確認
out=$(printf "じゃがいも\n玉ねぎ\n" | ./kondate -m 1)
expected=$(printf "ジャーマンポテト (不足: ベーコン)\n目玉焼き (不足: 卵)")
[ "$?" = 0 ]               || ng "$LINENO"
[ "${out}" = "${expected}" ] || ng "$LINENO"

# 作れる料理がない場合（正常終了し、標準出力は空）
out=$(echo "未知の食材" | ./kondate)
[ "$?" = 0 ]      || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

### kondate STRANGE INPUT ###
# 空入力（異常終了1、標準出力は空）
out=$(echo "" | ./kondate 2>/dev/null)
[ "$?" = 1 ]      || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

# 不正なオプション値（負の数値）
out=$(echo "卵" | ./kondate -m -1 2>/dev/null)
[ "$?" = 1 ]      || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

# 数値以外のオプション値
out=$(echo "卵" | ./kondate -m abc 2>/dev/null)
[ "$?" = 2 ]      || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

[ "${res}" = 0 ] && echo OK
exit $res
