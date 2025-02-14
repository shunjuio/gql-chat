# frozen_string_literal: true

module Mutations
  class CreateMessage < BaseMutation
    field :message, Types::MessageType, null: false

    argument :sender_name, String, required: true
    argument :content, String, required: true

    def resolve(**args)
      message = Message.create!(args)
      { message: message }
    end
  end
end
