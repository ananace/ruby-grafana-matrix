require File.join File.expand_path('lib', __dir__), 'grafana_matrix/version'

Gem::Specification.new do |spec|
  spec.name          = 'grafana_matrix'
  spec.version       = GrafanaMatrix::VERSION
  spec.authors       = ['Alexander Olofsson']
  spec.email         = ['alexander.olofsson@liu.se']

  spec.summary       = 'A Matrix notification target for Grafana'
  spec.description   = 'Converts Grafana alerts into Matrix notifications ' \
                       'using Grafana alert webhooks'
  spec.homepage      = 'https://github.com/ananace/ruby-grafana-matrix'
  spec.license       = 'MIT'

  spec.extra_rdoc_files = %w[LICENSE.txt README.md]
  spec.files         = Dir['lib/**/*'] + spec.extra_rdoc_files
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.6', '< 4'

  spec.add_dependency 'matrix_sdk', '~> 2.0'
  spec.add_dependency 'sinatra'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
end
