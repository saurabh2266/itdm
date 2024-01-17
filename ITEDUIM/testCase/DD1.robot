*** Settings ***
Library  SeleniumLibrary
Resource    ../resources/loginResources.robot
Library  DataDriver   ${EXECDIR}\\ITEDUIM\\testData\\LoginData.xlsx


Suite Setup    Open My Browser
Suite Teardown  Close Browsers
Test Template    Invalid login

*** Test Cases ***               
loginWithInvalidPassword using ${username} and ${password} 

# right user Empty Pwd    dataqa@itedium.com    ${EMPTY}     
# right user wrong Pwd    dataqa@itedium.com    1234  
# wrong user Empty Pwd    wvdgw@itedium.com    ${EMPTY}     
# wrong user wrong Pw    dataqa@itedium.com    ${EMPTY}     



*** Keywords ***
Invalid login
    [Arguments]  ${username}     ${password}
    # Log To Console    -----------------username------->${username} 
    #  Log To Console    --------------password----->${password}
    Open Login Page
    Input username    ${username}
    Input password    ${password}
    # Click To Login    
