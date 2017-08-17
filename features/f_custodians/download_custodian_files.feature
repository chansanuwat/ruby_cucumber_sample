@files @custodian_files @custodians @download_custodian_files @download_file
Feature: Downloading custodian files

@success @projadminonly
Scenario: Download custodian file - Project Admin Only - Success
  Given I am logged in as an "projadminonly" user
  And I am on the "Custodians" tab for project "QE Project"
  And I go to the "Custodian Files" tab for a "Custodian" with:
    | match      | {'Name'=>/^QEDNM\w*\sQEDoNotModify\w*$/} |
  When I download a file from the list matching:
    | match      | {'Name'=>/^QE\sDownload\sFile.*$/} |
  Then a "QE Download File.zip" file should be in the downloads folder

@success @standard
Scenario: Download custodian file - Standard User - Success
  Given I am logged in as an "standard" user
  And I am on the "Custodians" tab for project "QE Project"
  And I go to the "Custodian Files" tab for a "Custodian" with:
    | match      | {'Name'=>/^QEDNM\w*\sQEDoNotModify\w*$/} |
  When I download a file from the list matching:
    | match      | {'Name'=>/^QE\sDownload\sFile.*$/} |
  Then a "QE Download File.zip" file should be in the downloads folder

@success @orgadminonly
Scenario: Download custodian file - Org Admin Only - Success
  Given I am logged in as an "orgadminonly" user
  And I am on the "Custodians" tab for project "QE Project"
  And I go to the "Custodian Files" tab for a "Custodian" with:
    | match      | {'Name'=>/^QEDNM\w*\sQEDoNotModify\w*$/} |
  When I download a file from the list matching:
    | match      | {'Name'=>/^QE\sDownload\sFile.*$/} |
  Then a "QE Download File.zip" file should be in the downloads folder

@success @orgowner
Scenario: Download custodian file - Org Owner - Success
  Given I am logged in as an "orgowner" user
  And I am on the "Custodians" tab for project "QE Project"
  And I go to the "Custodian Files" tab for a "Custodian" with:
    | match      | {'Name'=>/^QEDNM\w*\sQEDoNotModify\w*$/} |
  When I download a file from the list matching:
    | match      | {'Name'=>/^QE\sDownload\sFile.*$/} |
  Then a "QE Download File.zip" file should be in the downloads folder