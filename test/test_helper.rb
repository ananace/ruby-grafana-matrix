$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'grafana_matrix'

require 'minitest/autorun'

def load_fixture(filename)
  File.open(File.join('test', 'fixtures', filename))
end
