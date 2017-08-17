@chat @project_chat
Feature: Validate project chat

@multiple_sessions
Scenario: Standard Chat message
  Given I am logged in as an "projadminonly" user
  And I get the current "user name" as "first user name"
  And I am on the "Chat" tab for project "QE Project"
  And I have a unique "string" as "identifier" with:
    | size | 7 |
  When I switch to the "receiver" session
  And I am logged in as a "standard" user
  And I am on the "Chat" tab for project "QE Project"
  And I switch to the "default" session
  And I add a chat message with:
  """
  "This is a chat #{$current['identifier']}"
  """
  And I switch to the "receiver" session
  Then parsing the "Chat Table" should have a result with:
    | From    | "#{$current['first user name']}"           |
    | Message | "This is a chat #{$current['identifier']}" |