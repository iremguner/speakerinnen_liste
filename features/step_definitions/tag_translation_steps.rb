###############
# conventions #
###############
# All steps are ordered by their categories:
# 1) Given
# 2) When
# 3) Then
#
# Each step file groups certain steps together.
# This step file contains all steps to:
# navigate through the page and to validate navigation elements.

############
# 1) Given #
############

Then /^you can translate the tag (.*) from ((.+)(,.+)*) to (.*) $/ do |tag, from_langs, unused, unused2, to_lang|
  options, preselect = comma_separated_string_to_array(from_langs, ',', '#e', '!')

  steps %Q{
    Then you should see a form with labels: #{to_lang},#{tag}
    And  you should see a select box in a form: #{preselect} with options: #{options}
  }
end

###########
# 2) When #
###########

###########
# 3) Then #
###########
