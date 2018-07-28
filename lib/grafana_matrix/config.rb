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

      def image?
        data.fetch(:image, true)
      end

      def embed_image?
        data.fetch(:embed_image, true)
      end

      def client
        # TODO: Proper handling of this
        return Object.new if matrix.nil?
        @client ||= config.client(matrix)
      end
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
        client_data = client_data.dup

        # Symbolize keys
        client_data.keys.each do |key|
          client_data[(key.to_sym rescue key)] = client_data.delete key
        end

        MatrixSdk::Api.new(client_data[:url],
                           client_data.reject { |k, _v| %i[url].include? k })
      end
    end

    def rule(rule_name)
      rule_data = @config['rules'].find { |m| m['name'] == rule_name }
      raise 'No rule configuration found for name given' if rule_data.nil?

      rule_data = rule_data.dup

      # Symbolize keys
      rule_data.keys.each do |key|
        rule_data[(key.to_sym rescue key)] = rule_data.delete key
      end

      Rule.new self, rule_data
    end
  end
end
