# --- ライブラリのインポート
require 'open-uri'
require 'json'
require 'fileutils'
require 'win32-clipboard'
ENV['SSL_CERT_FILE'] = File.join(File.dirname($0), 'cert.pem')


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


# --- APIからユーザー情報を取得するメソッド
def get_info_user (id)
	json = open("https://account.nicovideo.jp/api/public/v1/users/#{id}.json") do |f|
		JSON.load(f)
	end
	if json['meta']['status'] == 200 then
		return json['data']
	else
		return nil
	end
end


def replace_special_chars (filename)
	special_chars = {
		'\\' => '＼',
		'/'  => '／',
		':'  => '：',
		'*'  => '＊',
		'?'  => '？',
		'<'  => '＜',
		'>'  => '＞',
		'|'  => '｜',
		'.'  => '．',
		','  => '，'
	}
	special_chars.each do |from, to|
		filename.gsub!(from, to)
	end
	return filename
end


# --- 新たな名前を生成するメソッド
def get_new_name (pattern, id)
	work_info = get_info_work(id)
	return nil if !work_info
	filename = pattern.gsub('${id}', id).gsub('${title}', work_info['title'])
	if pattern.include? '${creator}' then
		user_info = get_info_user(work_info['userId'])
		return nil if !user_info
		filename.gsub!('${creator}', user_info['nickname'])
	end
	return filename
end


# --- 設定を読み込み
config = File.open('./config.json', mode='r') do |f|
	JSON.load(f)
end


# --- クリップボード置換
if ARGV.length < 1 then
	clip_pattern = /^(?:sm|im|nc|td|lv|gm)\d{1,12}$/
	clip_text    = Win32::Clipboard.data(Win32::Clipboard::UNICODETEXT)
	if clip_pattern.match?(clip_text) then
		replaced_text = get_new_name(config['copy_pattern'], clip_text)
		Win32::Clipboard.set_data(replaced_text, Win32::Clipboard::UNICODETEXT)
	end
	exit
end


# --- ファイルがあればファイル名を変更
file_pattern = /^((?:sm|im|nc|td|lv|gm)\d{1,12})(\.[\w\-]{1,12})$/
ARGV.each do |filepath|
	abspath  = File.expand_path(filepath)
	dirpath  = File.dirname(abspath)
	filename = File.basename(abspath)
	id, ext  = file_pattern.match(filename).to_a.values_at(1, 2)
	if id then
		new_filename = get_new_name(config['file_pattern'], id)
		if new_filename then
			new_filename = replace_special_chars(new_filename) + ext
			if config['rename_mode'] == 'copy' then
				FileUtils.cp abspath, "#{dirpath}/#{new_filename}", {:preserve => true}
			else
				FileUtils.mv abspath, "#{dirpath}/#{new_filename}", {:secure => true}
			end
		end
	end
end
