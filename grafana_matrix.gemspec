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

  spec.files         = Dir['**/*.rb'].reject do |f|
    f.match(%r{^(test|spec|features|vendor)/})
  end
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'matrix_sdk', '~> 2.0'
  spec.add_dependency 'sinatra'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'sinatra-contrib'
end
