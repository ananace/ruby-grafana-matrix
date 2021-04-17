require 'test_helper'

class RendererTest < Minitest::Test
  ALERTDATA = {
    'title' => '[Alerting] IO wait alert',
    'message' => 'IO wait percentage averaged above 10% the last five minutes',
    'state' => 'alerting',
    'evalMatches' => [
      { 'metric' => 'node.example.com', 'value' => 14.45 },
      { 'metric' => 'node2.example.com', 'value' => 11.22 },
    ],
    'imageUrl' => 'https://grafana.example.com/image.png',
    'ruleUrl' => 'https://grafana.example.com/panel-url'
  }.freeze
  ALERTRULE = GrafanaMatrix::Config::Rule.new(nil, {}).freeze
  ALERTRULE_DETAILS = GrafanaMatrix::Config::Rule.new(nil, { details_tag: true }).freeze

  def setup
    @renderer = GrafanaMatrix::Renderer.new
  end

  def test_that_it_renders_plain
    assert_equal load_fixture('message.plain').read, @renderer.render_plain(ALERTDATA, ALERTRULE)
  end

  def test_that_it_renders_html
    assert_equal load_fixture('message.html').read, @renderer.render_html(ALERTDATA, ALERTRULE)
  end

  def test_that_it_renders_html_with_details
    assert_equal load_fixture('message-details.html').read, @renderer.render_html(ALERTDATA, ALERTRULE_DETAILS)
  end
end
