@custodians @delete_custodian
Feature: As an app admin, I would like to be able to delete custodians
        so I can adequately manage the custodians for a project

@success @delete_from_list @projadminonly
Scenario: Delete custodian from list - Project Admin Only - Success
  Given I am logged in as an "projadminonly" user
  And I am on the "Custodians" tab for project "QE Project"
  When I delete a "Custodian" from the list with:
    | match      | {'Name'=>/^QEF\w*\sQEL\w*$/} |
  Then parsing the "Custodian Table" should NOT have a result with:
    | Name       | $current['Custodian'].full_name |
    | Email      | $current['Custodian'].email     |
    | Created by | Users['projadminonly']['email'] |
  And parsing the "Activity Table" should have a result with:
    | Title   | "Custodian was archived"                                                                 |
    | Message | /^\w+ \w+ archived custodian #{$current['Custodian'].full_name} for project QE Project$/ |

@success @delete_from_detail @projadminonly
Scenario: Delete custodian from detail - Project Admin Only - Success
  Given I am logged in as an "projadminonly" user
  And I am on the "Custodians" tab for project "QE Project"
  When I delete a "Custodian" from the details screen with:
    | match      | {'Name'=>/^QEF\w*\sQEL\w*$/} |
  Then parsing the "Custodian Table" should NOT have a result with:
    | Name       | $current['Custodian'].full_name |
    | Email      | $current['Custodian'].email     |
    | Created by | Users['projadminonly']['email'] |
  And parsing the "Activity Table" should have a result with:
    | Title   | "Custodian was archived"                                                                 |
    | Message | /^\w+ \w+ archived custodian #{$current['Custodian'].full_name} for project QE Project$/ |

@delete_from_list @standard
Scenario: Delete custodian from list - Standard
  Given I am logged in as a "standard" user
  When I am on the "Custodians" tab for project "QE Project"
  Then I should not see an element with:
    | type    | "css"                  |
    | value   | "td.project-actions a" |
    | visible | true                   |
    | within  | "div.ibox-content"     |

@delete_from_detail @standard
Scenario: Delete custodian from detail - Standard
  Given I am logged in as a "standard" user
  And I am on the "Custodians" tab for project "QE Project"
  When I go to the details screen for a "Custodian" with:
    | match      | {'Name'=>/^QEF\w*\sQEL\w*$/} |
  Then I should not see an element with:
    | type    | "button"           |
    | value   | "Delete"           |
    | visible | true               |
    | within  | "div.ibox-content" |

@delete_from_list @orgadminonly
Scenario: Delete custodian from list - Org Admin Only
  Given I am logged in as a "orgadminonly" user
  When I am on the "Custodians" tab for project "QE Project"
  Then I should not see an element with:
    | type    | "css"                  |
    | value   | "td.project-actions a" |
    | visible | true                   |
    | within  | "div.ibox-content"     |

@delete_from_detail @standard
Scenario: Delete custodian from detail - Org Admin Only
  Given I am logged in as a "orgadminonly" user
  And I am on the "Custodians" tab for project "QE Project"
  When I go to the details screen for a "Custodian" with:
    | match      | {'Name'=>/^QEF\w*\sQEL\w*$/} |
  Then I should not see an element with:
    | type    | "button"           |
    | value   | "Delete"           |
    | visible | true               |
    | within  | "div.ibox-content" |