# frozen_string_literal: true

require 'spec_helper'

describe MailUp::Console::Email do
  before(:each) { init_mailup }

  %w[send].each do |method|
    it "should have a #{method} method" do
      @mailup.console.email.should respond_to(method.to_sym)
    end
  end

  it 'should fire the correct POST request for send' do
    email = 'test@email.com'
    id = rand(100).abs
    @mailup.console.email.api.should_receive(:post).with("#{@mailup.console.email.api.path}/Email/Send", body: { idMessage: id, Email: email })
    @mailup.console.email.send(id, email)
  end
end
