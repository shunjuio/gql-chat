module Fields
  class Base < GraphQL::Schema::Field
    argument_class Arguments::Base
  end
end
