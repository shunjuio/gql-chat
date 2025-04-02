module Mutations
  class UpdateMessage < Mutations::Base
    argument :message_id, ID, required: true, loads: Types::Message
    argument :content, String, required: true

    field :message, Types::Message, null: false

    def resolve(message:, **args)
      message.update!(content: args[:content])
      { message: message }
    end
  end
end
