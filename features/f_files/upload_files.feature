@files @project_files @upload_files @upload_file @project_file_upload
Feature: File uploads

@multiple_files @projadminonly
Scenario: Upload multiple files - Project Admin Only - Success
  Given I am logged in as an "projadminonly" user
  And I am on the "Files" tab for project "QE Project"
  And I have a generated file as "file_01"
  And I have a generated file as "file_02"
  When I upload the following files:
    | $current['file_01'].path |
    | $current['file_02'].path |
  Then parsing the "Connected File Table" should have a result with:
    | Name       | $current['file_01'].name |
  And parsing the "Connected File Table" should have a result with:
    | Name       | $current['file_02'].name |
  And parsing the "Activity Table" should have a result with:
    | Title   | "File was uploaded"                                                          |
    | Message | /^\w+ \w+ uploaded file #{$current['file_01'].name} for project QE Project$/ |
  And parsing the "Activity Table" should have a result with:
    | Title   | "File was uploaded"                                                          |
    | Message | /^\w+ \w+ uploaded file #{$current['file_02'].name} for project QE Project$/ |

@multiple_files @standard
Scenario: Upload multiple files - Standard User - Success
  Given I am logged in as an "standard" user
  And I am on the "Files" tab for project "QE Project"
  And I have a generated file as "file_01"
  And I have a generated file as "file_02"
  When I upload the following files:
    | $current['file_01'].path |
    | $current['file_02'].path |
  Then parsing the "Connected File Table" should have a result with:
    | Name       | $current['file_01'].name |
  And parsing the "Connected File Table" should have a result with:
    | Name       | $current['file_02'].name |
  And parsing the "Activity Table" should have a result with:
    | Title   | "File was uploaded"                                                          |
    | Message | /^\w+ \w+ uploaded file #{$current['file_01'].name} for project QE Project$/ |
  And parsing the "Activity Table" should have a result with:
    | Title   | "File was uploaded"                                                          |
    | Message | /^\w+ \w+ uploaded file #{$current['file_02'].name} for project QE Project$/ |

@multiple_files @orgadminonly
Scenario: Upload multiple files - Org Admin Only - Success
  Given I am logged in as an "orgadminonly" user
  And I am on the "Files" tab for project "QE Project"
  And I have a generated file as "file_01"
  And I have a generated file as "file_02"
  When I upload the following files:
    | $current['file_01'].path |
    | $current['file_02'].path |
  Then parsing the "Connected File Table" should have a result with:
    | Name       | $current['file_01'].name |
  And parsing the "Connected File Table" should have a result with:
    | Name       | $current['file_02'].name |
  And parsing the "Activity Table" should have a result with:
    | Title   | "File was uploaded"                                                          |
    | Message | /^\w+ \w+ uploaded file #{$current['file_01'].name} for project QE Project$/ |
  And parsing the "Activity Table" should have a result with:
    | Title   | "File was uploaded"                                                          |
    | Message | /^\w+ \w+ uploaded file #{$current['file_02'].name} for project QE Project$/ |

@multiple_files @orgowner
Scenario: Upload multiple files - Org Owner - Success
  Given I am logged in as an "orgowner" user
  And I am on the "Files" tab for project "QE Project"
  And I have a generated file as "file_01"
  And I have a generated file as "file_02"
  When I upload the following files:
    | $current['file_01'].path |
    | $current['file_02'].path |
  Then parsing the "Connected File Table" should have a result with:
    | Name       | $current['file_01'].name |
  And parsing the "Connected File Table" should have a result with:
    | Name       | $current['file_02'].name |
  And parsing the "Activity Table" should have a result with:
    | Title   | "File was uploaded"                                                          |
    | Message | /^\w+ \w+ uploaded file #{$current['file_01'].name} for project QE Project$/ |
  And parsing the "Activity Table" should have a result with:
    | Title   | "File was uploaded"                                                          |
    | Message | /^\w+ \w+ uploaded file #{$current['file_02'].name} for project QE Project$/ |