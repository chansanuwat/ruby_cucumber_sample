@projects @project_members @manage
Feature: As an app user, I would like to be able to manage project members
        so that I can keep project access up to date

@standard
Scenario: Standard user cannot edit project members access
  Given I am logged in as a "standard" user
  And I am on the "Manage" tab for project "QE Project"
  Then I should not see an element with:
    | type    | "link"             |
    | value   | "INVITE"           |
    | visible | true               |
    | within  | "div.ibox-content" |
  And I should not see an element with:
    | type    | "css"                  |
    | value   | "td.project-actions a" |
    | visible | true                   |
    | within  | "div.ibox-content"     |
  And I should not see an element with:
    | type    | "css"                              |
    | value   | "td.project-actions div.btn-group" |
    | visible | true                               |
    | within  | "div.ibox-content"                 |

@orgadminonly
Scenario: Org Admin only user cannot edit project members access
  Given I am logged in as a "orgadminonly" user
  And I am on the "Manage" tab for project "QE Project"
  Then I should not see an element with:
    | type    | "link"             |
    | value   | "INVITE"           |
    | visible | true               |
    | within  | "div.ibox-content" |
  And I should not see an element with:
    | type    | "css"                  |
    | value   | "td.project-actions a" |
    | visible | true                   |
    | within  | "div.ibox-content"     |
  And I should not see an element with:
    | type    | "css"                              |
    | value   | "td.project-actions div.btn-group" |
    | visible | true                               |
    | within  | "div.ibox-content"                 |