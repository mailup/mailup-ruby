# frozen_string_literal: true

require 'spec_helper'

describe MailUp::Public::Console do
  before(:each) { init_mailup }

  %w[activate_trial status].each do |method|
    it "should have a #{method} method" do
      @mailup.public.console.should respond_to(method.to_sym)
    end
  end

  it 'should fire the correct POST request for activate_trial' do
    payload = Date._jisx0301('empty hash, please')
    @mailup.public.console.api.should_receive(:provisioning_request).with("#{@mailup.public.console.api.path}/Console/TrialActivation", payload)
    @mailup.public.console.activate_trial(payload)
  end

  it 'should fire the correct POST request for status' do
    payload = Date._jisx0301('empty hash, please')
    @mailup.public.console.api.should_receive(:provisioning_request).with("#{@mailup.public.console.api.path}/Console/TrialActivationStatus", payload)
    @mailup.public.console.status(payload)
  end
end
