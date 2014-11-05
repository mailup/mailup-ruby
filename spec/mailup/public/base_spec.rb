require 'spec_helper'

describe MailUp::Public do
  before(:each){ init_mailup }

  it 'should return a public base object' do
    @mailup.public.should be_an_instance_of(MailUp::Public::Base)
  end

  it 'should have the correct API path' do
    @mailup.public.api.path.should eq("/API/v#{MailUp::API_VERSION}/Rest/PublicService.svc")
  end

  %w(console).each do |resource|
    context resource do
      it "should return a #{resource} object" do
        test = @mailup.public.send(resource.to_sym)
        test.should be_an_instance_of(Object.const_get("MailUp").const_get("Public").const_get("#{resource.capitalize}"))
      end
    end
  end
end