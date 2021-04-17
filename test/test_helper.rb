# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'grafana_matrix'

require 'minitest/autorun'

def load_fixture(filename)
  File.open(File.join('test', 'fixtures', filename))
end
