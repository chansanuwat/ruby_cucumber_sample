@organization @non_admin
Feature: Non admin users should not have access to Organization settings

@standard
Scenario: No access to organization settings for standard user
  Given I am logged in as a "standard" user
  Then I should not see an element with:
    | type    | "link"         |
    | value   | "Organization" |
    | visible | true           |
    | within  | "ul#side-menu" |

@projadminonly
Scenario: No access to organization settings for project admin only user
  Given I am logged in as a "projadminonly" user
  Then I should not see an element with:
    | type    | "link"         |
    | value   | "Organization" |
    | visible | true           |
    | within  | "ul#side-menu" |