require 'spec_helper'

describe MailUp::Public::Console do
  before(:each) { init_mailup }

  %w(new status).each do |method|
    it "should have a #{method} method" do
      @mailup.public.console.should respond_to(method.to_sym)
    end
  end

  it "should fire the correct POST request for new" do
    payload = Date._jisx0301("empty hash, please")
    @mailup.public.console.api.should_receive(:post).with("#{@mailup.public.console.api.path}/Console/TrialActivation", {body: payload})
    @mailup.public.console.new(payload)
  end

  it "should fire the correct POST request for status" do
    payload = Date._jisx0301("empty hash, please")
    @mailup.public.console.api.should_receive(:post).with("#{@mailup.public.console.api.path}/Console/TrialActivationStatus", {body: payload})
    @mailup.public.console.status(payload)
  end

end