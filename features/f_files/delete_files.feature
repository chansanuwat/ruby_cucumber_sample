@files @project_files @delete_file
Feature: As an app admin, I would like to be able to delete files
        so I can adequately manage the files for a project

@success @delete_from_list @projadminonly
Scenario: Delete file from list - Project Admin Only - Success
  Given I am logged in as an "projadminonly" user
  And I am on the "Files" tab for project "QE Project"
  When I delete a "Connected File" from the list with:
    | match      | {'Name'=>/^QE\sAutomation\sFile.*$/} |
  Then parsing the "Connected File Table" should NOT have a result with:
    | Name    | $current['ConnectedFile'].name    |
    | Id      | $current['ConnectedFile'].id      |
  And parsing the "Activity Table" should have a result with:
    | Title   | "File was deleted"                                                                |
    | Message | /^\w+ \w+ deleted file #{$current['ConnectedFile'].name} for project QE Project$/ |

@success @delete_from_list @standard
Scenario: Delete file from list - Standard User - Success
  Given I am logged in as an "standard" user
  And I am on the "Files" tab for project "QE Project"
  When I delete a "Connected File" from the list with:
    | match      | {'Name'=>/^QE\sAutomation\sFile.*$/} |
  Then parsing the "Connected File Table" should NOT have a result with:
    | Name    | $current['ConnectedFile'].name    |
    | Id      | $current['ConnectedFile'].id      |
  And parsing the "Activity Table" should have a result with:
    | Title   | "File was deleted"                                                                |
    | Message | /^\w+ \w+ deleted file #{$current['ConnectedFile'].name} for project QE Project$/ |

@success @delete_from_list @orgadminonly
Scenario: Delete file from list - Org Admin Only - Success
  Given I am logged in as an "orgadminonly" user
  And I am on the "Files" tab for project "QE Project"
  When I delete a "Connected File" from the list with:
    | match      | {'Name'=>/^QE\sAutomation\sFile.*$/} |
  Then parsing the "Connected File Table" should NOT have a result with:
    | Name    | $current['ConnectedFile'].name    |
    | Id      | $current['ConnectedFile'].id      |
  And parsing the "Activity Table" should have a result with:
    | Title   | "File was deleted"                                                                |
    | Message | /^\w+ \w+ deleted file #{$current['ConnectedFile'].name} for project QE Project$/ |

@success @delete_from_list @orgowner
Scenario: Delete file from list - Org Owner - Success
  Given I am logged in as an "orgowner" user
  And I am on the "Files" tab for project "QE Project"
  When I delete a "Connected File" from the list with:
    | match      | {'Name'=>/^QE\sAutomation\sFile.*$/} |
  Then parsing the "Connected File Table" should NOT have a result with:
    | Name    | $current['ConnectedFile'].name    |
    | Id      | $current['ConnectedFile'].id      |
  And parsing the "Activity Table" should have a result with:
    | Title   | "File was deleted"                                                                |
    | Message | /^\w+ \w+ deleted file #{$current['ConnectedFile'].name} for project QE Project$/ |