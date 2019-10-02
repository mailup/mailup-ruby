# frozen_string_literal: true

require 'spec_helper'

# Stats::Message Methods
describe MailUp::Stats::Message do
  before(:each) { init_mailup }

  %w[recipients recipients_count views views_count bounces bounces_count unsubscribes unsubscribes_count clicks clicks_count url_clicks url_clicks_count].each do |method|
    it "should have a #{method} method" do
      @mailup.stats.message(1).should respond_to(method.to_sym)
    end
  end

  # List methods

  %w[recipients views bounces clicks url_clicks].each do |method|
    it "should fire the correct GET request for #{method}" do
      @mailup.stats.message(1).api.should_receive(:get).with("#{@mailup.stats.message(1).api.path}/Message/1/List/#{method.split('_').collect(&:capitalize).join}", params: {})
      @mailup.stats.message(1).send(method.to_sym)
    end
  end

  # Count methods

  %w[recipients_count views_count bounces_count clicks_count].each do |method|
    it "should fire the correct GET request for #{method}" do
      @mailup.stats.message(1).api.should_receive(:get).with("#{@mailup.stats.message(1).api.path}/Message/1/Count/#{method.split('_').first.capitalize}")
      @mailup.stats.message(1).send(method.to_sym)
    end
  end

  it 'should fire the correct GET request for url_clicks_count' do
    @mailup.stats.message(1).api.should_receive(:get).with("#{@mailup.stats.message(1).api.path}/Message/1/Count/UrlClicks")
    @mailup.stats.message(1).url_clicks_count
  end
end
