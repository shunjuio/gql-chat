module Subscriptions
  class MessageAdded < Base
    description "新しいメッセージが追加された時に発火するサブスクリプション"

    field :message, Types::Message, null: false, description: "新しく追加されたメッセージ"

    def subscribe
      {}
    end

    def update(payload = nil)
      message_record = Message.last || Message.new(
        id: "dummy",
        sender_name: "System",
        content: "No message available.",
        created_at: Time.current,
        updated_at: Time.current
      )

      { message: message_record }
    end
  end
end
