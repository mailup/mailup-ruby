require 'spec_helper'

describe MailUp::Console::Images do
  before(:each) { init_mailup }

  %w(add_image delete_image list).each do |method|
    it "should have a #{method} method" do
      @mailup.console.images.should respond_to(method.to_sym)
    end
  end

  it "should fire the correct GET request for list" do
    @mailup.console.images.api.should_receive(:get).with("#{@mailup.console.images.api.path}/Images")
    @mailup.console.images.list
  end

  it "should fire the correct POST request for add_image" do
    payload = Date._jisx0301("empty hash, please")
    @mailup.console.images.api.should_receive(:post).with("#{@mailup.console.images.api.path}/Images", {body: payload})
    @mailup.console.images.add_image(payload)
  end

  it "should fire the correct DELETE request for delete_image" do
    path = "/Test/Image/Path"
    @mailup.console.images.api.should_receive(:delete).with("#{@mailup.console.images.api.path}/Images", {body: path})
    @mailup.console.images.delete_image(path)
  end

end