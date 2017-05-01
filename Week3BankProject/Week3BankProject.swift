//
//  Week3BankProject.swift
//  Week3BankProject
//
//  Created by Brent Fordham on 4/16/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation

class Bank {
    var address: String
    var employees: [Person]
    var accountsDirectory: [Customer : Set<Account>]
    
    init(address: String) {
        self.address = address
        self.employees = []
        self.accountsDirectory = [:]
    }
    
    func addEmployee(_ input: Person) {
        self.employees.append(input)
    }
    
    func addCustomer(_ newCustomer: Customer, firstAccount: Account) {
        var customerAccounts: Set<Account> = []
        customerAccounts.insert(firstAccount)
        accountsDirectory[newCustomer] = customerAccounts
    }
    
    func findCustomerAccounts(_ input: Customer) -> Set<Account>? {
        if let customerAccounts = accountsDirectory[input] {
            return customerAccounts
        } else {
            return nil
        }
    }
    
    func findCustomerBalance(_ input: Customer) -> Double? {
        var totalBalance: Double = 0
        if let listOfAccounts = findCustomerAccounts(input) {
            for element in listOfAccounts {
                totalBalance += element.accountBalance
            }
        }
        return totalBalance
    }
    func newAccountForCustomer(_ input: Customer, newAccount: Account) {
        if let _ = findCustomerAccounts(input) {
            accountsDirectory[input]?.insert(newAccount)
        }
    }
    func bankTotalFunds() -> Double {
        var totalFunds: Double = 0
        for (key, _) in accountsDirectory {
            if let customerBalance = findCustomerBalance(key) {
                totalFunds += customerBalance
            }
        }
        return totalFunds
    }
    func deposit(customer: Customer, accountID: UUID, transactionAmount: Double) {
        if let customerAccounts = findCustomerAccounts(customer) {
            for account in customerAccounts {
                if account.accountID == accountID {
                    account.deposit(transactionAmount)
                }
            }
        }
    }
    func withdraw(customer: Customer, accountID: UUID, transactionAmount: Double) {
        if let customerAccounts = findCustomerAccounts(customer) {
            for account in customerAccounts {
                if account.accountID == accountID {
                    account.withdraw(transactionAmount)
                }
            }
        }
    }
}

enum AccountType {
    case checking
    case savings
}

class Account : Hashable {
    var accountBalance: Double
    var type: AccountType
    var accountID: UUID
    
    var hashValue: Int {
        return accountID.hashValue &+ type.hashValue
    }
    
    public static func == (lhs: Account, rhs: Account) -> Bool {
        return lhs.accountBalance == rhs.accountBalance && lhs.type == rhs.type && lhs.accountID == rhs.accountID
    }

    
    init(type: AccountType) {
        self.accountBalance = 0.0
        self.type = type
        self.accountID = UUID()
    }
    
    func checkBalance() -> Double {
        return self.accountBalance
    }
    
    func deposit(_ amount: Double) {
        accountBalance += amount
    }
    
    func withdraw(_ amount: Double) {
        accountBalance -= amount
    }
    
}

class CheckingAccount: Account {
    
    init() {
        super.init(type: .checking)
    }
    
}

class SavingsAccount: Account {
    
    init() {
        super.init(type: .savings)
    }
    
}

class Person : Hashable {
    var firstName: String
    var lastName: String
    var fullName: String {
        return firstName + " " + lastName
    }
    
    var hashValue: Int {
        return firstName.hashValue &+ lastName.hashValue
    }
    
    public static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName && lhs.fullName == rhs.fullName
    }
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

class Customer: Person {
    var emailAddress: String
    init(firstName: String, lastName: String, emailAddress: String) {
        self.emailAddress = emailAddress
        super.init(firstName: firstName, lastName: lastName)
    }
}

