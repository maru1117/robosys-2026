# kondate(料理提案)
![test](https://github.com/maru1117/robosys-2026/actions/workflows/test.yml/badge.svg)

### kondateコマンド
標準入力から与えた手持ちの食材をもとに、作れる料理を標準出力に提案します。表記ゆれ（「たまご」「卵」など）の統一や、不足食材の許容オプション（`-m`）に対応しています。

#### インストール・準備
```bash
$ git clone https://github.com/maru1117/robosys-2026.git
$cd robosys-2026
$ chmod +x kondate
```

## 使い方・実行例
```bash
$ printf "卵\n鶏肉\n玉ねぎ\nご飯\n" | ./kondate
オムライス
卵かけご飯
目玉焼き
親子丼
```

-mオプションを指定すると、指定した数だけ食材が足りない料理も不足食材名つきで提案します。
```bash
$ printf "じゃがいも\n玉ねぎ\n" | ./kondate -m 1
ジャーマンポテト (不足: ベーコン)
目玉焼き (不足: 卵)
```

## 必要なソフトウェア
- Python
  - テスト済みバージョン: 3.10〜3.14

## テスト環境
- Ubuntu 24.04 LTS

## ライセンス
- このソフトウェアパッケージは、3条項BSDライセンスの下、再頒布および使用が許可されます。
- © 2026 Takehiro Marumo

