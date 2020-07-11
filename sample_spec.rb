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

# 'git'がインストールされているか確認
#describe package('git') do
#  it { should be_installed }
#end

# 複数の必須パッケージがインストールされているか
#%w{autoconf bison flex gcc gcc-c++ kernel-devel make m4}.each do |pkg|
#  describe package(pkg) do
#    it { should be_installed }
#  end
#end

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

# port22がListenしているか確認
#describe port("22") do
#  it { should be_listening }
#end

# port80がListenしているか確認
#describe port("80") do
#  it { should be_listening }
#end

# port443がListenしているか確認
#describe port("443") do
#  it { should be_listening }
#end

# port3000がListenしているか確認
#describe port("3000") do
#  it { should be_listening }
#end



##### ユーザーとグループ #####

# グループが存在するか確認
#describe group('admin') do
#  it { should exist }
#end

# 'kohei'ユーザーが'admin'グループに所属しているか確認
describe user('kohei') do
  it { should belong_to_group 'admin' }
end



##### OS毎にテストしたい場合の書き方 #####

#describe package('httpd'), :if => os[:family] == 'redhat' do
#  it { should be_installed }
#end
