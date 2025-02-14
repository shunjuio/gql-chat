# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_message, mutation: Mutations::CreateMessage, description: "チャットを投稿する"
  end
end
