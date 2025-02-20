module Mutations
  class Base < GraphQL::Schema::RelayClassicMutation
    argument_class Arguments::Base
    field_class Fields::Base
    input_object_class Inputs::Base
    object_class Types::BaseObject
  end
end
