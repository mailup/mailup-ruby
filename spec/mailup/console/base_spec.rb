require 'spec_helper'

# Console API Methods
describe MailUp::Console do
  before(:each){ init_mailup }

  it 'should return a console base object' do
    @mailup.console.should be_an_instance_of(MailUp::Console::Base)
  end

  it 'should have the correct API path' do
    @mailup.console.api.path.should eq("/API/v#{MailUp::API_VERSION}/Rest/ConsoleService.svc/Console")
  end

  %w(email images recipient user).each do |resource|
    context resource do
      it "should return a #{resource} object" do
        test = @mailup.console.send(resource.to_sym)
        test.should be_an_instance_of(Object.const_get("MailUp").const_get("Console").const_get("#{resource.capitalize}"))
      end
    end
  end

  %w(group import list).each do |resource|
    context resource do
      it "should return a #{resource} object" do
        test = @mailup.console.send(resource.to_sym, 1)
        test.should be_an_instance_of(Object.const_get("MailUp").const_get("Console").const_get("#{resource.capitalize}"))
      end
    end
  end

end