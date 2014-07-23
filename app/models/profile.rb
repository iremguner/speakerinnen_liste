require 'application_helper'

class Profile < ActiveRecord::Base
  include AutoHtml
  include FormattingHelper

  translates :bio, :main_topic, fallbacks_for_empty_translations: true
  accepts_nested_attributes_for :translations

  # probably obsolete (moved to medialinks model)
  #auto_html_for :media_url do
  #  html_escape
  #  image
  #  youtube width: 400, height: 250
  #  vimeo width: 400, height: 250
  #  simple_format
  #  link target: "_blank", rel: "nofollow"
  #end

  devise :database_authenticatable, :registerable, :omniauthable,
    :recoverable, :rememberable, :trackable, :validatable, :confirmable

  mount_uploader :picture, PictureUploader

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :bio, :city, :firstname, :languages, :lastname
  attr_accessible :picture, :twitter, :remove_picture, :website
  attr_accessible :topic_list, :medialinks, :main_topic, :translations_attributes
  attr_accessible :admin_comment
  #probably obsolete attributes:
  attr_accessible :name, :content, :media_url, :talks


  acts_as_taggable_on :topics

  has_many :medialinks

  before_validation do
    twitter_name_formatted
    website_with_protocol
  end

  def after_confirmation
    AdminMailer.new_profile_confirmed(self).deliver
  end

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |profile|
      profile.provider = auth.provider
      profile.uid = auth.uid
      profile.twitter = auth.info.nickname
    end
  end

  # method used by devise and omniauth
  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |profile|
        profile.attributes = params
        profile.valid?
      end
    else
      super
    end
  end

  scope :is_published, where(published: true)

  scope :no_admin, where(admin: false)

  def fullname
    "#{firstname.strip} #{lastname.strip}".strip
  end

  def main_topic_or_first_topic
    main_topic.present? ? main_topic : topic_list.first
  end

  def language(translation)
    if translation.object.locale == :en && I18n.locale == :de
      "Englisch"
    elsif translation.object.locale == :en && I18n.locale == :en
      "English"
    elsif translation.object.locale == :de && I18n.locale == :en
      "German"
    else
      "Deutsch"
    end
  end

  def twitter_link_formatted
    "http://twitter.com/"  + twitter
  end

  def self.random
    order("RANDOM()")
  end

  def password_required?
    super && provider.blank?
  end

  # method used by devise
  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  private

  def website_with_protocol
    self.website = url_with_protocol(self.website)
  end

  def twitter_name_formatted
    twitter.gsub!(/^@|https:|http:|:|\/\/|www.|twitter.com\//, '') if twitter
  end
end
