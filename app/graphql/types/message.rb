module Types
  class Message < Types::BaseObject
    implements Interfaces::Node

    global_id_field :id

    field :sender_name, String, null: false
    field :content, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
