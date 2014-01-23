require 'spec_helper'

# Stats::Recipient Methods
describe MailUp::Stats::Recipient do
  before(:each) { init_mailup }

  %w(deliveries deliveries_count views views_count bounces_details bounces bounces_count unsubscribes unsubscribes_count clicks_details clicks clicks_count).each do |method|
    it "should have a #{method} method" do
      @mailup.stats.recipient(1).should respond_to(method.to_sym)
    end
  end

  # List methods

  %w(deliveries views bounces_details bounces clicks_details clicks).each do |method|
    it "should fire the correct GET request for #{method}" do
      @mailup.stats.recipient(1).api.should_receive(:get).with("#{@mailup.stats.recipient(1).api.path}/Recipient/1/List/#{method.split('_').collect(&:capitalize).join}", {params: {}})
      @mailup.stats.recipient(1).send(method.to_sym)
    end
  end

  it "should fire the correct GET request for unsubscribes" do
    @mailup.stats.recipient(1).api.should_receive(:get).with("#{@mailup.stats.recipient(1).api.path}/Recipient/1/List/Unsubscriptions", {params: {}})
    @mailup.stats.recipient(1).unsubscribes
  end

  # Count methods

  %w(deliveries_count views_count bounces_count clicks_count).each do |method|
    it "should fire the correct GET request for #{method}" do
      @mailup.stats.recipient(1).api.should_receive(:get).with("#{@mailup.stats.recipient(1).api.path}/Recipient/1/Count/#{method.split('_').first.capitalize}")
      @mailup.stats.recipient(1).send(method.to_sym)
    end
  end

  it "should fire the correct GET request for unsubscribes_count" do
    @mailup.stats.recipient(1).api.should_receive(:get).with("#{@mailup.stats.recipient(1).api.path}/Recipient/1/Count/Unsubscriptions")
    @mailup.stats.recipient(1).unsubscribes_count
  end
end