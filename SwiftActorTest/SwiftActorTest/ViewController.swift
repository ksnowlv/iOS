//
//  ViewController.swift
//  SwiftActorTest
//
//  Created by ksnowlv on 2024/10/24.
//

import UIKit

actor BankAccount {
    private var balance: Double = 0.0

    func deposit(amount: Double) {
        balance += amount
    }

    func withdraw(amount: Double) -> Bool {
        if balance >= amount {
            balance -= amount
            return true
        } else {
            return false
        }
    }

    func getBalance() -> Double {
        return balance
    }
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.testActor()
    }
    
    func testActor()  {
        let account = BankAccount()

        Task {
            await account.deposit(amount: 100.0)
            let balance = await account.getBalance()
            print("Balance after deposit: \(balance)")
        }

        Task {
            let success = await account.withdraw(amount: 50.0)
            if success {
                let balance = await account.getBalance()
                print("Balance after withdrawal: \(balance)")
            } else {
                print("Insufficient funds")
            }
        }
    }


}

