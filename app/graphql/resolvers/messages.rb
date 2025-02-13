module Resolvers
  class Messages < GraphQL::Schema::Resolver
    description "Find messages"
    type [ Types::MessageType ], null: false

    def resolve
      Message.all
    end
  end
end
