class Medialink < ActiveRecord::Base
  include AutoHtml

  attr_accessible :url, :title, :description
  belongs_to :profile

  before_validation { prefix_url }
  validates :title,:url, presence: true
  VALID_PREFIX = /^(www\.|http(s|):\/\/)/
  validates :url, format: { with: VALID_PREFIX }

  auto_html_for :url do
    html_escape
    image
    youtube width: 400, height: 250
    vimeo width: 400, height: 250
    simple_format
    link target: "_blank", rel: "nofollow"
  end

  def prefix_url
    if self.url && !VALID_PREFIX.match(self.url) && !/(:|\/)/.match(self.url)
      parts = url.split('.')
      if parts.length == 3 && !/^ww/.match(url)
        self.url = 'https://'+url
      end
      if parts.length == 2
        self.url = 'https://www.'+url
      end
    end
  end

end
