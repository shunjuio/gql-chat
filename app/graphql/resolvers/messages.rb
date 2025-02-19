module Resolvers
  class Messages < GraphQL::Schema::Resolver
    description "Find messages"
    type [ Types::MessageType ], null: false

    def resolve
      Message.all.order(id: :desc)
    end
  end
end
