Feature: Tag Translation

Scenario Outline: tag translation view on start and contact page (multilingual translation only into current locale lang)
Given there is a <to_lang> tag translation missing for tag <tag> in <from_langs>
And you view the <page> page
When you view the page in <language>
Then you can translate the tag <tag> from <from_langs> to <to_lang>
And you see a button labeled as: <ok>
And you see a button labeled as: <give_me_another>

# from_lang marked with ! is the preselected one in the select box
# TODO write scenario to ensure the tag label changes when you select another language in the select box
Examples:
| page    | language | tag         | from_langs             | to_lang     | ok | give_me_another        |
| start   | German   | children    | !Englisch, Französisch | Deutsch     | Ok | Anderes Tag übersetzen |
| contact | German   | des enfants | Englisch, !Französisch | Deutsch     | Ok | Anderes Tag übersetzen |
| contact | English  | Gitarre     | French, !German        | English     | Ok | Translate another tag  |
| start   | English  | guitare     | !French, German        | English     | Ok | Translate another tag  |
| contact | French   | Schokolade  | !Allemand, Anglais     | Francais    | Ok | Une autre étiquette    |
| start   | French   | chocolate   | Allemand, !Anglais     | Francais    | Ok | Une autre étiquette    |

Scenario Outline: tag translation view on edit profile page
Given there is a <to_lang> tag translation missing for tag <tag> in <from_langs>
And you are signed in as user
And you view the page in <language>
When you click on: <profile_view>
And you click on: <edit_profile>
Then you can translate the tag <tag> from <from_langs> to <to_lang>
And you see a button labeled as: <ok>
And you see a button labeled as: <give_me_another>

# from_lang marked with ! is the preselected one in the select box
# TODO write scenario to ensure the tag label changes when you select another language in the select box
Examples:
| page    | language | tag         | from_langs             | to_lang     | ok | give_me_another        | profile_view | edit_profile      |
| start   | German   | children    | !Englisch, Französisch | Deutsch     | Ok | Anderes Tag übersetzen | Mein Profil  | Profil bearbeiten |
| contact | German   | des enfants | Englisch, !Französisch | Deutsch     | Ok | Anderes Tag übersetzen | Mein Profil  | Profil bearbeiten |
| contact | English  | Gitarre     | French, !German        | English     | Ok | Translate another tag  | My profile   | Edit profile      |
| start   | English  | guitare     | !French, German        | English     | Ok | Translate another tag  | My profile   | Edit profile      |
| contact | French   | Schokolade  | !Allemand, Anglais     | Francais    | Ok | Une autre étiquette    | Mon profil   | Édite profile     |
| start   | French   | chocolate   | Allemand, !Anglais     | Francais    | Ok | Une autre étiquette    | Mon profil   | Édite profile     |
