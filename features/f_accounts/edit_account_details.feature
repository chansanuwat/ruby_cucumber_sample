@account @account_edit @edit @account_details
Feature: As a User, I'd like to be able to edit my account details
        so that my data is always up to date

@happy_path @orgadminonly
Scenario: Edit Account Details - Org Admin Only
  Given I am logged in as an "orgadminonly" user
  And I am on the account details for the user
  And I have a unique "string" as "identifier" with:
    | size | 7 |
  When I edit the "Account" with:
    | First Name | "QEF#{$current['identifier']}" |
    | Last Name  | "QEL#{$current['identifier']}" |
    | Title      | "QET#{$current['identifier']}" |
  Then the "Account Detail" should match:
    | first_name | $current['Account'].first_name |
    | last_name  | $current['Account'].last_name  |
    | full_name  | $current['Account'].full_name  |
    | company    | 'projnowqe.com'                |
    | title      | $current['Account'].title      |

@happy_path @standard
Scenario: Edit Account Details - Standard
  Given I am logged in as an "standard" user
  And I am on the account details for the user
  And I have a unique "string" as "identifier" with:
    | size | 7 |
  When I edit the "Account" with:
    | First Name | "QEF#{$current['identifier']}" |
    | Last Name  | "QEL#{$current['identifier']}" |
    | Title      | "QET#{$current['identifier']}" |
  Then the "Account Detail" should match:
    | first_name | $current['Account'].first_name |
    | last_name  | $current['Account'].last_name  |
    | full_name  | $current['Account'].full_name  |
    | company    | 'projnowqe.com'                |
    | title      | $current['Account'].title      |

@happy_path @projadminonly
Scenario: Edit Account Details - Project Admin Only
  Given I am logged in as an "projadminonly" user
  And I am on the account details for the user
  And I have a unique "string" as "identifier" with:
    | size | 7 |
  When I edit the "Account" with:
    | First Name | "QEF#{$current['identifier']}" |
    | Last Name  | "QEL#{$current['identifier']}" |
    | Title      | "QET#{$current['identifier']}" |
  Then the "Account Detail" should match:
    | first_name | $current['Account'].first_name |
    | last_name  | $current['Account'].last_name  |
    | full_name  | $current['Account'].full_name  |
    | company    | 'projnowqe.com'                |
    | title      | $current['Account'].title      |

@negative
Scenario: Edit Account Details - Missing Required Fields
  Given I am logged in as an "orgadminonly" user
  And I am on the account details for the user
  And I have a unique "string" as "identifier" with:
    | size | 7 |
  When I edit the "Account" with:
    | First Name | ""   |
    | Last Name  | ""   |
    | Title      | ""   |
    | no_save    | true |
  Then I should see the following error messages:
    | "The First Name field is required." |
    | "The Last Name field is required."  |
    | "The Title is required."            |
  And the "Save changes" button should be disabled