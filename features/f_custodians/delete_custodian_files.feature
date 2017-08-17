@files @custodian_files @custodians @delete_custodian_files
Feature: Deleting custodian files

@success @projadminonly
Scenario: Delete custodian file - Project Admin Only - Success
  Given I am logged in as an "projadminonly" user
  And I am on the "Custodians" tab for project "QE Project"
  And I go to the "Custodian Files" tab for a "Custodian" with:
    | match      | {'Name'=>/^QEM\w*\sQEM\w*$/} |
  When I delete a "Connected File" from the list with:
    | match      | {'Name'=>/^QE\sAutomation\sFile.*$/} |
  Then parsing the "Connected File Table" should NOT have a result with:
    | Name    | $current['ConnectedFile'].name    |
    | Id      | $current['ConnectedFile'].id      |
  And parsing the "Activity Table" should have a result with:
    | Title   | "File was deleted"                                                                |
    | Message | /^\w+ \w+ deleted file #{$current['ConnectedFile'].name} for custodian #{$current['Custodian'].full_name}$/ |

@success @standard
Scenario: Delete custodian file - Standard User - Success
  Given I am logged in as an "standard" user
  And I am on the "Custodians" tab for project "QE Project"
  And I go to the "Custodian Files" tab for a "Custodian" with:
    | match      | {'Name'=>/^QEM\w*\sQEM\w*$/} |
  When I delete a "Connected File" from the list with:
    | match      | {'Name'=>/^QE\sAutomation\sFile.*$/} |
  Then parsing the "Connected File Table" should NOT have a result with:
    | Name    | $current['ConnectedFile'].name    |
    | Id      | $current['ConnectedFile'].id      |
  And parsing the "Activity Table" should have a result with:
    | Title   | "File was deleted"                                                                |
    | Message | /^\w+ \w+ deleted file #{$current['ConnectedFile'].name} for custodian #{$current['Custodian'].full_name}$/ |

@success @orgadminonly
Scenario: Delete custodian file - Org Admin Only - Success
  Given I am logged in as an "orgadminonly" user
  And I am on the "Custodians" tab for project "QE Project"
  And I go to the "Custodian Files" tab for a "Custodian" with:
    | match      | {'Name'=>/^QEM\w*\sQEM\w*$/} |
  When I delete a "Connected File" from the list with:
    | match      | {'Name'=>/^QE\sAutomation\sFile.*$/} |
  Then parsing the "Connected File Table" should NOT have a result with:
    | Name    | $current['ConnectedFile'].name    |
    | Id      | $current['ConnectedFile'].id      |
  And parsing the "Activity Table" should have a result with:
    | Title   | "File was deleted"                                                                |
    | Message | /^\w+ \w+ deleted file #{$current['ConnectedFile'].name} for custodian #{$current['Custodian'].full_name}$/ |

@success @orgowner
Scenario: Delete custodian file - Org Owner - Success
  Given I am logged in as an "orgowner" user
  And I am on the "Custodians" tab for project "QE Project"
  And I go to the "Custodian Files" tab for a "Custodian" with:
    | match      | {'Name'=>/^QEM\w*\sQEM\w*$/} |
  When I delete a "Connected File" from the list with:
    | match      | {'Name'=>/^QE\sAutomation\sFile.*$/} |
  Then parsing the "Connected File Table" should NOT have a result with:
    | Name    | $current['ConnectedFile'].name    |
    | Id      | $current['ConnectedFile'].id      |
  And parsing the "Activity Table" should have a result with:
    | Title   | "File was deleted"                                                                |
    | Message | /^\w+ \w+ deleted file #{$current['ConnectedFile'].name} for custodian #{$current['Custodian'].full_name}$/ |