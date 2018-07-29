require 'net/http'

module GrafanaMatrix
  class ImageHandler
    def upload(client, image)
      # TODO
      file = Net::HTTP.get(URI(image))
      uploaded = client.media_upload(file, 'image/png')
      uploaded[:content_uri]
    end
  end
end
