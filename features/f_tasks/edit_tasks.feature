@tasks @edit_task
Feature: As an app admin, I would like to be able to edit tasks
        so can adequately manage the tasks for a project

@success @standard_user
Scenario: Edit task - Standard User - Success
  Given I am logged in as a "standard" user
  And I am on the "Tasks" tab for project "QE Project"
  And I have a unique "string" as "identifier" with:
    | size | 7 |
  When I edit a "Task" with:
    | match       | {'Title'=>/^QE Automation Task\s\w+$/, 'Status' => 'New'}         |
    | Title       | "QE Automation Task #{$current['identifier']}"                    |
    | Description | "Description of QE Automation task #{$current['identifier']}"     |
    | Due         | Toolbox.days_from_now(9)                                          |
    | Status      | "In Progress"                                                     |
  Then parsing the "Task Table" should have a result with:
    | Title       | $current['Task'].title       |
    | Description | $current['Task'].description |
    | Status      | $current['Task'].status      |
    | Created By  | $current['Task'].created_by  |
    | Assigned To | $current['Task'].assigned_to |
    | Due         | $current['Task'].due         |
    | Completed   | $current['Task'].completed   |
    | Priority    | $current['Task'].priority    |

@success @complete_task @standard_user
Scenario: Complete task - Standard User - Success
  Given I am logged in as a "standard" user
  And I am on the "Tasks" tab for project "QE Project"
  And I have a unique "string" as "identifier" with:
    | size | 7 |
  When I edit a "Task" with:
    | match  | {'Title'=>/^QE Automation Task\s\w+$/, 'Status' => 'In Progress'} |
    | Status | "Completed"                                                       |
  Then parsing the "Task Table" should have a result with:
    | Title       | $current['Task'].title       |
    | Description | $current['Task'].description |
    | Status      | $current['Task'].status      |
    | Created By  | $current['Task'].created_by  |
    | Assigned To | $current['Task'].assigned_to |
    | Due         | $current['Task'].due         |
    | Completed   | Toolbox.days_from_now(0)     |
    | Priority    | $current['Task'].priority    |
  And parsing the "Activity Table" should have a result with:
    | Title   | "Task was completed"                                 |
    | Message | /^\w+ \w+ completed task #{$current['Task'].title}$/ |

@success @increase_priority @standard_user
Scenario: Increase task priority - Standard User - Success
  Given I am logged in as a "standard" user
  And I am on the "Tasks" tab for project "QE Project"
  And I have a unique "string" as "identifier" with:
    | size | 7 |
  When I edit a "Task" with:
    | match    | {'Title'=>/^QE Automation Task\s\w+$/, 'Priority' => 'Low'} |
    | Priority | "High"                                                      |
  Then parsing the "Task Table" should have a result with:
    | Title       | $current['Task'].title       |
    | Description | $current['Task'].description |
    | Status      | $current['Task'].status      |
    | Created By  | $current['Task'].created_by  |
    | Assigned To | $current['Task'].assigned_to |
    | Due         | $current['Task'].due         |
    | Completed   | $current['Task'].completed   |
    | Priority    | $current['Task'].priority    |
  And parsing the "Activity Table" should have a result with:
    | Title   | "Task was updated"                                                  |
    | Message | /^\w+ \w+ updated task #{$current['Task'].title} to high priority$/ |

@success @assign_task @standard_user
Scenario: Task assignment - Standard User - Success
  Given I am logged in as a "standard" user
  And I am on the "Tasks" tab for project "QE Project"
  And I have a unique "string" as "identifier" with:
    | size | 7 |
  When I edit a "Task" with:
    | match       | {'Title'=>/^QE Automation Task\s\w+$/, 'Assigned To' => /^$/} |
    | Assigned To | "Chai1 Hansanuwat1"                                         |
  Then parsing the "Task Table" should have a result with:
    | Title       | $current['Task'].title       |
    | Description | $current['Task'].description |
    | Status      | $current['Task'].status      |
    | Created By  | $current['Task'].created_by  |
    | Assigned To | $current['Task'].assigned_to |
    | Due         | $current['Task'].due         |
    | Completed   | $current['Task'].completed   |
    | Priority    | $current['Task'].priority    |
  And parsing the "Activity Table" should have a result with:
    | Title   | "Task was assigned"                                                                         |
    | Message | /^\w+ \w+ assigned task #{$current['Task'].title} to user #{$current['Task'].assigned_to}$/ |