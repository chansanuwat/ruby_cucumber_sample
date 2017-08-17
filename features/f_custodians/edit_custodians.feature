@custodians @edit_custodian
Feature: As an app admin, I would like to be able to edit custodians
        so can adequately manage the custodians for a project

@success @projadminonly
Scenario: Edit custodian - Project Admin Only - Success
  Given I am logged in as an "projadminonly" user
  And I am on the "Custodians" tab for project "QE Project"
  And I have a unique "string" as "identifier" with:
    | size | 7 |
  When I edit a "Custodian" with:
    | match      | {'Name'=>/^QEM\w*\sQEM\w*$/}              |
    | First Name | "QEM#{$current['identifier']}"            |
    | Last Name  | "QEM#{$current['identifier']}"            |
    | Email      | "#{$current['identifier']}@projnowqe.com" |
  Then the "Custodian Detail" should match:
    | Name       | $current['Custodian'].full_name |
    | Email      | $current['Custodian'].email     |
  And parsing the "Activity Table" should have a result with:
    | Title   | "Custodian was updated"                                                                 |
    | Message | /^\w+ \w+ updated custodian #{$current['Custodian'].full_name} for project QE Project$/ |

@negative @projadminonly
Scenario: Edit custodian - Missing Required Fields
  Given I am logged in as an "projadminonly" user
  And I am on the "Custodians" tab for project "QE Project"
  And I have a unique "string" as "identifier" with:
    | size | 7 |
  When I edit a "Custodian" with:
    | match      | {'Name'=>/^QEM\w*\sQEM\w*$/} |
    | First Name | ""                           |
    | Last Name  | ""                           |
    | no_save    | true                         |
  Then I should see the following error messages:
    | "The First Name field is required." |
    | "The Last Name field is required."  |
  And the "Save changes" button should be disabled

@standard
Scenario: Edit custodian - Standard
  Given I am logged in as a "standard" user
  And I am on the "Custodians" tab for project "QE Project"
  When I go to the details screen for a "Custodian" with:
    | match      | {'Name'=>/^QEF\w*\sQEL\w*$/} |
  Then I should not see an element with:
    | type    | "link"             |
    | value   | "Edit"             |
    | visible | true               |
    | within  | "div.ibox-content" |

@orgadminonly
Scenario: Edit custodian - Org Admin Only
  Given I am logged in as a "orgadminonly" user
  And I am on the "Custodians" tab for project "QE Project"
  When I go to the details screen for a "Custodian" with:
    | match      | {'Name'=>/^QEF\w*\sQEL\w*$/} |
  Then I should not see an element with:
    | type    | "link"             |
    | value   | "Edit"             |
    | visible | true               |
    | within  | "div.ibox-content" |