//
//  ValidatorTest.swift
//  BettaBankTests
//
//  Created by Дмитрий Пономарев on 15.01.2024.
//

import XCTest
@testable import BettaBank

final class ValidatorTests: XCTestCase {

    func test_isOldPasswordValid_PasswordValid_ReturnTrue() throws {
//       given
        let oldPassword = "1234"
//        then
        XCTAssertTrue(Validator.isOldPasswordValid(for: oldPassword))
    }
    
    func test_isOldPasswordValid_PasswordContainsThreeSymbols_ReturnFalse() throws {
//       given
        let oldPassword = "234"
//        then
        XCTAssertFalse(Validator.isOldPasswordValid(for: oldPassword))
    }
    
    func test_isValidAppPasswordLength_PasswordValid_ReturnTrue() throws {
//       given
        let appPassword = "1234"
//        then
        XCTAssertTrue(Validator.isValidAppPasswordLength(for: appPassword))
    }
    
    func test_isValidAppPasswordLength_PasswordLengthMoreThenFour_ReturnFalse() throws {
//       given
        let appPassword = "12345"
//        then
        XCTAssertFalse(Validator.isValidAppPasswordLength(for: appPassword))
    }
    
    func test_isValidAppPasswordLength_PasswordLengthLessThenFour_ReturnFalse() throws {
//       given
        let appPassword = "123"
//        then
        XCTAssertFalse(Validator.isValidAppPasswordLength(for: appPassword))
    }
    
    func test_isValidPasswordLength_PasswordValid_ReturnTrue() throws {
//       given
        let password = "123456789"
//        then
        XCTAssertTrue(Validator.isValidPasswordLength(for: password))
    }
    
    func test_isValidPasswordLength_PasswordLengthMoreThenTwenty_ReturnFalse() throws {
//       given
        let password = "123456789101112131141516"
//        then
        XCTAssertFalse(Validator.isValidPasswordLength(for: password))
    }
    
    func test_isValidPasswordLength_PasswordLengthLessThenSix_ReturnFalse() throws {
//       given
        let password = "12345"
//        then
        XCTAssertFalse(Validator.isValidPasswordLength(for: password))
    }
    
    func test_isValidPasswordLowercaseUppercase_PasswordValid_ReturnTrue() throws {
//       given
        let password = "aA"
//        then
        XCTAssertTrue(Validator.isValidPasswordLowercaseUppercase(for: password))
    }
    
    func test_isValidPasswordLowercaseUppercase_ContainsOnlyUppercase_ReturnFlase() throws {
//       given
        let password = "AA"
//        then
        XCTAssertFalse(Validator.isValidPasswordLowercaseUppercase(for: password))
    }
    
    func test_isValidPasswordLowercaseUppercase_ContainsOnlyLowercase_ReturnFlase() throws {
//       given
        let password = "aa"
//        then
        XCTAssertFalse(Validator.isValidPasswordLowercaseUppercase(for: password))
    }
    
    func test_isValidPasswordNumbers_ContainsAtLeastOneNumber_ReturnTrue() throws {
//       given
        let password = "1ab"
//        then
        XCTAssertTrue(Validator.isValidPasswordNumbers(for: password))
    }
    
    func test_isValidPasswordNumbers_NotContainsAtLeastOneNumber_ReturnFalse() throws {
//       given
        let password = "abc*"
//        then
        XCTAssertFalse(Validator.isValidPasswordNumbers(for: password))
    }
    
    func test_isValidPasswordNumbers_ContainsAtLeastOneSymbol_ReturnTrue() throws {
//       given
        let password = "1*"
//        then
        XCTAssertTrue(Validator.isValidPasswordSpecialCharacters(for: password))
    }
    
    func test_isValidPasswordNumbers_NotContainsAtLeastOneSymbol_ReturnFalse() throws {
//       given
        let password = "a123"
//        then
        XCTAssertFalse(Validator.isValidPasswordSpecialCharacters(for: password))
    }
    
    func test_isValidEmail_EmailValid_ReturnTrue() throws {
//       given
        let email = "some@gmail.com"
//        then
        XCTAssertTrue(Validator.isValidEmail(email))
    }
    
    func test_isValidEmail_EmailInvalid_ReturnFalse() throws {
//       given
        let email = "some@gmail"
//        then
        XCTAssertFalse(Validator.isValidEmail(email))
    }
}
