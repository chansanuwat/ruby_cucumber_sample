@projects @project_details @manage
Feature: As an app user, I would like to be able to manage project details
        so that I can keep their configurations up to date

@standard
Scenario: Standard user cannot edit project details
  Given I am logged in as a "standard" user
  And I am on the "Manage" tab for project "QE Project"
  Then I should not see an element with:
    | type    | "link"             |
    | value   | "Edit"             |
    | visible | true               |
    | within  | "div.ibox-content" |
  And I should not see an element with:
    | type    | "button"           |
    | value   | "Archive"          |
    | visible | true               |
    | within  | "div.ibox-content" |

@orgadminonly
Scenario: Org Admin only user cannot edit project details
  Given I am logged in as a "orgadminonly" user
  And I am on the "Manage" tab for project "QE Project"
  Then I should not see an element with:
    | type    | "link"             |
    | value   | "Edit"             |
    | visible | true               |
    | within  | "div.ibox-content" |
  And I should not see an element with:
    | type    | "button"           |
    | value   | "Archive"          |
    | visible | true               |
    | within  | "div.ibox-content" |