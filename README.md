# コモンズネーマー r1

ニコニ・コモンズ素材のファイル名にタイトルや投稿者名を付与するソフト

## 使い方

リネームしたいファイルをこのソフトにD&Dすると、ニコニコと通信して情報を取得し、リネームします  
ファイルを指定せずそのまま起動した場合、クリップボードにID単体が入っているとき情報を取得して置き換えます

## 設定

同梱の`config.json`をテキストエディタで編集してください

	{
		"file_pattern" : "${id}_${title}",
		"copy_pattern" : "${title} (${id}) by ${creator}",
		"rename_mode"  : "copy"
	}

| 名称 | 説明 |
| --- | --- |
| file_pattern | ファイル名を置き換えるときのパターン |
| copy_pattern | クリップボードのIDを置き換えるときのパターン |
| rename_mode  | ファイル名を置き換える際、コピーするかリネームするか。"copy"または"move" |

## ビルド方法

必要なgemを入れます

	gem install win32-clipboard

で、まず動くことを確認します  
そして、なにかの素材のID(`nc235560`など)をクリップボードに入れた状態で

	ocra main.rb cert.pem

すれば`main.exe`が出来上がります  
(ocraもgemで入れる必要があったかも)
