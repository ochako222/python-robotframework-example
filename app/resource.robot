*** Settings ***
Library  Browser
Variables    ../env_variables.yml

*** Keywords ***
Open Syndicate Login Page
    Open Browser  ${BASE_URL}

Fill in login form
    [Arguments]  ${username}=${NONE}  ${password}=${NONE}
    ${username}  Set Variable If  '${username}'=='${NONE}'  ${BASE_USERNAME}  ${username}
    ${password}  Set Variable If  '${password}'=='${NONE}'  ${BASE_USER_PASSWORD}  ${password}

    Fill Text  css=#username  ${username}
    Fill Text  css=#password  ${password}
    Click  css=#submitBtn

Expect home page loaded
    Wait For Elements State    css=.headerRow    visible
    Wait For Elements State    css=.channels    visible 

Expect error message appeared
    ${element}  Get Element    css=.alert-danger
    Wait For Elements State    ${element}    visible
    ${errorMessage}  Get Text  ${element}
    Should Be Equal  ${errorMessage}  The username or password is incorrect.

Navigate By Link
    [Arguments]  ${link}
    Click  css=.headerMenu .menuList a >> text=${link}

Expect Documents Page Loaded
    Wait For Elements State    css=.documents-header    visible
    Wait For Elements State    css=.documents-breadcrumbs    visible
    Wait For Elements State    css=[data-cy="add-folder-btn"]    visible
    Wait For Elements State    css=[data-cy="add-document-btn"]    visible
    

    