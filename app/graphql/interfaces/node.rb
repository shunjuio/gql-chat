module Interfaces
  module Node
    include Interfaces::Base
    include GraphQL::Types::Relay::NodeBehaviors
  end
end
