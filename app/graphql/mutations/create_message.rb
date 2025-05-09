module Mutations
  class CreateMessage < Mutations::Base
    field :message, Types::Message, null: false

    argument :content, String, required: true

    def resolve(**args)
      user = context[:current_user]
      raise GraphQL::ExecutionError, "You need to authenticate to perform this action" unless user

      message = Message.create!(sender_name: user.name, content: args[:content])

      GqlChatSchema.subscriptions.trigger(
        "messageAdded",
        {},
        { message: }
      )

      { message: }
    end
  end
end
