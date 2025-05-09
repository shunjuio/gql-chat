class GraphqlChannel < ApplicationCable::Channel
  def subscribed
    @subscription_ids = []
  end

  def execute(data)
    query = data["query"]
    variables = ensure_hash(data["variables"])
    operation_name = data["operationName"]
    context = {
      channel: self # ActionCableSubscriptionsで必要
    }

    result = GqlChatSchema.execute(
      query,
      variables:,
      context:,
      operation_name:
    )

    @subscription_ids << result.context[:subscription_id] if result.context[:subscription_id]
  rescue StandardError => e
    Rails.logger.error "GraphQL execution error: #{e.message}\n#{e.backtrace.join("\n")}"
    transmit({ errors: [ { message: e.message } ] })
  end


  def unsubscribed
    @subscription_ids.each do |sid|
      GqlChatSchema.subscriptions.delete_subscription(sid)
    end
  end

  private

  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "パラメータ #{ambiguous_param.class} はハッシュに変換できません"
    end
  end
end
