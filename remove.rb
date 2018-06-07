require 'webdrivers'
require 'watir'
require 'dotenv'
require 'pp'
require 'headless'

headless = Headless.new
headless.start
Dotenv.load!
b = Watir::Browser.new

b.goto 'https://babel.hathitrust.org/cgi/mb?colltype=my-collections'
b.link(:id => 'login-button').click
b.button(:class => 'continue').click
sleep(3)
b.text_field(:id => 'login').set(ENV['username'])
b.text_field(:id => 'password').set(ENV['password'])
b.button(:id => 'loginSubmit').click
sleep 1
#all logged in

collection_id = ARGV.shift
id_file = ARGV.shift
base_url = "https://babel.hathitrust.org/cgi/mb?c=#{collection_id}&a=delit&adm=1&sort=title_a" #&id=#{ht_id}&c=#{collection_id}&page=ajax
chunk_size = 1
ht_ids = []
open(id_file).each do | line |
  if ht_ids.count >= chunk_size
    url = base_url + "&id=#{ht_ids.join("&id=")}&c2=0"
    b.goto url
    #be polite
    sleep(2)
    ht_ids = []
  end
  ht_ids << line.chomp
end
url = base_url + "&id=#{ht_ids.join("&id=")}&c2=0"
b.goto url
puts b.body.text
headless.destroy
