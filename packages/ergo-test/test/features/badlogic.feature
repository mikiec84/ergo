Feature: Bad logic
  This describe the expected behavior for Ergo compiler when there is a parse error.

  Background:
    Given the Ergo contract "org.accordproject.helloworld.HelloWorld" in file "examples/bad-logic/logic.ergo"
    And the model in file "examples/bad-logic/model.cto"
    And the contract data
"""
{
  "$class": "org.accordproject.helloworld.TemplateModel",
  "name": "Fred Blogs"
}
"""

  Scenario: The contract should fail executing when an import is missing
    When it receives the request
"""
{
    "$class": "org.accordproject.helloworld.Request",
    "input": "Accord Project"
}
"""
    Then it should fail with the error
"""
Parse error (at file examples/bad-logic/logic.ergo line 17 col 20). 
contract HelloWorld ovr TemplateModel {
                    ^^^                
"""

