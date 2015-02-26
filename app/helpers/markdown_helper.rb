module MarkdownHelper
  def render_markdown(source)
    context = {
        asset_root: 'https://a248.e.akamai.net/assets.github.com/images/icons/',
        base_url: ''
    }

    pipeline = HTML::Pipeline.new [
                                     HTML::Pipeline::MarkdownFilter,
                                     HTML::Pipeline::SanitizationFilter,
                                     HTML::Pipeline::ImageMaxWidthFilter,
                                     HTML::Pipeline::HttpsFilter,
                                     #HTML::Pipeline::MentionFilter,
                                     HTML::Pipeline::EmojiFilter,
                                     HTML::Pipeline::SyntaxHighlightFilter
                                 ], context.merge(gfm: true)
    result = pipeline.call(source)
    result[:output].to_s.html_safe
  end
end
