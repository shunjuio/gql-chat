# frozen_string_literal: true

module PersistedQueryStore
  def self.queries
    @queries ||= begin
      manifest_path = Rails.root.join("app/javascript/persisted-query-manifest.json")
      return {}.freeze unless manifest_path.exist?

      manifest = JSON.parse(File.read(manifest_path))
      manifest["operations"].each_with_object({}) do |op, hash|
        hash[op["id"]] = op["body"]
      end.freeze
    rescue JSON::ParserError
      {}.freeze
    end
  end
end
