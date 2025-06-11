module Types
  class Message < Types::BaseObject
    implements Interfaces::Node

    global_id_field :id, broadcastable: true
    field :sender_name, String, null: false, broadcastable: true
    field :content, String, null: false, broadcastable: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false, broadcastable: true
  end
end
