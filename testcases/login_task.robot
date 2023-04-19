*** Settings ***
Documentation       Template robot main suite.

Library             Collections
Library             RPA.Excel.Files
Library             RPA.Email.ImapSmtp    smtp_server=smtp.gmail.com    smtp_port=587
Resource            ../page actions/login_testcases.robot
Resource            ../reusable keywords/readInputData.robot
Suite Setup         Reading TestCase and Configdata Sheet
Suite Teardown      login_testcases.Portal Closing


*** Test Cases ***
Hubspot Portal Launch & Login
    [Tags]  login
    Hubspot Portal Login & Contact Creation
    [Teardown]    Save Status     ${TEST_NAME}

*** Test Cases ***
Hubspot Portal Contact Creation
    [Tags]  Contact
    Portal Create Contact
    [Teardown]    Save Status     ${TEST_NAME}

*** Test Cases ***
Hubspot Portal Company Creation
    [Tags]  Company
    Company Creation Process
    [Teardown]    Save Status     ${TEST_NAME}

*** Test Cases ***
Hubspot Portal Deal Creation
    [Tags]  Deal
    Deal Creation Process
    [Teardown]    Save Status     ${TEST_NAME}

*** Test Cases ***
Hubspot Portal Ticket Creation
    [Tags]  Ticket
    Ticket Creation Process
    [Teardown]    Save Status     ${TEST_NAME}

*** Test Cases ***
Hubspot Portal Delete Contact
    [Tags]  Deletion
    Contact Deletion Process
    Company Deletion Process
    Deal Deletion Process
    Ticket Deletion Process
    Portal sign out
    [Teardown]    Save Status     ${TEST_NAME}




 