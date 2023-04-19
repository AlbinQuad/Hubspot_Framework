#-----------------------------------------Login and text Validation----------------------------------------

el_Username = 'xpath://*[@id="username"]'
el_password = 'xpath://*[@id="password"]'
el_Login = 'xpath://*[@id="loginBtn"]'
el_Login_error = 'xpath://*[@data-error-type="INVALID_PASSWORD"]'
el_otp_field = 'xpath://input[@id="code"]'
el_otp_login_btn = 'xpath://button[@type="submit"]'
el_welcome_btn = 'xpath://button[@data-test-id="inexperienced-welcome-modal-close-button"]'
el_resend_otp = 'xpath://*[contains(text(),"Request another code")]'
#el_text_validation = '//div[contains(text(),"Welcome To Manappuram Finance Limited Customer eService Portal")]'
#-----------------------------------------------------------------------------------------------------------

el_allow_cookies_btn = 'xpath://button[@id="hs-eu-confirmation-button" and contains(text(),"Allow cookies")]'
el_login_btn = 'xpath:(//a[@data-logged-in-href="//app.hubspot.com/home" and contains(text(),"Log in")])[1]'
el_contact_menu = 'xpath:(//a[contains(text(),"Contacts")])[1]'
el_contact_sub_menu = 'xpath:(//a[@id="nav-secondary-contacts"])[1]'
el_create_contact = 'xpath://button//*[contains(text(),"Create contact")]'
#-----------------------------------------------------------------------------------------------------------

#---------------------- Ui elements in Create Contact page -------------------------------------------------
el_iframe_id = 'xpath://iframe[@id="object-builder-ui"]'
el_email_field = 'xpath://input[@data-test-id="email-input"]'
el_firstname_field = 'xpath://input[@data-test-id="firstname-input"]'
el_lastname_field = 'xpath://input[@data-test-id="lastname-input"]'
el_jobtitle_field = 'xpath://textarea[@data-test-id="jobtitle-input"]'
el_phone_field = 'xpath://textarea[@data-test-id="phone-input"]'
el_create_btn = 'xpath://button[@data-onboarding="dialog-create-contact-button"]'
#-----------------------------------------------------------------------------------------------------------

#---------------------- Ui elements in company creation page ---------------------------------------------
el_iframe_company_page = 'xpath://iframe[@data-onboarding="overview-tab-iframe"]'
el_company_heading = 'xpath://main[@data-test-id="Pane"]//h4[contains(text(),"Companies")]'
el_company_add_btn = 'xpath://main[@data-test-id="Pane"]//h4[contains(text(),"Companies")]/parent::div/parent::div/preceding-sibling::div/child::button'
el_create_new_btn = 'xpath:(//a[@data-tab-id="createOrEdit"])[1]'
el_domain_name_field = 'xpath://input[@data-test-id="domain-input"]'
el_company_name_field = 'xpath://textarea[@data-test-id="name-input"]'
el_industry_field = 'xpath://div[@data-test-id="industry-input"]'
el_industry_search = 'xpath://input[@type="search"]'
el_industry_value = 'xpath://button[@title="Information Technology and Services"]'
el_type_field = 'xpath://div[@data-test-id="type-input"]'
el_type_search = 'xpath://input[@type="search"]'
el_type_value = 'xpath://button[@title="Other"]'
el_city_field = 'xpath://textarea[@data-test-id="city-input"]'
el_state_field = 'xpath://textarea[@data-test-id="state-input"]'
el_zip_field = 'xpath://textarea[@data-test-id="zip-input"]'
el_emp_nbr_field = 'xpath://input[@data-test-id="numberofemployees-input"]'
el_annual_revenue_field = 'xpath://input[@data-test-id="annualrevenue-input"]'
el_timezone_field = 'xpath://textarea[@data-test-id="timezone-input"]'
el_description_field = 'xpath://textarea[@data-test-id="description-input"]'
el_linkedin_cmp_field = 'xpath://textarea[@data-test-id="linkedin_company_page-input"]'
el_all_create_btn = 'xpath://button[@data-selenium-test="create"]'
el_company_manu_link = 'xpath:(//a[@id="nav-secondary-companies"])[1]'
#---------------------------------------------------------------------------------------------------------

#---------------------- Ui elements in deal creation page ------------------------------------------------

el_deal_heading = 'xpath://main[@data-test-id="Pane"]//h4[contains(text(),"Deals")]'
el_deal_add_btn = 'xpath://main[@data-test-id="Pane"]//h4[contains(text(),"Deals")]/parent::div/parent::div/preceding-sibling::div/child::button'
el_deal_name = 'xpath://textarea[@data-test-id="dealname-input"]'
el_amount_field = 'xpath://input[@data-test-id="amount-input"]'
el_dealtype_field = 'xpath://div[@data-test-id="dealtype-input"]'
el_industry_search = 'xpath://input[@type="search"]'
el_deal_value = 'xpath://button[@title="New Business"]'
el_priority_field = 'xpath://div[@data-test-id="hs_priority-input"]'
el_priority_value ='xpath://li[@data-option-value="medium"]'
#---------------------------------------------------------------------------------------------------------

#---------------------- Ui elements in ticket creation page ----------------------------------------------

el_ticket_heading = 'xpath://main[@data-test-id="Pane"]//h4[contains(text(),"Tickets")]'
el_ticket_add_btn = 'xpath://main[@data-test-id="Pane"]//h4[contains(text(),"Tickets")]/parent::div/parent::div/preceding-sibling::div/child::button'
el_ticket_name_field = 'xpath://textarea[@data-test-id="subject-input"]'
el_ticket_desc_field = 'xpath://textarea[@data-test-id="content-input"]'
#---------------------------------------------------------------------------------------------------------

#--------------------- Ui elements in contact deletion page
el_contact_search_field = 'xpath://input[@data-test-id="index-page-search"]'
el_check_box = 'xpath://table[@data-test-id="framework-data-table"]//tbody//tr//td[1]'
el_delete_btn = 'xpath://button[@data-selenium-test="bulk-action-delete"]'
el_delete_confirm_field = 'xpath://textarea[@data-selenium-test="delete-dialog-match"]'
el_delete_confirm_btn = 'xpath://button[@data-test-id="delete-dialog-confirm-button"]'
#--------------------------------------------------------------------------------------------------------

#---------------------- Ui element for logout page ------------------------------------------------------
el_profile_btn = 'xpath://button[@id="account-menu"]'
el_signout_btn = 'xpath://a[@id="signout"]'


# ---------- Other -----------------
el_sales_menu = 'xpath:(//a[contains(text(),"Sales")])[1]'
el_deal_menu = 'xpath:(//a//div[contains(text(),"Deals")])[1]'
el_service_menu = 'xpath:(//a[@id="nav-primary-service-branch"])[1]'
el_ticket_menu = 'xpath:(//a//div[contains(text(),"Tickets")])[1]'


