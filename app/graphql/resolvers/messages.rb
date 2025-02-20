module Resolvers
  class Messages < Resolvers::Base
    description "Find messages"
    type [ Types::Message ], null: false

    def resolve
      Message.all.order(id: :desc)
    end
  end
end
