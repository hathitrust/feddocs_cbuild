# frozen_string_literal: true

require 'webdrivers'
require 'watir'
require 'headless'
require 'dotenv'
require 'pp'
Dotenv.load!

# Wrapper around a headless Watir Browser.
# There is no real API for Collection Builder so we have to fake it.
class CBClient
  attr_accessor :b
  attr_accessor :collection_id
  attr_accessor :ht_ids

  def initialize
    browser
  end

  def chunk_size
    @chunk_size || 100
  end

  def add_url(collection_id, ht_ids)
    ENV['add_url'] + "&id=#{ht_ids.join('&id=')}&c2=#{collection_id}&page=ajax"
  end

  def remove_url(collection_id, ht_ids)
    ENV['remove_url'] + "&c=#{collection_id}&id=#{ht_ids.join('&id=')}"
  end

  def browser
    return @b if @b
    headless = Headless.new
    headless.start
    @b = Watir::Browser.new
    @b.goto 'https://babel.hathitrust.org/cgi/mb?colltype=my-collections'
    @b.link(id: 'login-link').click
    @b.button(class: 'continue').click
    sleep(3)
    @b.text_field(id: 'login').set(ENV['username'])
    @b.text_field(id: 'password').set(ENV['password'])
    @b.button(id: 'loginSubmit').click
    @b
  end

  def add_ids(collection_id, ht_ids)
    ht_ids.each_slice(chunk_size) do |ids|
      @b.goto add_url collection_id, ids
      sleep(1)
    end
  end

  def remove_ids(collection_id, ht_ids)
    ht_ids.each_slice(chunk_size) do |ids|
      @b.goto remove_url collection_id, ids
    end
  end

  def destroy
    headless.destroy
  end
end

if $PROGRAM_NAME == __FILE__
  cb = CBClient.new
  case ARGV[0]
  when 'add'
    cb.add_ids ARGV[1], File.open(ARGV[2])
    puts cb.b.body.text
  when 'remove' || 'delete'
    cb.remove_ids ARGV[1], File.open(ARGV[2])
    puts cb.b.body.text
  end
end
