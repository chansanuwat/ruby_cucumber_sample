@tasks @add_task
Feature: As an app user, I would like to be able to add new tasks
        so I can help track things that need to be done for a project

@success @standard
Scenario: Add new task with defaults - Standard Admin - Success
  Given I am logged in as an "standard" user
  And I get the current "user name" as "user name"
  And I am on the "Tasks" tab for project "QE Project"
  And I have a unique "string" as "identifier" with:
    | size | 7 |
  When I add a new "Task" with:
    | Title        | "QE Automation Task #{$current['identifier']}"                 |
    | Description  | "Description of QE automation task #{$current['identifier']}"  |
    | Notes        | "Notes for QE automation task #{$current['identifier']}"       |
  Then parsing the "Task Table" should have a result with:
    | Title       | $current['Task'].title       |
    | Description | $current['Task'].description |
    | Status      | "New"                        |
    | Created By  | $current['user name']        |
    | Assigned To | ""                           |
    | Due         | ""                           |
    | Completed   | ""                           |
    | Priority    | "Normal"                     |
  And parsing the "Activity Table" should have a result with:
    | Title   | "Task was created"                                 |
    | Message | /^\w+ \w+ created task #{$current['Task'].title}$/ |

@success @standard @no_defaults
Scenario: Add new task without defaults - Standard Admin - Success
  Given I am logged in as an "standard" user
  And I get the current "user name" as "user name"
  And I am on the "Tasks" tab for project "QE Project"
  And I have a unique "string" as "identifier" with:
    | size | 7 |
  When I add a new "Task" with:
    | Title        | "QE Automation Task #{$current['identifier']}"                 |
    | Description  | "Description of QE automation task #{$current['identifier']}"  |
    | Notes        | "Notes for QE automation task #{$current['identifier']}"       |
    | Status       | "In Progress"                                                  |
    | Assigned To  | "Chai1 Hansanuwat1"                                            |
    | Due          | Toolbox.days_from_now(7)                                       |
    | Priority     | "Low"                                                          |
  Then parsing the "Task Table" should have a result with:
    | Title       | $current['Task'].title       |
    | Description | $current['Task'].description |
    | Status      | $current['Task'].status      |
    | Created By  | $current['user name']        |
    | Assigned To | $current['Task'].assigned_to |
    | Due         | $current['Task'].due         |
    | Completed   | ""                           |
    | Priority    | $current['Task'].priority    |
  And parsing the "Activity Table" should have a result with:
    | Title   | "Task was created and assigned"                                                                         |
    | Message | /^\w+ \w+ created and assigned task #{$current['Task'].title} to user #{$current['Task'].assigned_to}$/ |