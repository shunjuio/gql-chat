require 'rails_helper'

RSpec.describe Message, type: :model do
  describe "validations" do
    it "is valid with sender_name and content" do
      message = Message.new(sender_name: "John", content: "Hello world")
      expect(message).to be_valid
    end

    it "is invalid without sender_name" do
      message = Message.new(sender_name: nil, content: "Hello world")
      expect(message).to_not be_valid
      expect(message.errors[:sender_name]).to include("can't be blank")
    end

    it "is invalid without content" do
      message = Message.new(sender_name: "John", content: nil)
      expect(message).to_not be_valid
      expect(message.errors[:content]).to include("can't be blank")
    end

    it "is invalid with empty sender_name" do
      message = Message.new(sender_name: "", content: "Hello world")
      expect(message).to_not be_valid
      expect(message.errors[:sender_name]).to include("can't be blank")
    end

    it "is invalid with empty content" do
      message = Message.new(sender_name: "John", content: "")
      expect(message).to_not be_valid
      expect(message.errors[:content]).to include("can't be blank")
    end
  end
end