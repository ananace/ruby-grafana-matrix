module GrafanaMatrix
  class Renderer
    HTML_TEMPLATE = File.expand_path('templates/html.erb', __dir__).freeze
    PLAIN_TEMPLATE = File.expand_path('templates/plain.erb', __dir__).freeze

    SEVERITY_COLOURS = {
      ok: '#10a345',
      paused: '#8e8e8e',
      alerting: '#ed2e18',
      pending: '#8e8e8e',
      no_data: '#f79520'
    }.freeze

    def render(data, rule, template)
      erb = ERB.new template, 0, '-'
      erb.result(binding)
    end

    def render_html(data, rule, template = HTML_TEMPLATE)
      render data, rule, File.read(template)
    end

    def render_plain(data, rule, template = PLAIN_TEMPLATE)
      render data, rule, File.read(template)
    end
  end
end
