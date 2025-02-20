module Inputs
  class Base < GraphQL::Schema::InputObject
    argument_class Arguments::Base
  end
end
