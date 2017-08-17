@files @project_files @download_file
Feature: Ability to download files

@success @projadminonly
Scenario: Download - Project Admin Only - Success
  Given I am logged in as an "projadminonly" user
  And I am on the "Files" tab for project "QE Project"
  When I download a file from the list matching:
    | match      | {'Name'=>/^QE\sDownload\sFile.*$/} |
  Then a "QE Download File.zip" file should be in the downloads folder

@success @standard
Scenario: Download - Standard User - Success
  Given I am logged in as a "standard" user
  And I am on the "Files" tab for project "QE Project"
  When I download a file from the list matching:
    | match      | {'Name'=>/^QE\sDownload\sFile.*$/} |
  Then a "QE Download File.zip" file should be in the downloads folder

@success @orgadminonly
Scenario: Download - Org Admin Only - Success
  Given I am logged in as an "orgadminonly" user
  And I am on the "Files" tab for project "QE Project"
  When I download a file from the list matching:
    | match      | {'Name'=>/^QE\sDownload\sFile.*$/} |
  Then a "QE Download File.zip" file should be in the downloads folder

@success @orgowner
Scenario: Download - Org Owner - Success
  Given I am logged in as an "orgowner" user
  And I am on the "Files" tab for project "QE Project"
  When I download a file from the list matching:
    | match      | {'Name'=>/^QE\sDownload\sFile.*$/} |
  Then a "QE Download File.zip" file should be in the downloads folder