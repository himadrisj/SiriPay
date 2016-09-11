//
//  IntentHandler.swift
//  ezPay-SiriIntent
//
//  Created by Himadri Sekhar Jyoti on 11/09/16.
//  Copyright © 2016 PhonePe Internet Private Limited. All rights reserved.
//

import Intents

// As an example, this class is set up to handle Message intents.
// You will want to replace this or add other intents as appropriate.
// The intents you wish to handle must be declared in the extension's Info.plist.

// You can test your example integration by saying things to Siri like:
// "Send a message using <myApp>"
// "<myApp> John saying hello"
// "Search for messages in <myApp>"

class IntentHandler: INExtension, INSendPaymentIntentHandling {
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
        
    }
    
    
    /*!
     @brief handling method
     
     @abstract Execute the task represented by the INSendPaymentIntent that's passed in
     @discussion This method is called to actually execute the intent. The app must return a response for this intent.
     
     @param  sendPaymentIntent The input intent
     @param  completion The response handling block takes a INSendPaymentIntentResponse containing the details of the result of having executed the intent
     
     @see  INSendPaymentIntentResponse
     */
    public func handle(sendPayment intent: INSendPaymentIntent, completion: @escaping (INSendPaymentIntentResponse) -> Swift.Void) {
        // Implement your application logic for payment here.
        var phoneNo = "9742048795"
        if(intent.payee?.displayName.caseInsensitiveCompare("Jatin") == .orderedSame) {
            phoneNo = "9711165687"
        }
        
        let userActivity = NSUserActivity(activityType: NSStringFromClass(INSendPaymentIntent.self))
        var response = INSendPaymentIntentResponse(code: .failure, userActivity: userActivity)
        
        if let intAmount = intent.currencyAmount?.amount?.intValue {
            var payInfo = [String:String]()
            payInfo["phone"] = phoneNo
            payInfo["amount"] = String(intAmount)
            
//            let defaults = UserDefaults(suiteName: "group.com.phonepe.ezpay")
//            defaults?.set(payInfo, forKey: payInfoUserDefaultsKey)
//            defaults?.synchronize()
            
            response = INSendPaymentIntentResponse(code: .success, userActivity: userActivity)
            
        }
        
        completion(response)
        
    }
    
    
    
    /*!
     @brief Confirmation method
     @abstract Validate that this intent is ready for the next step (i.e. handling)
     @discussion These methods are called prior to asking the app to handle the intent. The app should return a response object that contains additional information about the intent, which may be relevant for the system to show the user prior to handling. If unimplemented, the system will assume the intent is valid following resolution, and will assume there is no additional information relevant to this intent.
     
     @param  sendPaymentIntent The input intent
     @param  completion The response block contains an INSendPaymentIntentResponse containing additional details about the intent that may be relevant for the system to show the user prior to handling.
     
     @see INSendPaymentIntentResponse
     
     */
    public func confirm(sendPayment intent: INSendPaymentIntent, completion: @escaping (INSendPaymentIntentResponse) -> Swift.Void) {
        let response = INSendPaymentIntentResponse(code: .success, userActivity: nil)
        response.paymentRecord = self.makePaymentRecord(for: intent)
        completion(response)
    }
    
    
    func makePaymentRecord(for intent: INSendPaymentIntent, status: INPaymentStatus = .completed) -> INPaymentRecord? {
        let paymentMethod = INPaymentMethod(type: .unknown, name: "SimplePay", identificationHint: nil, icon: nil)
        
        let localCurrencyAmmount = INCurrencyAmount(amount: (intent.currencyAmount?.amount)!, currencyCode: "INR")
        return INPaymentRecord(
            payee: intent.payee,
            payer: nil,
            currencyAmount: localCurrencyAmmount,
            paymentMethod: paymentMethod,
            note: intent.note,
            status: status
        )
    }
    
    
    
    /*!
     @brief Resolution methods
     @abstract Determine if this intent is ready for the next step (confirmation)
     @discussion These methods are called to make sure the app extension is capable of handling this intent in its current form. This method is for validating if the intent needs any further fleshing out.
     
     @param  sendPaymentIntent The input intent
     @param  completion The response block contains an INIntentResolutionResult for the parameter being resolved
     
     @see INIntentResolutionResult
     
     */
    public func resolvePayee(forSendPayment intent: INSendPaymentIntent, with completion: @escaping (INPersonResolutionResult) -> Swift.Void) {
        guard let payee = intent.payee else {
            completion(INPersonResolutionResult.needsValue())
            return
        }
        
//        if let type = payee.personHandle?.type {
//            if(type == .phoneNumber) {
//                completion(INPersonResolutionResult.success(with: payee))
//                return
//            }
//        }
        
        if (payee.displayName.caseInsensitiveCompare("om") == .orderedSame ||  payee.displayName.caseInsensitiveCompare("jatin") == .orderedSame) {
            completion(INPersonResolutionResult.success(with: payee))
        }
        
        completion(INPersonResolutionResult.disambiguation(with: [payee]))
    }
    
    
    public func resolveCurrencyAmount(forSendPayment intent: INSendPaymentIntent, with completion: @escaping (INCurrencyAmountResolutionResult) -> Swift.Void) {
        guard let amount = intent.currencyAmount else {
            completion(INCurrencyAmountResolutionResult.needsValue())
            return
        }
        
        guard amount.amount != nil else {
            completion(INCurrencyAmountResolutionResult.needsValue())
            return
        }
        
        completion(INCurrencyAmountResolutionResult.success(with: amount))
    }
    
    
//    public func resolveNote(forSendPayment intent: INSendPaymentIntent, with completion: @escaping (INStringResolutionResult) -> Swift.Void) {
//        
//    }
//    
   
}

