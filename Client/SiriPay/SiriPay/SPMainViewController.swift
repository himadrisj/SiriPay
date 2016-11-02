//
//  SPMainViewController.swift
//  SiriPay
//
//  Created by Jatin Arora on 10/09/16.
//  Copyright
//

import Foundation
import Intents
import Contacts

class SPMainViewController: UIViewController {
    
    @IBAction func sendButtonPressed(_ sender: AnyObject) {
        
        //Send money here
        
    }
    
    @IBAction func receiveButtonPressed(_ sender: AnyObject) {
        
        //Receive money here
        
    }
    
    override func viewDidLoad() {
        INPreferences.requestSiriAuthorization() {
            status in
            print("Siri Auth Status is \(status)")
        }
        
        syncContacts()
        
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true, block: {
            timer in
            print("Timer running")
            let defaults = UserDefaults(suiteName: "group.com.example.ezpay")
            
            if let value = defaults?.object(forKey: payInfoUserDefaultsKey) as? [String: String] {
                if let phoneNo = value["phone"] {
                    if let amount = value["amount"] {
                        if let amountString = String(amount) {
                            SPPaymentController.sharedInstance.sendPayment(to: phoneNo, amount: amountString) {
                                transferMoneyRes, error in
                                print("Error is =\(error)")
                                print("Response is =\(transferMoneyRes)")
                                defaults?.set(nil, forKey: payInfoUserDefaultsKey)
                                defaults?.synchronize()
                            }
                        
                        }                        
                    }
                }
                
            }
            
        })
    }
    
    
    
    func syncContacts() {
        let store = CNContactStore()
        //let keys: [CNKeyDescriptor] = [CNContactGivenNameKey, CNContactPhoneNumbersKey]
        let keysToFetch: [CNKeyDescriptor] = [CNContactPhoneNumbersKey as CNKeyDescriptor, CNContactGivenNameKey as CNKeyDescriptor]
        let request = CNContactFetchRequest(keysToFetch: keysToFetch)
        var contactsDict = [String: String]()
        
        do {
            try store.enumerateContacts(with: request) {
                contact, stop in
                print("Contact is \(contact)")
                
                let value = contact.phoneNumbers.first?.value.stringValue
                let phoneNo = value?.stringByRemovingWhitespaces
                contactsDict[contact.givenName.lowercased()] = phoneNo
            }
        } catch {
            print("Something went wrong!")
        }
        
        
        print(contactsDict)
        
        let defaults = UserDefaults(suiteName: "group.com.example.ezpay")
        defaults?.set(contactsDict, forKey: contactsSharedKey)
        defaults?.synchronize()
    }
    
}


extension String {
    
    var stringByRemovingWhitespaces: String {
        
        let components = self.components(separatedBy: .whitespaces)
        return components.joined(separator: "")
    }
}

