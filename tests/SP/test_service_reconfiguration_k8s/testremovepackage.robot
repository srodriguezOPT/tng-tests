*** Settings ***
Documentation     Test suite template for deploy and undeploy of a NS composed of one cnf with elasticity policy enforcement
Library           tnglib
Library           Collections

*** Variables ***
${SP_HOST}                http://pre-int-sp-ath.5gtango.eu   #  the name of SP we want to use
${READY}       READY
${FILE_SOURCE_DIR}     ../../../packages   # to be modified and added accordingly if package is not on the same folder as test
${NS_PACKAGE_NAME}           eu.5gtango.ns-mediapilot-service.0.5.tgo    # The package to be uploaded and tested
${NS_PACKAGE_SHORT_NAME}  ns-mediapilot-service
${POLICIES_SOURCE_DIR}     ./policies   # to be modified and added accordingly if policy is not on the same folder as test
${POLICY_NAME}           ns-mediapilot-service-sample-policy.json    # The policy to be uploaded and tested
${READY}       READY
${PASSED}      PASSED
${PACKAGE_UUID}   eb08391e-f474-42ad-afd2-7280647a65d9

*** Test Cases ***
Setting the SP Path
    Set SP Path     ${SP_HOST}
    ${result} =     Sp Health Check
    Should Be True   ${result}
Remove the Package
    ${result} =     Remove Package      ${PACKAGE_UUID}
    Should Be True     ${result[0]} 
    

*** Keywords ***
Check Status
    ${status} =     Get Request     ${REQUEST}
    Should Be Equal    ${READY}  ${status[1]['status']}
Set SIU
    ${status} =     Get Request     ${REQUEST}
    Set Suite Variable     ${TERMINATE}    ${status[1]['instance_uuid']}
Check Terminate
    ${status} =     Get Request     ${TERM_REQ}
    Should Be Equal    ${READY}  ${status[1]['status']}
