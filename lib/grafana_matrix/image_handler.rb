require 'net/http'

module GrafanaMatrix
  class ImageHandler
    def upload(client, image)
      # TODO
      file = Net::HTTP.get(URI(image))
      uploaded = client.media_upload(file, 'image/png')
      get_download_url(uploaded[:content_uri])
    end
  end
end
