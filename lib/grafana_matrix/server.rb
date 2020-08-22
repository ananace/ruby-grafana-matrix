# frozen_string_literal: true

require 'sinatra/base'

module GrafanaMatrix
  class Server < ::Sinatra::Base
    attr_reader :config, :renderer, :image_handler

    def initialize(config)
      super

      @config = config
      @renderer = GrafanaMatrix::Renderer.new
      @image_handler = GrafanaMatrix::ImageHandler.new
    end

    helpers do
      def authorized(user, pass)
        @auth ||= Rack::Auth::Basic::Request.new(request.env)
        @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == [user, pass]
      end
    end

    get '/' do
      # Just to override the default page
    end

    post '/hook' do
      rule_name = params[:rule]
      halt 400, 'Missing rule name' unless rule_name

      rules = (config.rules(rule_name) rescue [])
              .select do |rule|
        next true unless rule.auth

        # Parse HTTP basic auth
        authorized(rule.auth['user'], rule.auth['pass'])
      end
      halt 404, 'No such rule configured' if rules.empty?

      data = JSON.parse(request.body.read)
      halt 400, 'No notification body provided' unless data

      logger.debug 'Data:'
      logger.debug data

      rules.each do |rule|
        client = rule.client
        halt 500, 'Unable to acquire Matrix client from rule' unless client

        room = rule.room if rule.room.start_with? '!'
        room ||= client.join_room(rule.room).room_id
        halt 500, 'Unable to acquire Matrix room from rule and client' unless room

        # Upload the image to the Matrix HS if requested to be embedded
        begin
          data['imageUrl'] = image_handler.upload(client, data['imageUrl']) if rule.embed_image? && rule.image? && data['imageUrl']
        rescue StandardError => e
          logger.fatal "Failed to upload image\n#{e.class} (#{e.message})\n#{e.backtrace.join "\n"}"
          # Disable embedding for this call
          rule.data[:embed_image] = false
        end

        plain = renderer.render_plain(data, rule, rule.plain_template)
        html = renderer.render_html(data, rule, rule.html_template)

        logger.debug 'Plain:'
        logger.debug plain

        logger.debug 'HTML:'
        logger.debug html

        # Support rules with nil client explicitly specified, for testing
        next unless client.is_a? MatrixSdk::Api

        client.send_message_event(room, 'm.room.message',
                                  msgtype: rule.msgtype,
                                  body: plain,
                                  formatted_body: html,
                                  format: 'org.matrix.custom.html')
      end

      ''
    end
  end
end
