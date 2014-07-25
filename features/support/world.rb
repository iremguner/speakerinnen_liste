module SignInHelper
    # default locale of the site is 'de', so we set the same default here
    def sign_in(user,language='de')
        visit new_profile_session_path
        lang_map = { 'de' => 'DEU', 'en' => 'ENG' }
        if page.has_link?(lang_map[language])
          click_on lang_map[language]
        end
        fill_in "profile[email]", with: user.email
        fill_in "profile[password]", with: user.password
        click_button I18n.t("devise.sessions.new.login")
    end
end

module FormattingHelper
  def comma_separated_string_to_array(string, separator=',', empty_string_marker='#empty', preselect_marker=nil)
    strings_with_leading_spaces = string.split(separator)
    array = []
    preselect = nil
    strings_with_leading_spaces.each do |item|
      if item == empty_string_marker
        item = ''
      end
      array << item.strip
      if item.strip.start_with?('*')
        preselect = item.strip
      end
    end

    if preselect != nil
      return array, preselect
    end

    return array
  end
end

World(SignInHelper)
World(FormattingHelper)
World(FactoryGirl::Syntax::Methods)
