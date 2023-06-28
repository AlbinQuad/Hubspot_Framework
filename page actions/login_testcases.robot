*** Settings ***
Documentation       Template robot main suite.

Library             Collections
Library             DateTime
Library             RPA.Browser.Selenium    auto_close=${False}
Library             String
Library             ../libraries/html_tables.py
Library             RPA.Email.ImapSmtp    smtp_server=smtp.gmail.com    smtp_port=587
Variables           ../global variables/globalVariables.py
Variables           ../page objects/login_selectors.py
Resource            ../reusable keywords/readInputData.robot

*** Keywords ***
Hubspot Portal Launching
    #------------- launching URL successfully in the Chrome browser"---------#
    
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}       Open Available Browser    ${config}[WEBURL]    browser_selection=${config}[BROWSER]
    Maximize Browser Window
    Sleep  ${SHORT_WAIT}

    ${allow_cookies_present}=  RPA.Browser.Selenium.Is Element Visible  ${el_allow_cookies_btn}
        IF    '${allow_cookies_present}'=='True'
            Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}  Click Element    ${el_allow_cookies_btn} 
        END
    

Hubspot Portal Login
    #-------------logging in with the provided user id and password-----------------#
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Page Should Contain Element    ${el_login_btn}
    Wait Until Keyword Succeeds  ${GLOBAL_RETRY_AMOUNT}  ${GLOBAL_RETRY_INTERVAL}  Click Element    ${el_login_btn}

    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}   ${GLOBAL_RETRY_INTERVAL}     Wait Until Element Is Visible        ${el_Username}
    Input Text        ${el_Username}                ${config}[USER NAME]
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}   ${GLOBAL_RETRY_INTERVAL}     Wait Until Element Is Visible        ${el_password}
    Input Password    ${el_password}                ${config}[PASSWORD]
    Click Element If Visible    ${el_Login}
    Sleep    ${SHORT_WAIT}


Read Otp From Email
    #---------------------  Read otp from email -----------------------------------#
    ${otp_screen_present} =   RPA.Browser.Selenium.Is Element Visible      ${el_otp_field}
        IF  '${otp_screen_present}' == 'True'
            
            ${otp}=  Read Otp

            IF    '${otp}' == 'Fail'
                Sleep    ${LONG_WAIT}

                Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}  Click Element    ${el_resend_otp}
                
                ${otp}=  Read Otp
                IF    '${otp}' == 'Fail'
                    Log To Console    OTP is not recieved
                    Return From Keyword    Fail
                END
            ELSE
                Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}  Input Text    ${el_otp_field}    ${otp}
                Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}  Click Element    ${el_otp_login_btn}
                Sleep    ${SHORT_WAIT}


                #Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}   ${GLOBAL_RETRY_INTERVAL}     Wait Until Element Is Visible        ${el_welcome_btn}

                ${welcome_btn_present}=  RPA.Browser.Selenium.Is Element Visible  ${el_welcome_btn}
                IF    '${welcome_btn_present}'=='True'
                    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}  Click Element    ${el_welcome_btn} 
                END
                
                Sleep    ${SHORT_WAIT}
                ${def_home}=  RPA.Browser.Selenium.Is Element Visible    xpath://footer//button[2]
                IF    '${def_home}'=='True'
                    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Click Element    xpath://footer//button[2] 
                END
                Sleep    ${SHORT_WAIT}

                Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}   ${GLOBAL_RETRY_INTERVAL}     Wait Until Element Is Visible        ${el_contact_menu}
            END
        END


Read Otp
    Authorize    account=janeefarrobot2328@gmail.com   password=pikxjbwtciokwxim

    Sleep  75s    
    @{emails}    List Messages    FROM "noreply@hubspot.com"

    ${empty_or_not}  ${x}=  Run Keyword And Ignore Error  Should Not Be Empty  ${emails}
    
    IF    '${empty_or_not}' == 'PASS'
        ${code}=  extract_text_without_html  ${emails}[-1][Body]
        ${code1}=  Get Regexp Matches  ${code}  [0-9]{6}
        Log    ${code1}[0]
        Return From Keyword   ${code1}[0]
    ELSE
        Return From Keyword    Fail
    END


Contact Menu Validation
    #------------ Checking for menu 'Contacts', click on Contacts if it is visible --------------#

    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Page Should Contain Element       ${el_contact_menu}
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Click Element    ${el_contact_menu}

    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Page Should Contain Element    ${el_contact_sub_menu} 
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Click Element    ${el_contact_sub_menu}


