class GqlChatSchema < GraphQL::Schema
  query { Types::QueryType }
  mutation { Types::MutationType }

  use GraphQL::Dataloader

  def self.type_error(err, context)
    super
  end

  def self.resolve_type(abstract_type, obj, ctx)
    raise(GraphQL::RequiredImplementationMissingError)
  end

  max_query_string_tokens(5000)
  validate_max_errors(100)

  # Relay-style Object Identification:

  # Return a string UUID for `object`
  def self.id_from_object(object, type_definition, query_ctx)
    object.to_gid_param
  end

  # Given a string UUID, find the object
  def self.object_from_id(global_id, query_ctx)
    GlobalID.find(global_id)
  end
end
