module Interfaces
  module Base
    include GraphQL::Schema::Interface
    edge_type_class(Edges::Base)
    connection_type_class(Connections::Base)

    field_class Fields::Base
  end
end
