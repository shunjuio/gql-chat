class GqlChatSchema < GraphQL::Schema
  query { Types::QueryType }
  mutation { Types::MutationType }
  subscription { Types::SubscriptionType }

  use GraphQL::Dataloader
  use GraphQL::Subscriptions::ActionCableSubscriptions,
      broadcast: true,
      default_broadcastable: true

  rescue_from(ActiveRecord::RecordNotFound) do |err, obj, args, ctx, field|
    raise GraphQL::ExecutionError, "#{field.type.unwrap.graphql_name} not found", code: "RESOURCE_NOTFOUND"
  end

  rescue_from(StandardError) do |err, obj, args, ctx, field|
    raise err if Rails.env.development? || Rails.env.test?

    Rails.logger.error(err)
    Rails.logger.error(err.backtrace.join("\n"))
    GraphQL::ExecutionError.new("エラーが発生しました。", extensions: { code: "INTERNAL_SERVER_ERROR" })
  end

  def self.type_error(err, context)
    super
  end

  def self.resolve_type(abstract_type, obj, ctx)
    abstract_type
  end

  max_query_string_tokens(5000)
  validate_max_errors(100)

  # Relay-style Object Identification:

  # Return a string UUID for `object`
  def self.id_from_object(object, type_definition, query_ctx)
    object_id = object.to_global_id.to_s
    # Remove this redundant prefix to make IDs shorter:
    object_id = object_id.sub("gid://#{GlobalID.app}/", "")
    encoded_id = Base64.urlsafe_encode64(object_id)
    # Remove the "=" padding
    encoded_id.sub(/=+/, "")
  end

  # Given a string UUID, find the object
  def self.object_from_id(encoded_id, query_ctx)
    id = Base64.urlsafe_decode64(encoded_id)
    # Rebuild it for Rails then find the object:
    full_global_id = "gid://#{GlobalID.app}/#{id}"
    GlobalID::Locator.locate(full_global_id)
  end
end
