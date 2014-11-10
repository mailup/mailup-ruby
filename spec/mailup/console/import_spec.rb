require 'spec_helper'

describe MailUp::Console::Import do
  before(:each) { init_mailup }

  %w(status confirmation_email_id).each do |method|
    it "should have a #{method} method" do
      @mailup.console.import(1).should respond_to(method.to_sym)
    end
  end

  it "should fire the correct GET request for status" do
    id = rand(100).abs
    @mailup.console.import(id).api.should_receive(:get).with("#{@mailup.console.import(id).api.path}/Import/#{id}")
    @mailup.console.import(id).status
  end

  it "should fire the correct GET request for confirmation_email_id" do
    id = rand(100).abs
    @mailup.console.import(id).api.should_receive(:get).with("#{@mailup.console.import(id).api.path}/Import/#{id}/Sending")
    @mailup.console.import(id).confirmation_email_id
  end
end