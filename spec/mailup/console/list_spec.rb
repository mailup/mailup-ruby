require 'spec_helper'

describe MailUp::Console::List do
  before(:each) { init_mailup }

  %w(groups add_group update_group delete_group recipient_groups pending subscribed unsubscribed import_recipients subscribe unsubscribe tags add_tag update_tag delete_tag attachments add_attachment delete_attachment images add_image add_message_from_template add_message update_message update_message_visibility delete_message message_details emails online_emails archived_emails send_history send_message templates template_details).each do |method|
    it "should have a #{method} method" do
      @mailup.console.list(1).should respond_to(method.to_sym)
    end
  end

  # GET requests

  %w(groups tags images emails templates).each do |method|
    it "should fire the correct GET request for #{method}" do
      @mailup.console.list(1).api.should_receive(:get).with("#{@mailup.console.list(1).api.path}/List/1/#{method.capitalize}", {params: {}})
      @mailup.console.list(1).send(method.to_sym)
    end
  end

  %w(pending subscribed unsubscribed).each do |method|
    it "should fire the correct GET request for #{method}" do
      @mailup.console.list(1).api.should_receive(:get).with("#{@mailup.console.list(1).api.path}/List/1/Recipients/#{method.capitalize}", {params: {}})
      @mailup.console.list(1).send(method.to_sym)
    end
  end

  %w(online_emails archived_emails).each do |method|
    it "should fire the correct GET request for #{method}" do
      @mailup.console.list(1).api.should_receive(:get).with("#{@mailup.console.list(1).api.path}/List/1/#{method.split('_').first.capitalize}/Emails", {params: {}})
      @mailup.console.list(1).send(method.to_sym)
    end
  end

  it "should fire the correct GET request for recipient_groups" do
    @mailup.console.list(1).api.should_receive(:get).with("#{@mailup.console.list(1).api.path}/List/1/Recipient/2/Groups", {params: {}})
    @mailup.console.list(1).recipient_groups(2)
  end

  it "should fire the correct GET request for attachments" do
    @mailup.console.list(1).api.should_receive(:get).with("#{@mailup.console.list(1).api.path}/List/1/Email/2/Attachment", {params: {}})
    @mailup.console.list(1).attachments(2)
  end

  it "should fire the correct GET request for message_details" do
    @mailup.console.list(1).api.should_receive(:get).with("#{@mailup.console.list(1).api.path}/List/1/Email/2")
    @mailup.console.list(1).message_details(2)
  end

  it "should fire the correct GET request for send_history" do
    @mailup.console.list(1).api.should_receive(:get).with("#{@mailup.console.list(1).api.path}/List/1/Email/2/SendHistory", {params: {}})
    @mailup.console.list(1).send_history(2)
  end

  it "should fire the correct GET request for template_details" do
    @mailup.console.list(1).api.should_receive(:get).with("#{@mailup.console.list(1).api.path}/List/1/Templates/2")
    @mailup.console.list(1).template_details(2)
  end

  # POST requests

  %w(add_group).each do |method|
    it "should fire the correct POST request for #{method}" do
      payload = Date._jisx0301("empty hash, please")
      @mailup.console.list(1).api.should_receive(:post).with("#{@mailup.console.list(1).api.path}/List/1/#{method.split('_').last.capitalize}", {body: payload})
      @mailup.console.list(1).send(method.to_sym, payload)
    end
  end

  it "should fire the correct POST request for import_recipients" do
    payload = Date._jisx0301("empty hash, please")
    @mailup.console.list(1).api.should_receive(:post).with("#{@mailup.console.list(1).api.path}/List/1/Recipients", {body: payload, params: {}})
    @mailup.console.list(1).send(:import_recipients, payload)
  end

  it "should fire the correct POST request for import_recipients and email optin" do
    payload = Date._jisx0301("empty hash, please")
    @mailup.console.list(1).api.should_receive(:post).with("#{@mailup.console.list(1).api.path}/List/1/Recipients",
      {body: payload, params: {ConfirmEmail: true}})
    @mailup.console.list(1).send(:import_recipients, payload, {ConfirmEmail: true})
  end

  it "should fire the correct POST request for subscribe" do
    payload = rand(100).abs
    @mailup.console.list(1).api.should_receive(:post).with("#{@mailup.console.list(1).api.path}/List/1/Subscribe/#{payload}")
    @mailup.console.list(1).subscribe(payload)
  end

  it "should fire the correct POST request for add_tag" do
    payload = "Tag Name"
    @mailup.console.list(1).api.should_receive(:post).with("#{@mailup.console.list(1).api.path}/List/1/Tag", {body: payload})
    @mailup.console.list(1).add_tag(payload)
  end

  it "should fire the correct POST request for add_attachment" do
    message = slot = rand(100).abs
    payload = Date._jisx0301("empty hash, please")
    @mailup.console.list(1).api.should_receive(:post).with("#{@mailup.console.list(1).api.path}/List/1/Email/#{message}/Attachment/#{slot}", {body: payload})
    @mailup.console.list(1).add_attachment(message, slot, payload)
  end

  it "should fire the correct POST request for add_image" do
    payload = Date._jisx0301("empty hash, please")
    @mailup.console.list(1).api.should_receive(:post).with("#{@mailup.console.list(1).api.path}/List/1/Images", {body: payload})
    @mailup.console.list(1).add_image(payload)
  end

  it "should fire the correct POST request for add_message_from_template" do
    payload = rand(100).abs
    @mailup.console.list(1).api.should_receive(:post).with("#{@mailup.console.list(1).api.path}/List/1/Email/Template/#{payload}")
    @mailup.console.list(1).add_message_from_template(payload)
  end

  it "should fire the correct POST request for add_message" do
    payload = Date._jisx0301("empty hash, please")
    @mailup.console.list(1).api.should_receive(:post).with("#{@mailup.console.list(1).api.path}/List/1/Email", {body: payload})
    @mailup.console.list(1).add_message(payload)
  end

  it "should fire the correct POST request for send_message" do
    payload = rand(100).abs
    @mailup.console.list(1).api.should_receive(:post).with("#{@mailup.console.list(1).api.path}/List/1/Email/#{payload}/Send")
    @mailup.console.list(1).send_message(payload)
  end

  # PUT requests

  it "should fire the correct PUT request for update_group" do
    id = rand(100).abs
    payload = Date._jisx0301("empty hash, please")
    @mailup.console.list(1).api.should_receive(:put).with("#{@mailup.console.list(1).api.path}/List/1/Group/#{id}", {body: payload})
    @mailup.console.list(1).update_group(id, payload)
  end

  it "should fire the correct PUT request for update_tag" do
    id = rand(100).abs
    payload = Date._jisx0301("empty hash, please")
    @mailup.console.list(1).api.should_receive(:put).with("#{@mailup.console.list(1).api.path}/List/1/Tag/#{id}", {body: payload})
    @mailup.console.list(1).update_tag(id, payload)
  end

  it "should fire the correct PUT request for update_message" do
    id = rand(100).abs
    payload = Date._jisx0301("empty hash, please")
    @mailup.console.list(1).api.should_receive(:put).with("#{@mailup.console.list(1).api.path}/List/1/Email/#{id}", {body: payload})
    @mailup.console.list(1).update_message(id, payload)
  end

  it "should fire the correct PUT request for update_message_visibility" do
    id = rand(100).abs
    @mailup.console.list(1).api.should_receive(:put).with("#{@mailup.console.list(1).api.path}/List/1/Email/#{id}/Online/Visibility", {body: true})
    @mailup.console.list(1).update_message_visibility(id, true)
  end

  # DELETE requests

  %w(delete_group unsubscribe delete_tag).each do |method|
    it "should fire the correct DELETE request for #{method}" do
      id = rand(100).abs
      @mailup.console.list(1).api.should_receive(:delete).with("#{@mailup.console.list(1).api.path}/List/1/#{method.split('_').last.capitalize}/#{id}")
      @mailup.console.list(1).send(method.to_sym, id)
    end
  end

  it "should fire the correct DELETE request for delete_attachment" do
    id = slot = rand(100).abs
    @mailup.console.list(1).api.should_receive(:delete).with("#{@mailup.console.list(1).api.path}/List/1/Email/#{id}/#{slot}")
    @mailup.console.list(1).delete_attachment(id, slot)
  end

  it "should fire the correct DELETE request for delete_message" do
    id = slot = rand(100).abs
    @mailup.console.list(1).api.should_receive(:delete).with("#{@mailup.console.list(1).api.path}/List/1/Email/#{id}")
    @mailup.console.list(1).delete_message(id)
  end

end