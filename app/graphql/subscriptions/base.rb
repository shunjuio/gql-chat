module Subscriptions
  class Base < GraphQL::Schema::Subscription
    object_class Types::BaseObject
    field_class Fields::Base
    argument_class Arguments::Base
  end
end
