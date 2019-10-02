# frozen_string_literal: true

require 'spec_helper'

describe MailUp::Stats do
  before(:each) { init_mailup }

  it 'should return a stats base object' do
    @mailup.stats.should be_an_instance_of(MailUp::Stats::Base)
  end

  it 'should have the correct API path' do
    @mailup.stats.api.path.should eq("/API/v#{MailUp::API_VERSION}/Rest/MailStatisticsService.svc")
  end

  %w[message recipient].each do |resource|
    context resource do
      it "should return a #{resource} object" do
        test = @mailup.stats.send(resource.to_sym, 1)
        test.should be_an_instance_of(Object.const_get('MailUp').const_get('Stats').const_get(resource.capitalize.to_s))
      end
    end
  end
end
