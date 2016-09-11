//
//  SPPaymentController.swift
//  SiriPay
//
//  Created by Himadri Sekhar Jyoti on 10/09/16.
//  Copyright © 2016 PhonePe Internet Private Limited. All rights reserved.
//

import Foundation

class SPPaymentController {
    var authLayer : CTSAuthLayer?
    var profileLayer : CTSProfileLayer?
    var paymentLayer : CTSPaymentLayer?
    
    var contactInfo : CTSContactUpdate?
    var addressInfo : CTSUserAddress?
    var customParams: [String : AnyObject] = [:]
    
    static let sharedInstance: SPPaymentController = SPPaymentController()
    
    
    func initializeSDK() -> Void {
        
        let keyStore : CTSKeyStore = CTSKeyStore()
        keyStore.signinId = SignInId
        keyStore.signinSecret = SignInSecretKey
        keyStore.signUpId = SubscriptionId
        keyStore.signUpSecret = SubscriptionSecretKey
        keyStore.vanity = VanityUrl
        CitrusPaymentSDK.initialize(with: keyStore, environment: CTSEnvProduction)
        
        //        #if PRODUCTION_MODE
        //            CitrusPaymentSDK.initializeWithKeyStore(keyStore, environment: CTSEnvProduction)
        //            #else
        //            CitrusPaymentSDK.initializeWithKeyStore(keyStore, environment: CTSEnvSandbox)
        //        #endif
        
        
        CitrusPaymentSDK.enableDEBUGLogs()
        
        CitrusPaymentSDK.enableLoader()
        
        CitrusPaymentSDK.setLoaderColor(UIColor.orange)
        
        self.authLayer = CTSAuthLayer.fetchShared()
        self.profileLayer = CTSProfileLayer.fetchShared()
        self.paymentLayer = CTSPaymentLayer.fetchShared()
        
        
        contactInfo?.firstName = TEST_FIRST_NAME;
        contactInfo?.lastName = TEST_LAST_NAME;
        contactInfo?.email = TEST_EMAIL;
        contactInfo?.mobile = TEST_MOBILE;
        
        addressInfo?.city = TEST_CITY;
        addressInfo?.country = TEST_COUNTRY;
        addressInfo?.state = TEST_STATE;
        addressInfo?.street1 = TEST_STREET1;
        addressInfo?.street2 = TEST_STREET2;
        addressInfo?.zip = TEST_ZIP;
        
        customParams = ["USERDATA2":"MOB_RC|9988776655" as AnyObject,
                        "USERDATA10":"test" as AnyObject,
                        "USERDATA4":"MOB_RC|test@gmail.com" as AnyObject,
                        "USERDATA3":"MOB_RC|4111XXXXXXXX1111" as AnyObject]
        
    }
    
    
    func requestOTPForSignIn(email emailString: String, mobileNo mobileNoString: String, completionHandler:@escaping ASMasterLinkCallback)  {
        self.authLayer?.requestMasterLink(emailString,
                                          mobile: mobileNoString,
                                          scope:CTSWalletScopeFull,
                                          completionHandler: completionHandler)
    }
    
    func doSignIn(otp otpString: String, completionHandler : @escaping ASCitrusSigninCallBack) {
        self.authLayer?.requestMasterLinkSignIn(withPassword: otpString, passwordType: PasswordTypeOtp, completionHandler: completionHandler)
    }
    
    func sendPayment(to phoneNo: String, amount: String, message: String = "Enjoy!", completionHandler:@escaping ASMoneyTransferCallback) {
        self.paymentLayer?.requestTransferMoney(to: phoneNo, amount: amount, message: message, completionHandler: completionHandler)
    }

}
