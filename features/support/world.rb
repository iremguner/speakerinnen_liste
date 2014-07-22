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

module FormHelper
  def fill_in_autocomplete(selector, value)
    page.execute_script %Q{$('#{selector}').val('#{value}').keydown()}
  end

  #def choose_autocomplete(text)
  #  find('ul.ui-autocomplete').should have_content(text)
  #  page.execute_script("$('.ui-menu-item:contains(\"#{text}\")').find('a').trigger('mouseenter').click()")
  #end
end

World(FormHelper)
World(SignInHelper)
World(FactoryGirl::Syntax::Methods)
