//
//  Week3BankProjectTests.swift
//  Week3BankProjectTests
//
//  Created by Brent Fordham on 4/16/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import XCTest
@testable import Week3BankProject

class Week3BankProjectTests: XCTestCase {
    
    func testPersonInit() {
        let newPerson: Person = Person(firstName: "Jim", lastName: "Holden")
        let result = newPerson.fullName
        let expected = "Jim Holden"
        XCTAssertEqual(result, expected)
    }
    
    func testCustomerInit1() {
        let newCustomer = Customer(firstName: "Naomi", lastName: "Nagata", emailAddress: "nnagata@roci.com")
        let result = newCustomer.fullName
        let expected = "Naomi Nagata"
        XCTAssertEqual(result, expected)
    }
    
    func testCheckBalanceMethod() {
        let newAccount = SavingsAccount()
        let result = newAccount.checkBalance()
        let expected: Double = 0.0
        XCTAssertEqual(result, expected)
    }
    
    func testBankNewEmployeeMethod() {
        let newBank = Bank(address: "123 Fourth Avenue, New York, NY")
        let newEmployee = Person(firstName: "Bobbie", lastName: "Draper")
        newBank.addEmployee(newEmployee)
        
        let result = newBank.employees
        let expected = [newEmployee]
        XCTAssertEqual(result, expected)
    }
    
    func testAddCustomer() {
        let newCustomer = Customer(firstName: "Naomi", lastName: "Nagata", emailAddress: "nnagata@roci.com")
        let newBank = Bank(address: "123 Fourth Avenue, New York, NY")
        let newAccount = SavingsAccount()
        
        newBank.addCustomer(newCustomer, firstAccount: newAccount)
        let result = newBank.accountsDirectory
        let expected: [Customer: Set<Account>] = [newCustomer: [newAccount]]
        XCTAssertEqual(result, expected)
    }
    
    func testFindCustomerAccounts() {
        let newCustomer = Customer(firstName: "Naomi", lastName: "Nagata", emailAddress: "nnagata@roci.com")
        let newBank = Bank(address: "123 Fourth Avenue, New York, NY")
        let newAccount = SavingsAccount()
        
        newBank.addCustomer(newCustomer, firstAccount: newAccount)
        let result = newBank.findCustomerAccounts(newCustomer)
        let expected: Set<Account> = [newAccount]
        XCTAssertEqual(result, expected)
    }
    
    func testFindCustomerBalance() {
        let newCustomer = Customer(firstName: "Naomi", lastName: "Nagata", emailAddress: "nnagata@roci.com")
        let newBank = Bank(address: "123 Fourth Avenue, New York, NY")
        let newAccount = SavingsAccount()
        newAccount.deposit(200)
        
        newBank.addCustomer(newCustomer, firstAccount: newAccount)
        let result = newBank.findCustomerBalance(newCustomer)
        let expected: Double = 200
        XCTAssertEqual(result, expected)
    }
    
    func testNewAccountForCustomer() {
        let newCustomer = Customer(firstName: "Naomi", lastName: "Nagata", emailAddress: "nnagata@roci.com")
        let newBank = Bank(address: "123 Fourth Avenue, New York, NY")
        let newAccount = SavingsAccount()
        newAccount.deposit(200)
        
        newBank.addCustomer(newCustomer, firstAccount: newAccount)
        
        let newNewAccount = CheckingAccount()
        newNewAccount.deposit(55)
        
        newBank.newAccountForCustomer(newCustomer, newAccount: newNewAccount)
        
        let result = newBank.findCustomerAccounts(newCustomer)
        let expected: Set<Account> = [newAccount, newNewAccount]
        XCTAssertEqual(result, expected)
    }
    func testBankTotalFunds() {
        let newCustomer = Customer(firstName: "Naomi", lastName: "Nagata", emailAddress: "nnagata@roci.com")
        let newBank = Bank(address: "123 Fourth Avenue, New York, NY")
        let newAccount = SavingsAccount()
        newAccount.deposit(200)
        
        newBank.addCustomer(newCustomer, firstAccount: newAccount)
        
        let newNewAccount = CheckingAccount()
        newNewAccount.deposit(55)
        
        newBank.newAccountForCustomer(newCustomer, newAccount: newNewAccount)
        
        let newNewCustomer = Customer(firstName: "Jim", lastName: "Holden", emailAddress: "jholden@roci.com")
        let newCustomerNewAccount = SavingsAccount()
        newCustomerNewAccount.deposit(400)
        
        newBank.addCustomer(newNewCustomer, firstAccount: newCustomerNewAccount)
        
        let result = newBank.bankTotalFunds()
        let expected: Double = 655
        XCTAssertEqual(result, expected)
    }
    
    func testWithdraw() {
        let newCustomer = Customer(firstName: "Naomi", lastName: "Nagata", emailAddress: "nnagata@roci.com")
        let newBank = Bank(address: "123 Fourth Avenue, New York, NY")
        let newAccount = SavingsAccount()
        newAccount.deposit(500)
        
        newBank.addCustomer(newCustomer, firstAccount: newAccount)
        newBank.withdraw(customer: newCustomer, accountID: newAccount.accountID, transactionAmount: 100)
        
        let result = newBank.findCustomerBalance(newCustomer)
        let expected: Double = 400
        XCTAssertEqual(result, expected)
    }
    
    func testDeposit() {
        let newCustomer = Customer(firstName: "Naomi", lastName: "Nagata", emailAddress: "nnagata@roci.com")
        let newBank = Bank(address: "123 Fourth Avenue, New York, NY")
        let newAccount = SavingsAccount()
        newAccount.deposit(500)
        
        newBank.addCustomer(newCustomer, firstAccount: newAccount)
        newBank.deposit(customer: newCustomer, accountID: newAccount.accountID, transactionAmount: 100)
        
        let result = newBank.findCustomerBalance(newCustomer)
        let expected: Double = 600
        XCTAssertEqual(result, expected)
    }
    
}
