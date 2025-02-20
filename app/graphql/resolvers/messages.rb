module Resolvers
  class Messages < Resolvers::Base
    description "Fetch messages"

    type Connections::MessageConnection, null: false

    def resolve
      Message.all.order(id: :desc)
    end
  end
end
