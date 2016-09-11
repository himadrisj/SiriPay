//
//  SPMainViewController.swift
//  SiriPay
//
//  Created by Jatin Arora on 10/09/16.
//  Copyright © 2016 PhonePe Internet Private Limited. All rights reserved.
//

import Foundation
import Intents

class SPMainViewController: UIViewController {
    
    @IBAction func sendButtonPressed(_ sender: AnyObject) {
        
        //Send money here
        
    }
    
    @IBAction func receiveButtonPressed(_ sender: AnyObject) {
        
        //Receive money here
        
    }
    
    override func viewDidLoad() {
        if(INPreferences.siriAuthorizationStatus() == .notDetermined) {
            INPreferences.requestSiriAuthorization() {
                status in
                print("Siri Auth Status is \(status)")
            }
        }
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: {
            timer in
            let defaults = UserDefaults(suiteName: "group.com.phonepe.ezpay")
            
            if let value = defaults?.object(forKey: payInfoUserDefaultsKey) as? [String: String] {
                if let phoneNo = value["phone"] {
                    if let amount = value["amount"] {
                        SPPaymentController.sharedInstance.sendPayment(to: phoneNo, amount: amount) {
                            transferMoneyRes, error in
                            print("Error is =\(error)")
                            print("Response is =\(transferMoneyRes)")
                        }
                        
                        defaults?.set(nil, forKey: payInfoUserDefaultsKey)
                        defaults?.synchronize()
                    }
                }
                
            }
            
        })
    }
    
}
