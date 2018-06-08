# frozen_string_literal: true

require 'c_b_client'
require 'dotenv'

RSpec.describe CBClient, '#initialize' do
  it 'wraps a browser' do
    c = CBClient.new
    expect(c.b).to be_a(Watir::Browser)
  end
end

RSpec.describe CBClient, '#browser' do
  it 'gives a browser that is all logged in' do
    c = CBClient.new
    b = c.browser
    expect(b.body.text).to match(/Logout/)
  end
end

RSpec.describe CBClient, '#add_url' do
  it 'creates a url for the browser to navigate to' do
    expect(CBClient.new.add_url(2, [1, 2, 3])).to \
      eq(ENV['add_url'] + '&id=1&id=2&id=3&c2=2&page=ajax')
  end
end

RSpec.describe CBClient, '#remove_url' do
  it 'creates a url for the browser to navigate to' do
    expect(CBClient.new.remove_url(2, [1, 2, 3])).to \
      eq(ENV['remove_url'] + '&c=2&id=1&id=2&id=3')
  end
end

RSpec.describe CBClient, '#add_ids' do
  it 'successfully adds ids to the collection' do
    c = CBClient.new
    c.add_ids 1_006_087_251, ['pur1.32754067830038']
    expect(c.b.body.text).to \
      eq('coll_id=1006087251|coll_name=testing|' \
         'result=ADD_ITEM_SUCCESS|NumSubmitted=1|NumAdded=1|NumFailed=0')
  end
end

RSpec.describe CBClient, '#remove_ids' do
  it 'successfully removes ids from the collection' do
    c = CBClient.new
    c.remove_ids 1_006_087_251, ['pur1.32754067830038']
    expect(c.b.body.text).to match(/Collection/)
  end
end
