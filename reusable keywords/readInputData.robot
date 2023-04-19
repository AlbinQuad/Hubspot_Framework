*** Settings ***
Documentation       Template robot main suite.     # ROBOT REUSABLES

Library             Collections
Library             RPA.Excel.Files
Library             updateStatus.py
Library             RPA.Browser.Selenium
Variables             ../global variables/globalVariables.py
Library             RPA.Tables

*** Variables ***
&{config_datas}
${test_cases}
&{dataset}
${status_File}        ${TEST_CASE_SHEET_LOC}

*** Keywords ***
Reading TestCase and Configdata Sheet
    #-------------------- READING CONFIG SHEET -----------------------------
    Open Workbook      ${CONFIG_SHEET_LOC}
    ${data}  Read Worksheet As Table      Config_Sheet      ${True}
    Close Workbook
    FOR    ${row}    IN    @{data}       
        Set To Dictionary    ${config_datas}      ${row['Name']}      ${row['Value']}
    END

    Set Global Variable    ${config}    ${config_datas}
    Log To Console    ${config}

    #----------------------- READING INPUT SHEET -----------------------------
    Open Workbook      ${INPUT_SHEET_LOC}
    ${input_sheet_data}  Read Worksheet As Table      Input_Sheet      ${True}
    Close Workbook
    @{data_list} =    Create List
    FOR    ${row}    IN    @{input_sheet_data}       
        ${data_list}=    Set Variable  ${row}    
    END
    Set Global Variable    ${inpu_tdata}   ${data_list}

    #------------------------- UPDATING STATUS TO EXCEL ------------------------
*** Keywords ***
Save Status
    [Arguments]    ${TEST_NAME}
    
    Set Suite Variable    ${status}     ${TEST_STATUS}
    update_excel_value    ${status_File}    TEST CASE     ${TEST_NAME}    STATUS    ${status}

Portal Closing
    Close All Browsers
