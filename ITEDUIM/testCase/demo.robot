*** Settings ***

Library  SeleniumLibrary
# Library  Collections
Library  OperatingSystem
Library  DataDriver   ${EXECDIR}\\ITEDUIM\\testData\\ITEDUIMTestDataFirtsRow.xlsx
Resource    ../resources/loginResources.robot
Library   ${EXECDIR}\\utils\\commonFunctions\\getSupplementalID.py
Library   ${EXECDIR}\\utils\\commonFunctions\\getEmployeeName.py
Library   ${EXECDIR}\\utils\\commonFunctions\\getDashedSSN.py
Library   ${EXECDIR}\\utils\\commonFunctions\\getAddressAsTestData.py
Library   ${EXECDIR}\\utils\\commonFunctions\\replace.py
Library   ${EXECDIR}\\utils\\commonFunctions\\getDashedMobileNumber.py





# Suite Setup    Open My Browser
# Suite Teardown  Close Browsers
Test Template    Invalid login
# Test Template  Invalid Login
*** Variables ***
${BROWSER}    Chrome
${URL}        https://ncshptest.partners.ncqa3.hrissuite.com
${userid}     dataqa@itedium.com
${Password}   oL#EAm4#1RgV

*** Test Cases ***
ReadingTestdataFromXLSXusing using ${memberName} and ${SSN (or ID)} 

*** Keywords ***
Invalid Login
    [Arguments]  ${MasterPolicy}       ${Supplemental IDs}    ${memberName}    ${Sex}    ${DOB}    ${SSN (or ID)}    ${Address}    ${M Phone}    ${Employment}    ${Plan Description}    ${Benefit Begin}    ${Benefit End}    ${Employment Begin}
    Open My Browser
    ${supplementalID}=   getSupplementalID   ${Supplemental IDs}  
    ${name}=    getEmployeeName     ${memberName}  
    Input username   ${userid}
    Input password    ${password}
    ${dashedSSN}=    getDashedSSN    ${SSN (or ID)}   
    ${typeOFDOB}=    Evaluate     type($DOB)
    ${DOBlength}=    Get Length    ${DOB} 
    Click To Login
    Input Text    name:intellisearch    ${supplementalID}
    click Element    //*[@id="side-bar"]/div/div/form/div/span/button  
    Sleep    3s
    Table Cell Should Contain   //*[@id="main-content"]/div/div[2]/div/div/div[2]/table    2    1     ${name["firstName"]}   
    Table Cell Should Contain   //*[@id="main-content"]/div/div[2]/div/div/div[2]/table    2    2     ${name["lastName"]} 
    ${accountType}    Get Text    //*[@id="main-content"]/div/div[2]/div/div/div[2]/table/tbody/tr[2]/td[3]
#     Log To Console     ----------------accountTypeaccountType-----------${accountType} 
    IF    '${accountType}' == 'Employee'
        Log To Console    in the ifffffffffffffffffff---- ${accountType}
    click Element    //*[@id="main-content"]/div/div[2]/div/div/div[2]/table/tbody/tr[2]/td[6]/a
    Sleep    3s
    Switch Window    title=Administration Portal
    Sleep    3s
    Table Cell Should Contain    //*[@id="page_36"]/div[1]/div[1]/table    5    2    ${Sex[0]} 
    IF    ${DOBlength} == 0
         Log To Console    This line IS executed. 
    ELSE
          Log To Console    ENDENDENDENDENDENDENDENDENDENDENDEND. 
          # Table Cell Should Contain    //*[@id="page_36"]/div[1]/div[1]/table    6    2    ${DOB}  
     END

#     Log To Console    ----ssn------------>${dashedSSN}
    Table Cell Should Contain    //*[@id="page_36"]/div[1]/div[1]/table    7    2    ${dashedSSN}
    ${_actualAddress}    Get Text    //*[@id="page_36"]/div[2]/div/table/tbody/tr[2]/td[3]
    ${actualAddress}=    getAddressAsTestData    ${_actualAddress}
#   Table Cell Should Contain    //*[@id="page_36"]/div[2]/div/table    2    3    ${Address}
    ${actualAddressWithoutCommas}=    replace    ${actualAddress} 
    ${addressWithoutCommas}=    replace    ${Address}
