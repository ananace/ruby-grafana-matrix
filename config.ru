require 'grafana_matrix'

config = GrafanaMatrix::Config.new 'config.yml'
warn 'Specifying port/bind in config' if config.port? || config.bind?

Signal.trap('HUP') do
  warn "[#{Time.now}] SIGHUP received, reloading configuration"
  config.load!
end

map '/health' do
  run lambda { |_| [200, {'Content-Type' => 'text/plain'}, ['OK']] }
end

run GrafanaMatrix::Server.new(config)
