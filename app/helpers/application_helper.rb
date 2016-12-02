module ApplicationHelper
  def markdown(text)
    extensions = {
        fenced_code_blocks: true,
        autolink: true,
        no_intra_emphasis: true,
        gh_blockcode: true}
    Redcarpet::Markdown.new(renderer, extensions).render(text).html_safe
  end

  private
  def renderer
    render_options = {
        prettify: true,
        filter_html: true,
        hard_wrap: true
        }
    Redcarpet::Render::HTML.new(render_options)
  end
end