#     Should Be Equal As Strings     ${addressWithoutCommas.strip().replace(" ", "")}    ${actualAddressWithoutCommas.strip().replace(" ", "")}    case_insensitive=True     ignore_whitespace=True    ignore_order=True    
#     Sleep    180s   
#     Log   --------------addressWithoutCommas----->${addressWithoutCommas.strip().replace(" ", "")} 
    ${Phonelength}=    Get Length    ${M Phone}
    IF    ${Phonelength} == 16
    ${mobileNumber}=     getDashedMobileNumber    ${M Phone}
    
     ${contactsTableWebelement}    Get WebElements    //*[@id="page_36"]/div[2]/div/table/tbody/tr
    ${contactsTableRowCount}    Get Length    ${contactsTableWebelement}
#     Log To Console  --------------${contactsTableRowCount}-----> ${contactsTableRowCount} 
    ##################
       IF    ${contactsTableRowCount} == 3
             Table Cell Should Contain    //*[@id="page_36"]/div[2]/div/table    3    3    ${mobileNumber.strip()}
          #    Log To Console  --------------in the inner if -----> 

       ELSE
           Table Cell Should Contain    //*[@id="page_36"]/div[2]/div/table    4    3    ${mobileNumber.strip()}
       END
           
    END

    click Element    //*[@id="main-content"]/div/div[2]/div/ul/li[2]/a  
    Sleep    3s
     ${employment_record_row_elements}    Get WebElements    //*[@id="page_37"]/div[1]/div/table/tbody/tr[2]
     ${employment_record_row_count}    Get Length    ${employment_record_row_elements}
#      ##################
          # Log To Console    in the"${Employment} == 'TE'"-------------------${Employment}

    IF   '${Employment}' == 'TE'
     # Log To Console    in the"'${Employment}' == 'TE'"-------------------${Employment}
     #     ${employment_record_row_elements}    Get WebElements    //*[@id="page_37"]/div[1]/div/table/tbody/tr
     #     ${row_count}    Get Length    ${employment_record_row_elements}
         Should Be Equal As Numbers    ${employment_record_row_count}    1
         click Element    //*[@id="main-content"]/div/div[2]/div/ul/li[3]
         Sleep    5s
         ${activeBenefitsRowElementForTE}     Get WebElements    //*[@id="page_38"]/div[1]/div/table/tbody/tr
         ${activeBenefitsRowCountForTE}    Get Length    ${activeBenefitsRowElementForTE}
     #     Should Be Equal As Numbers    ${activeBenefitsRowCountForTE}    
         ${typeactiveBenefitsRowCount}    Evaluate    type('${activeBenefitsRowCountForTE}')
        
          # Log To Console    in the iffffffffactiveBenefitsRowCountForTEf------------------- ${activeBenefitsRowCountForTE} 
          
     ELSE
         Should Not Be Equal    ${employment_record_row_count}    1
         Sleep    2s
         click Element    //*[@id="main-content"]/div/div[2]/div/ul/li[3]
         Sleep    3s
         ${activeBenefitsRowElement}     Get WebElements    //*[@id="page_38"]/div[1]/div/table/tbody/tr
         ${activeBenefitsRowCount}    Get Length    ${activeBenefitsRowElement}
          # Should Be Equal As Numbers    ${activeBenefitsRowCount}    2
          # Log To Console  -------------- Benefit Begin----->${Benefit Begin.replace("-", "/")}
          # Log To Console  -------------- Benefit End----- ${Benefit End.replace("-", "/")}
        Sleep    4s
        Table Cell Should Contain    //*[@id="page_38"]/div[1]/div/table    2    2    ${Plan Description}
        Table Cell Should Contain    //*[@id="page_38"]/div[1]/div/table    2    4    ${Benefit Begin.replace("-", "/")}
        Table Cell Should Contain    //*[@id="page_38"]/div[1]/div/table    2    5     ${Benefit End.replace("-", "/")}
        click Element    //*[@id="main-content"]/div/div[2]/div/ul/li[1]/a
        Sleep    2s
        click Element    //*[@id="page_36"]/div[1]/div[1]/div[1]/a[1]
        Sleep    2s
        Textfield Value Should Be    //*[@id="hire_date"]     ${Employment Begin.replace("-", "/")}


     #    Sleep    128s
     END
     END
    Close Browsers
    Log To Console  --------------Employment Begin-----> ${Employment Begin.replace("-", "/")}
    
    
     
  