Portal Create Contact
    #------------- Checking if Create Contact button visible, if yes click on Create Contact button ---------------
    Sleep    ${SHORT_WAIT}
    ${def_home}=  RPA.Browser.Selenium.Is Element Visible    xpath://footer//button[2]
    IF    '${def_home}'=='True'
        Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Click Element    xpath://footer//button[2] 
    END
    Sleep    ${SHORT_WAIT}

    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Page Should Contain Element       ${el_create_contact}
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Click Element    ${el_create_contact}

    Sleep    ${MEDIUM_WAIT}

    Select Frame    ${el_iframe_id}
    
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}   ${GLOBAL_RETRY_INTERVAL}     Page Should Contain Element        ${el_email_field}

    ${email_present}=  RPA.Browser.Selenium.Is Element Visible  ${el_email_field}
        IF    '${email_present}'=='True'
            Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}  Input Text    ${el_email_field}    ${inpu_tdata}[EMAIL] 
        END

    ${firstname_present}=  RPA.Browser.Selenium.Is Element Visible  ${el_firstname_field}
        IF    '${firstname_present}'=='True'
            Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}  Input Text    ${el_firstname_field}    ${inpu_tdata}[FIRSTNAME] 
        END

    ${lastname_present}=  RPA.Browser.Selenium.Is Element Visible  ${el_lastname_field}
        IF    '${lastname_present}'=='True'
            Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}  Input Text    ${el_lastname_field}    ${inpu_tdata}[LASTNAME] 
        END

    ${jobtitle_present}=  RPA.Browser.Selenium.Is Element Visible  ${el_jobtitle_field}
        IF    '${jobtitle_present}'=='True'
            Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}  Input Text    ${el_jobtitle_field}    ${inpu_tdata}[JOBTITLE] 
        END

    Sleep    ${MEDIUM_WAIT}

    ${create_btn_present}=  RPA.Browser.Selenium.Is Element Visible  ${el_all_create_btn}
        IF    '${create_btn_present}'=='True'
            Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}  Click Element    ${el_all_create_btn}
        END

    Unselect Frame


