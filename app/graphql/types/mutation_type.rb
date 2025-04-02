module Types
  class MutationType < Types::BaseObject
    field :create_message, mutation: Mutations::CreateMessage, description: "チャットを投稿する"
    field :update_message, mutation: Mutations::UpdateMessage, description: "チャットを更新する"
  end
end
