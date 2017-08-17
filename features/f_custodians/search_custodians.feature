@custodians @search_custodians
Feature: As an app user, I would like to be able to search for custodians
        so that I can quickly find custodians for a project

@single @projadminonly
Scenario: Search custodian - Project Admin Only - Partial Match Single
  Given I am logged in as an "projadminonly" user
  And I am on the "Custodians" tab for project "QE Project"
  And I have a "Custodian" table object
  When I search the "Custodian Table" for "QEDNM1"
  And I parse the "Custodian Table"
  Then the "Custodian Table" should have "1" result
  And the "Custodian Table" should have a result with:
    | Name       | 'QEDNM1 QEDoNotModify1'        |
    | Email      | 'QEDoNotModify1@projnowqe.com' |

@single @nonadmin
Scenario: Search custodian - Standard - Partial Match Single
  Given I am logged in as a "standard" user
  And I am on the "Custodians" tab for project "QE Project"
  And I have a "Custodian" table object
  When I search the "Custodian Table" for "QEDNM1"
  And I parse the "Custodian Table"
  Then the "Custodian Table" should have "1" result
  And the "Custodian Table" should have a result with:
    | Name       | 'QEDNM1 QEDoNotModify1'        |
    | Email      | 'QEDoNotModify1@projnowqe.com' |