Company Creation Process
    #------------- After creating the Contact, it should be check if the  Create Company button is available in the portal. if yes, click on the Create company button,  then complete the company creation process. --------------------
    Sleep    ${MEDIUM_WAIT}

    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Page Should Contain Element       ${el_contact_menu}
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Click Element    ${el_contact_menu}
    Sleep    ${MEDIUM_WAIT}

    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Page Should Contain Element    ${el_company_submenu} 
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Click Element    ${el_company_submenu}
    Sleep    ${MEDIUM_WAIT}

    # Select Frame    ${el_iframe_company_page}
    # Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}   ${GLOBAL_RETRY_INTERVAL}     Wait Until Page Contains Element        ${el_company_heading}
    
    # Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}   ${GLOBAL_RETRY_INTERVAL}     Wait Until Page Contains Element        ${el_company_add_btn}
    # Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Click Element    ${el_company_add_btn}
    # Unselect Frame
    
    # Sleep    ${MEDIUM_WAIT}
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}   ${GLOBAL_RETRY_INTERVAL}     Wait Until Element Is Visible        //button[@data-test-id="new-object-button"]
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Click Element    //button[@data-test-id="new-object-button"]

    Select Frame    ${el_iframe_id}
    

    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}   ${GLOBAL_RETRY_INTERVAL}     Wait Until Element Is Visible        ${el_domain_name_field}
    ${domain_name_present}=  RPA.Browser.Selenium.Is Element Visible  ${el_domain_name_field}
        IF    '${domain_name_present}'=='True'
            Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Input Text    ${el_domain_name_field}    ${inpu_tdata}[DOMAIN_NAME]
        END
    

    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}   ${GLOBAL_RETRY_INTERVAL}     Wait Until Element Is Visible        ${el_company_name_field}
    ${domain_name_present}=  RPA.Browser.Selenium.Is Element Visible  ${el_company_name_field}
        IF    '${domain_name_present}'=='True'
            Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Input Text    ${el_company_name_field}    ${inpu_tdata}[COMPANY_NAME]
        END

    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}   ${GLOBAL_RETRY_INTERVAL}     Wait Until Element Is Visible        ${el_industry_field}
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Click Element    ${el_industry_field}

    ${search_present}=  RPA.Browser.Selenium.Is Element Visible  ${el_industry_search}
        IF    '${search_present}'=='True'
            Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Input Text    ${el_industry_search}    ${inpu_tdata}[INDUSTRY_NAME]
        END

    ${search_value_present}=  RPA.Browser.Selenium.Is Element Visible  ${el_industry_value}
        IF    '${search_value_present}'=='True'
            Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Click Element    ${el_industry_value}
        END

    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}   ${GLOBAL_RETRY_INTERVAL}     Wait Until Element Is Visible        ${el_type_field}
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Click Element    ${el_type_field}

    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Input Text    ${el_type_search}    ${inpu_tdata}[TYPE_NAME]

    ${type_value_present}=  RPA.Browser.Selenium.Is Element Visible  ${el_type_value}
        IF    '${type_value_present}'=='True'
            Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Click Element    ${el_type_value}
        END

    ${city_present}=  RPA.Browser.Selenium.Is Element Visible  ${el_city_field}
        IF    '${city_present}'=='True'
            Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Input Text    ${el_city_field}    ${inpu_tdata}[CITY_NAME]    
        END

    ${state_present}=  RPA.Browser.Selenium.Is Element Visible  ${el_state_field}
        IF    '${state_present}'=='True'
            Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Input Text    ${el_state_field}    ${inpu_tdata}[STATE_NAME]    
        END

    ${zip_present}=  RPA.Browser.Selenium.Is Element Visible  ${el_zip_field}
        IF    '${zip_present}'=='True'
            Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Input Text    ${el_zip_field}    ${inpu_tdata}[ZIP_NAME]    
        END

    ${emp_nmbr_present}=  RPA.Browser.Selenium.Is Element Visible  ${el_emp_nbr_field}
        IF    '${emp_nmbr_present}'=='True'
            Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Input Text    ${el_emp_nbr_field}    ${inpu_tdata}[NUMBER_OF_EMPS]    
        END

    ${annual_revenue_present}=  RPA.Browser.Selenium.Is Element Visible  ${el_annual_revenue_field}
        IF    '${annual_revenue_present}'=='True'
            Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Input Text    ${el_annual_revenue_field}    ${inpu_tdata}[ANNUAL_REVENUE]    
        END

    ${time_zone_present}=  RPA.Browser.Selenium.Is Element Visible  ${el_timezone_field}
        IF    '${time_zone_present}'=='True'
            Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Input Text    ${el_timezone_field}    ${inpu_tdata}[TIME_ZONE]    
        END

    ${description_present}=  RPA.Browser.Selenium.Is Element Visible  ${el_description_field}
        IF    '${description_present}'=='True'
            Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Input Text    ${el_description_field}    ${inpu_tdata}[DESCRIPTION]    
        END

    ${linkedin_present}=  RPA.Browser.Selenium.Is Element Visible  ${el_linkedin_cmp_field}
        IF    '${linkedin_present}'=='True'
            Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Input Text    ${el_linkedin_cmp_field}    ${inpu_tdata}[LINKEDIN COMPANY]    
        END

    Sleep    ${MEDIUM_WAIT}

    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Click Element    ${el_all_create_btn}

    Unselect Frame


