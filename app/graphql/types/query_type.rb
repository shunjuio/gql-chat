module Types
  class QueryType < Types::BaseObject
    field :messages, resolver: Resolvers::Messages
  end
end
