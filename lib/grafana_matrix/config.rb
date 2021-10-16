# frozen_string_literal: true

require 'matrix_sdk'
require 'psych'

module GrafanaMatrix
  class Config
    Rule = Struct.new(:config, :data) do
      def name
        data.fetch(:name)
      end

      def room
        data.fetch(:room)
      end

      def matrix
        data.fetch(:matrix)
      end

      def templates
        data.fetch(:templates, nil)
      end

      def auth
        data.fetch(:auth, nil)
      end

      def auth_user
        auth?.fetch(:user)
      end

      def auth_pass
        auth?.fetch(:pass)
      end

      def html_template
        templates&.fetch('html', nil) || Renderer::HTML_TEMPLATE
      end

      def plain_template
        templates&.fetch('plain', nil) || Renderer::PLAIN_TEMPLATE
      end

      def image?
        data.fetch(:image, true)
      end

      def embed_image?
        data.fetch(:embed_image, true)
      end

      def details?
        data.fetch(:details_tag, false)
      end

      def msgtype
        data.fetch(:msgtype, config.default_msgtype)
      end

      def client
        # TODO: Proper handling of this
        return Object.new if matrix.nil?

        @client ||= config.client(matrix)
      end
    end

    def self.global
      @global ||= self.new
    end

    def initialize(config = {})
      if config.is_a? String
        file = config
        config = {}
      end
      @config = config
      @clients = {}

      load!(file) if file
    end

    def load!(filename = 'config.yml')
      raise 'No such file' unless File.exist? filename

      @config = Psych.load(File.read(filename))
      true
    end

    def default_msgtype
      @config.fetch('msgtype', 'm.text')
    end

    def bind?
      @config.key? 'bind'
    end

    def bind
      @config.fetch('bind', '::')
    end

    def port?
      @config.key? 'port'
    end

    def port
      @config.fetch('port', 4567)
    end

    def client(client_name = nil)
      client_name ||= @config['matrix'].first['name']
      raise 'No client name provided' unless client_name

      client_data = @config['matrix'].find { |m| m['name'] == client_name }
      raise 'No client configuration found for name given' unless client_data

      @clients[client_name] ||= begin
        client_data = client_data.dup.transform_keys { |key| key.to_sym rescue key }

        MatrixSdk::Api.new(client_data[:url],
                           **client_data.reject { |k, _v| %i[url].include? k })
      end
    end

    def rules(rule_name)
      @config['rules']
        .select { |m| m['name'] == rule_name }
        .map do |rule_data|
        rule_data = rule_data.dup.transform_keys { |key| key.to_sym rescue key }

        Rule.new self, rule_data
      end
    end

    def rule(rule_name)
      rules(rule_name).first
    end
  end
end
