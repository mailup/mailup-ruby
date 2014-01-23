require 'spec_helper'

describe MailUp::Console::User do
  before(:each) { init_mailup }

  %w(emails lists).each do |method|
    it "should have a #{method} method" do
      @mailup.console.user.should respond_to(method.to_sym)
    end

    it "should fire the correct GET request for #{method}" do
      @mailup.console.user.api.should_receive(:get).with("#{@mailup.console.user.api.path}/User/#{method.capitalize}", {params: {}})
      @mailup.console.user.send(method.to_sym)
    end
  end
end