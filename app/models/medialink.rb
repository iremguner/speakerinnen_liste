require 'application_helper'

class Medialink < ActiveRecord::Base
  include AutoHtml
  include FormattingHelper

  attr_accessible :url, :title, :description
  belongs_to :profile

  before_validation { prefix_url }
  validates :title,:url, presence: true
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
    self.url = url_with_protocol(self.url)
  end

end
