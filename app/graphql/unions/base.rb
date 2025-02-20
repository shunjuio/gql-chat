module Unions
  class Base < GraphQL::Schema::Union
    edge_type_class(Edges::Base)
    connection_type_class(Connections::Base)
  end
end
