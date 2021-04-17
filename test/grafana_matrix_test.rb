require 'test_helper'

class GrafanaMatrixTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::GrafanaMatrix::VERSION
  end
end
