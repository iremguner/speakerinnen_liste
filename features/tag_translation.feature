Feature: Tag Translation

Scenario Outline: tag translation view on start and contact page (multilingual translation only into current locale lang)
Given there is an <to_lang> tag translation missing for tag <tag> in <from_lang>
And you view the <page> page
When you view the page in <language>
Then you should see a form with labels: <from_lang>, <to_lang>,<tag>
And you are able to see: <to_lang>
And you are able to see: <from_lang>
And you see a button labeled as: <ok>
And you see a button labeled as: <give_me_another>

Examples:
| page    | language | tag         | from_lang   | to_lang     | ok | give_me_another        |
| start   | German   | children    | Englisch    | Deutsch     | Ok | Anderes Tag übersetzen |
| contact | German   | des enfants | Französisch | Deutsch     | Ok | Anderes Tag übersetzen |
| contact | English  | Gitarre     | German      | English     | Ok | Translate another tag  |
| start   | English  | guitare     | French      | English     | Ok | Translate another tag  |
| contact | French   | Schokolade  | Allemande   | Francais    | Ok | une autre étiquette    |
| start   | French   | chocolate   | Anglais     | Francais    | Ok | une autre étiquette    |
