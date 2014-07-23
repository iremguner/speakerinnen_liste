module ApplicationHelper
  def devise_mapping
    Devise.mappings[:profile]
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "desc" ? "asc" : "desc"
    link_to title, {sort: column, direction: direction}, {class: css_class}
  end

   def custom_tag_cloud(tags, classes)
      return [] if tags.empty?

      max_count = tags.sort_by { |t| t.taggings.count }.last.taggings.count.to_f

      tags.each do |tag|
        index = ((tag.taggings.count / max_count) * (classes.size - 1))
        yield tag, classes[index.nan? ? 0 : index.round]
      end
    end

end

module FormattingHelper
  VALID_PREFIX = /^(www\.|http(s|):\/\/)/

  def url_with_protocol(url)
    if url && !VALID_PREFIX.match(url) && !/(:|\/)/.match(url)
      parts = url.split('.')
      if parts.length == 3 && !/^ww/.match(url)
        url = 'https://'+url
      end
      if parts.length == 2
        url = 'https://www.'+url
      end
    end
    return url
  end
end
