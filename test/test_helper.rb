# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  add_filter '/test/'
  add_filter '/vendor/'
end

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'grafana_matrix'

require 'minitest/autorun'
require 'mocha'

def load_fixture(filename)
  File.open(File.join('test', 'fixtures', filename))
end
