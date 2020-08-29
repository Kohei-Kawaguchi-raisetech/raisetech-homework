require 'spec_helper'



##### 環境の確認 #####

# 実行ユーザーが'kohei'であることを確認
describe command('whoami') do
  its(:stdout) { should match 'kohei' }
end



##### パッケージがインストールされているか（Ver.）のテスト #####

# インストールされたRubyのバージョンが'2.5.1'であることを確認
describe command('ruby -v') do
  its(:stdout) { should match /ruby 2\.5\.1/ }
end

# インストールされたRailsのバージョンが'6.0.3.2'であることを確認
describe command('rails -v') do
  its(:stdout) { should match /Rails 6\.0\.3\.2/ }
end

# 'mysql'がインストールされているか確認
describe package('mysql') do
  it { should be_installed }
end

# インストールされたgitのバージョンが'2.2.0.1'であることを確認
describe command('git --version') do
  its(:stdout) { should match /git version 2\.20\.1/ }
end

# インストールされたHomebrewのバージョンが'2.4.2'であることを確認
describe command('brew -v') do
  its(:stdout) { should match /Homebrew 2\.4\.2/ }
end

# インストールされたbundlerのバージョンが'2.1.4'であることを確認
describe package('bundler') do
  it { should be_installed.by('gem').with_version('2.1.4') }
end



##### サービスの稼働状況のテスト #####

# インストールされたMySQLが'自動起動'かつ'起動'していることを確認 
describe service('mysql') do
  it { should be_enabled }
  it { should be_running }
end



##### TCP、UDOのポートの稼働状態の確認 #####

# port番号33060で実行中のプロセスがmysqldであることを確認
describe command('sudo lsof -i:33060 -P') do
  its(:stdout) { should match /mysqld/ }
end



##### ユーザーとグループ #####

# 'kohei'ユーザーが'admin'グループに所属しているか確認
describe user('kohei') do
  it { should belong_to_group 'admin' }
end



##### おまけ（OS毎にテストしたい場合の書き方） #####

#describe package('httpd'), :if => os[:family] == 'redhat' do
#  it { should be_installed }
#end