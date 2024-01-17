*** Settings ***
Library  SeleniumLibrary
*** Variables ***
${Login_URL}   https://ncshptest.partners.ncqa3.hrissuite.com/
${BROWSER}    Chrome
*** Keywords ***
Open My Browser
    Open Browser    ${Login_URL}    ${BROWSER}  
    Maximize Browser Window 

Close Browsers
    Close All Browsers


Open Login Page
    go to    ${Login_URL}

Input username
    [Arguments]    ${username}
     Input Text    id:username     ${username}  

Input password
    [Arguments]    ${password}
     Input Text    id:password     ${password} 


Click To Login
    Click Element    //*[@id="loginform"]/div[3]/button  
