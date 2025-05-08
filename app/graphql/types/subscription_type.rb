module Types
  class SubscriptionType < Types::BaseObject
    field :message_added, subscription: Subscriptions::MessageAdded, broadcastable: true
  end
end
