# frozen_string_literal: true

module Mutations
  class CreateMessage < BaseMutation
    field :message, Types::MessageType, null: false

    argument :content, String, required: true

    def resolve(**args)
      user = context[:current_user]
      raise GraphQL::ExecutionError, "You need to authenticate to perform this action" unless user

      message = Message.create!(sender_name: user.name, content: args[:content])
      { message: message }
    end
  end
end
