module Types
  class Message < Types::BaseObject
    implements Interfaces::Node

    field :id, ID, null: false
    field :sender_name, String, null: false
    field :content, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
