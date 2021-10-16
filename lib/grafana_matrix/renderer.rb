# frozen_string_literal: true

module GrafanaMatrix
  class Renderer
    HTML_TEMPLATE = '%TEMPLATES%/html.erb'.freeze
    PLAIN_TEMPLATE = '%TEMPLATES%/plain.erb'.freeze

    SEVERITY_COLOURS = {
      ok: '#10a345',
      paused: '#8e8e8e',
      alerting: '#ed2e18',
      pending: '#8e8e8e',
      no_data: '#f79520'
    }.freeze

    def render(data, rule, template)
      erb = ERB.new template, trim_mode: '-'
      erb.result(binding)
    end

    def render_html(data, rule, template = HTML_TEMPLATE)
      render data, rule, File.read(expand_path(template))
    end

    def render_plain(data, rule, template = PLAIN_TEMPLATE)
      render data, rule, File.read(expand_path(template))
    end

    private

    def expand_path(path)
      path.gsub('%TEMPLATES%', File.expand_path('templates', __dir__))
          .gsub(/\$([a-zA-Z_][a-zA-Z0-9_]*)|\${\g<1>}/) do
        match = Regexp.last_match
        ENV[match[1]]
      end
    end
  end
end
