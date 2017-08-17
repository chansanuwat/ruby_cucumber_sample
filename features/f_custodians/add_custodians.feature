@custodians @add_custodian
Feature: As an app admin, I would like to be able to add new custodians
        so can adequately manage the custodians for a project

@success @projadminonly @generate
Scenario: Add new custodian - Project Admin - Success
  Given I am logged in as an "projadminonly" user
  And I am on the "Custodians" tab for project "QE Project"
  And I have a unique "string" as "identifier" with:
    | size | 7 |
  When I add a new "Custodian" with:
    | First Name | "QEF#{$current['identifier']}"            |
    | Last Name  | "QEL#{$current['identifier']}"            |
    | Email      | "#{$current['identifier']}@projnowqe.com" |
  Then parsing the "Custodian Table" should have a result with:
    | Name       | $current['Custodian'].full_name |
    | Email      | $current['Custodian'].email     |
    | Created by | Users['projadminonly']['email'] |
  And parsing the "Activity Table" should have a result with:
    | Title   | "Custodian was created"                                                                 |
    | Message | /^\w+ \w+ created custodian #{$current['Custodian'].full_name} for project QE Project$/ |

@success @no_email @projadminonly @generate
Scenario: Add new custodian without email - Project Admin - Success
  Given I am logged in as an "projadminonly" user
  And I am on the "Custodians" tab for project "QE Project"
  And I have a unique "string" as "identifier" with:
    | size | 7 |
  When I add a new "Custodian" with:
    | First Name | "QEF#{$current['identifier']}"            |
    | Last Name  | "QEL#{$current['identifier']}"            |
  Then parsing the "Custodian Table" should have a result with:
    | Name       | $current['Custodian'].full_name |
    | Email      | ''                              |
    | Created by | Users['projadminonly']['email'] |
  And parsing the "Activity Table" should have a result with:
    | Title   | "Custodian was created"                                                                 |
    | Message | /^\w+ \w+ created custodian #{$current['Custodian'].full_name} for project QE Project$/ |
    
@standard
Scenario: Add new custodian - Standard
  Given I am logged in as a "standard" user
  When I am on the "Custodians" tab for project "QE Project"
  Then I should not see an element with:
    | type    | "link"             |
    | value   | "New Custodian"    |
    | visible | true               |
    | within  | "div.ibox-content" |
    
@orgadminonly
Scenario: Add new custodian - Org Admin Only
  Given I am logged in as a "orgadminonly" user
  When I am on the "Custodians" tab for project "QE Project"
  Then I should not see an element with:
    | type    | "link"             |
    | value   | "New Custodian"    |
    | visible | true               |
    | within  | "div.ibox-content" |

@negative @projadminonly
Scenario: Add new custodian - No first name
  Given I am logged in as an "projadminonly" user
  And I am on the "Custodians" tab for project "QE Project"
  And I have a unique "string" as "identifier" with:
    | size | 7 |
  When I add a new "Custodian" with:
    | Last Name  | "QEL#{$current['identifier']}"            |
    | Email      | "#{$current['identifier']}@projnowqe.com" |
    | no_save    | true                                      |
  Then the "Save changes" button should be disabled

@negative @projadminonly
Scenario: Add new custodian - No last name
  Given I am logged in as an "projadminonly" user
  And I am on the "Custodians" tab for project "QE Project"
  And I have a unique "string" as "identifier" with:
    | size | 7 |
  When I add a new "Custodian" with:
    | First Name  | "QEF#{$current['identifier']}"            |
    | Email       | "#{$current['identifier']}@projnowqe.com" |
    | no_save     | true                                      |
  Then the "Save changes" button should be disabled