Deal Creation Process
    #------------- After creating the Company, check if the  Create deal button is available in the portal. Click on the Create deal button, and complete the deal creation process. --------------------
    
    Sleep    ${MEDIUM_WAIT}
    #Select Frame    ${el_iframe_company_page}

    #Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}   ${GLOBAL_RETRY_INTERVAL}     Wait Until Page Contains Element       ${el_deal_heading}
    
    #Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}   ${GLOBAL_RETRY_INTERVAL}     Wait Until Page Contains Element        ${el_deal_add_btn}
    #Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Click Element    ${el_deal_add_btn}

    #Unselect Frame
    
    #Sleep    ${MEDIUM_WAIT}

    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Page Should Contain Element       ${el_sales_menu}
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Click Element    ${el_sales_menu}
    Sleep    ${MEDIUM_WAIT}

    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Page Should Contain Element       ${el_deal_menu}
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Click Element    ${el_deal_menu}

    Sleep    ${MEDIUM_WAIT}
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}   ${GLOBAL_RETRY_INTERVAL}     Wait Until Element Is Visible        //button[@data-test-id="new-object-button"]
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Click Element    //button[@data-test-id="new-object-button"]
    Sleep    ${MEDIUM_WAIT}

    Select Frame    ${el_iframe_id}

    Sleep    ${MEDIUM_WAIT}
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}   ${GLOBAL_RETRY_INTERVAL}     Wait Until Element Is Visible        ${el_deal_name}
    ${deal_name_present}=  RPA.Browser.Selenium.Is Element Visible  ${el_deal_name}
        IF    '${deal_name_present}'=='True'
            Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Input Text    ${el_deal_name}    ${inpu_tdata}[DEAL_NAME]
        END

    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}   ${GLOBAL_RETRY_INTERVAL}     Wait Until Element Is Visible        ${el_amount_field}
    ${amount_present}=  RPA.Browser.Selenium.Is Element Visible  ${el_amount_field}
        IF    '${amount_present}'=='True'
            Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Input Text    ${el_amount_field}    ${inpu_tdata}[AMOUNT]
        END

    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}   ${GLOBAL_RETRY_INTERVAL}     Wait Until Element Is Visible        ${el_dealtype_field}
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Click Element    ${el_dealtype_field}

    ${search_present}=  RPA.Browser.Selenium.Is Element Visible  ${el_industry_search}
        IF    '${search_present}'=='True'
            Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Input Text    ${el_industry_search}    ${inpu_tdata}[DEAL_TYPE]
        END

    ${deal_value_present}=  RPA.Browser.Selenium.Is Element Visible  ${el_deal_value}
        IF    '${deal_value_present}'=='True'
            Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Click Element    ${el_deal_value}
        END

    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}   ${GLOBAL_RETRY_INTERVAL}     Wait Until Element Is Visible        ${el_priority_field}
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Click Element    ${el_priority_field}

    ${priority_value_present}=  RPA.Browser.Selenium.Is Element Visible  ${el_priority_value}
        IF    '${priority_value_present}'=='True'
            Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Click Element    ${el_priority_value}
        END

    Sleep    ${MEDIUM_WAIT}

    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Click Element    ${el_all_create_btn}

    Unselect Frame


Ticket Creation Process
    #------------ After creating the Deal, check if the  Create ticket button is available in the portal. Click on the Create ticket button, then complete the ticket creation process. ---------------------------
    
    Sleep    ${MEDIUM_WAIT}
    # Select Frame    ${el_iframe_company_page}
    
    # Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}   ${GLOBAL_RETRY_INTERVAL}     Wait Until Page Contains Element        ${el_ticket_heading}
    
    # Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}   ${GLOBAL_RETRY_INTERVAL}     Wait Until Page Contains Element        ${el_ticket_add_btn}
    # Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Click Element    ${el_ticket_add_btn}

    # Unselect Frame
    
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Page Should Contain Element       ${el_service_menu}
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Click Element    ${el_service_menu}
    Sleep    ${MEDIUM_WAIT}

    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Page Should Contain Element       ${el_ticket_menu}
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Click Element    ${el_ticket_menu}
    Sleep    ${MEDIUM_WAIT}

    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}   ${GLOBAL_RETRY_INTERVAL}     Wait Until Element Is Visible        //button[@data-test-id="new-object-button"]
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Click Element    //button[@data-test-id="new-object-button"]
    Sleep    ${MEDIUM_WAIT}

    Select Frame    ${el_iframe_id}

    # Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}   ${GLOBAL_RETRY_INTERVAL}     Wait Until Element Is Visible        ${el_create_new_btn}
    # Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Click Element    ${el_create_new_btn}
    Sleep    ${MEDIUM_WAIT}
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}   ${GLOBAL_RETRY_INTERVAL}     Wait Until Element Is Visible        ${el_ticket_name_field}
    ${tkt_name_present}=  RPA.Browser.Selenium.Is Element Visible  ${el_ticket_name_field}
        IF    '${tkt_name_present}'=='True'
            Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Input Text    ${el_ticket_name_field}    ${inpu_tdata}[TICKET_NAME]
        END

    ${tkt_desc_present}=  RPA.Browser.Selenium.Is Element Visible  ${el_ticket_desc_field}
        IF    '${tkt_desc_present}'=='True'
            Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Input Text    ${el_ticket_desc_field}    ${inpu_tdata}[TICKET_DESC]
        END

    Sleep    ${MEDIUM_WAIT}
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Click Element    ${el_all_create_btn}

    Unselect Frame


