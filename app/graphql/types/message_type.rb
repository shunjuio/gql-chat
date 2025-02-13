# frozen_string_literal: true

module Types
  class MessageType < Types::BaseObject
    field :id, ID, null: false
    field :sender_name, String, null: false
    field :content, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
