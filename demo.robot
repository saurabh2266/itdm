*** Settings ***
Library  SeleniumLibrary
Library  Collections
Library    ${CURDIR}//utils//commonFunctions//add.py



*** Variables ***
${BROWSER}        Chrome
${URL}            https://ncshptest.partners.ncqa3.hrissuite.com
${Loginfield}    id:username
${userid}     dataqa@itedium.com

*** Test Cases ***
Visit Web Page
    Open Browser    ${URL}    ${BROWSER}
    ${result}=      Sum    1     2
    Log To Console    ${result}
    # Maximize Browser Window    
    Input Text    ${Loginfield}    ${userid}
    Input Text    id:password    oL#EAm4#1RgV
    # Click Element    //*[@id="loginform"]/div[3]/button
    # Sleep     120s