Contact Deletion Process
    #--------- After creating the Ticket, it should be delete the created contact. -----------------------
    Sleep    ${MEDIUM_WAIT}
    Sleep    ${MEDIUM_WAIT}
    Contact Menu Validation
    Sleep    ${MEDIUM_WAIT}
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}   ${GLOBAL_RETRY_INTERVAL}     Wait Until Element Is Visible        ${el_contact_search_field}
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Input Text    ${el_contact_search_field}    ${inpu_tdata}[EMAIL]

    Delete Process


Company Deletion Process
#--------- After deleting contact, it should be delete the company. -----------------------
    
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Page Should Contain Element       ${el_contact_menu}
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Click Element    ${el_contact_menu}
    Sleep    ${MEDIUM_WAIT}

    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Page Should Contain Element       ${el_company_manu_link}
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Click Element    ${el_company_manu_link}

    Sleep    ${MEDIUM_WAIT}
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}   ${GLOBAL_RETRY_INTERVAL}     Wait Until Element Is Visible        ${el_contact_search_field}
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Input Text    ${el_contact_search_field}    ${inpu_tdata}[COMPANY_NAME]

    Delete Process


Deal Deletion Process
    
    Sleep    ${MEDIUM_WAIT}

    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Page Should Contain Element       ${el_sales_menu}
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Click Element    ${el_sales_menu}
    Sleep    ${MEDIUM_WAIT}

    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Page Should Contain Element       ${el_deal_menu}
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Click Element    ${el_deal_menu}

    Sleep    ${MEDIUM_WAIT}
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}   ${GLOBAL_RETRY_INTERVAL}     Wait Until Element Is Visible        ${el_contact_search_field}
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Input Text    ${el_contact_search_field}    ${inpu_tdata}[DEAL_NAME]

    Delete Process



Ticket Deletion Process

    Sleep    ${MEDIUM_WAIT}

    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Page Should Contain Element       ${el_service_menu}
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Click Element    ${el_service_menu}
    Sleep    ${MEDIUM_WAIT}

    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Page Should Contain Element       ${el_ticket_menu}
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Click Element    ${el_ticket_menu}

    Sleep    ${MEDIUM_WAIT}
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}   ${GLOBAL_RETRY_INTERVAL}     Wait Until Element Is Visible        ${el_contact_search_field}
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Input Text    ${el_contact_search_field}    ${inpu_tdata}[TICKET_NAME]

    Delete Process


Delete Process

    Sleep    ${MEDIUM_WAIT}
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}   ${GLOBAL_RETRY_INTERVAL}     Wait Until Element Is Visible        ${el_check_box}
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Click Element    ${el_check_box}
    Sleep    ${SHORT_WAIT}
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}   ${GLOBAL_RETRY_INTERVAL}     Wait Until Element Is Visible        ${el_delete_btn}
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Click Element    ${el_delete_btn}

    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}   ${GLOBAL_RETRY_INTERVAL}     Wait Until Element Is Visible        ${el_delete_confirm_field}
    Sleep    ${SHORT_WAIT}
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Input Text    ${el_delete_confirm_field}    1
    Sleep    ${SHORT_WAIT}
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}   ${GLOBAL_RETRY_INTERVAL}     Wait Until Element Is Visible        ${el_delete_confirm_btn}
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Click Element    ${el_delete_confirm_btn}


Portal sign out
    #------- Sign out process ---------------------------------
    
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}   ${GLOBAL_RETRY_INTERVAL}     Wait Until Element Is Visible        ${el_profile_btn}
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Click Element    ${el_profile_btn}

    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}   ${GLOBAL_RETRY_INTERVAL}     Wait Until Element Is Visible        ${el_signout_btn}
    Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}    Click Element    ${el_signout_btn}
    #---------- for failing purpose
    #Wait Until Element Is Visible        ${el_profile_btn}

Portal Closing
    Close All Browsers


Hubspot Portal Login & Contact Creation
    
    Hubspot Portal Launching
    Hubspot Portal Login
    Read Otp From Email
    Contact Menu Validation





    







    


    



    

    


    


    




# TC_07_Portal sign out
#     #-----------------Signing out of the portal---------------#
#     [Arguments]    ${TEST_NAME}

#     Wait Until Keyword Succeeds    ${GLOBAL_RETRY_AMOUNT}   ${GLOBAL_RETRY_INTERVAL}     Wait Until Page Contains Element    ${el_signout}
#     Click Element            ${el_signout}



