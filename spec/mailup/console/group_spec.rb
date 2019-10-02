# frozen_string_literal: true

require 'spec_helper'

describe MailUp::Console::Group do
  before(:each) { init_mailup }

  %w[add_recipients recipients subscribe unsubscribe send_message].each do |method|
    it "should have a #{method} method" do
      @mailup.console.group(1).should respond_to(method.to_sym)
    end
  end

  it 'should fire the correct POST request for add_recipients' do
    payload = Date._jisx0301('empty hash, please')
    @mailup.console.group(1).api.should_receive(:post).with("#{@mailup.console.group(1).api.path}/Group/1/Recipients", body: payload, params: {})
    @mailup.console.group(1).add_recipients(payload)
  end

  it 'should fire the correct POST request for add_recipient' do
    payload = Date._jisx0301('empty hash, please')
    @mailup.console.group(1).api.should_receive(:post).with("#{@mailup.console.group(1).api.path}/Group/1/Recipient", body: payload, params: {})
    @mailup.console.group(1).add_recipient(payload)
  end

  it 'should fire the correct GET request for recipients' do
    payload = Date._jisx0301('empty hash, please')
    @mailup.console.group(1).api.should_receive(:get).with("#{@mailup.console.group(1).api.path}/Group/1/Recipients", params: {})
    @mailup.console.group(1).recipients
  end

  it 'should fire the correct POST request for subscribe' do
    id = rand(100).abs
    @mailup.console.group(1).api.should_receive(:post).with("#{@mailup.console.group(1).api.path}/Group/1/Subscribe/#{id}")
    @mailup.console.group(1).subscribe(id)
  end

  it 'should fire the correct DELETE request for unsubscribe' do
    id = rand(100).abs
    @mailup.console.group(1).api.should_receive(:delete).with("#{@mailup.console.group(1).api.path}/Group/1/Unsubscribe/#{id}")
    @mailup.console.group(1).unsubscribe(id)
  end

  it 'should fire the correct POST request for send_message' do
    id = rand(100).abs
    @mailup.console.group(1).api.should_receive(:post).with("#{@mailup.console.group(1).api.path}/Group/1/Email/#{id}/Send", params: {})
    @mailup.console.group(1).send_message(id)
  end
end
