# frozen_string_literal: true

require 'spec_helper'

describe MailUp::Console::Recipient do
  before(:each) { init_mailup }

  %w[update fields].each do |method|
    it "should have a #{method} method" do
      @mailup.console.recipient.should respond_to(method.to_sym)
    end
  end
end
