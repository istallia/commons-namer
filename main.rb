# --- ライブラリのインポート
require 'open-uri'
require 'json'
require 'fileutils'
require 'win32-clipboard'


# --- APIから作品情報を取得するメソッド
def get_info_work (id)
	json = open("https://public-api.commons.nicovideo.jp/v1/tree/node/#{id}?with_meta=1") do |f|
		JSON.load(f)
	end
	if json['meta']['status'] == 200 then
		return json['data']['node']
	else
		return nil
	end
end
work_data = get_info_work('sm40149394')
puts work_data['title']
