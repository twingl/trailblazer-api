module Workers
  class ExtractContextData

    @queue = :extract_context_data

    def self.perform(node_id)
      node = Node.find(node_id)

      api = Embedly::API.new

      response = api.extract(:url => node.url).first

      context = Context.find_or_create_by :url => response.url

      context.update_attributes(
        :title          => response.title,
        :url            => response.url,
        :favicon_url    => response.favicon_url,
        :provider       => response.provider,
        :embedly_object => response.to_json
      )

      node.update_attributes(:title => response.title, :context => context)
    end
  end
end
