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
        CitrusPaymentSDK.initializeWithKeyStore(keyStore, environment: CTSEnvProduction)
        
        //        #if PRODUCTION_MODE
        //            CitrusPaymentSDK.initializeWithKeyStore(keyStore, environment: CTSEnvProduction)
        //            #else
        //            CitrusPaymentSDK.initializeWithKeyStore(keyStore, environment: CTSEnvSandbox)
        //        #endif
        
        
        CitrusPaymentSDK.enableDEBUGLogs()
        
        CitrusPaymentSDK.enableLoader()
        
        CitrusPaymentSDK.setLoaderColor(UIColor .orangeColor())
        
        self.authLayer = CTSAuthLayer.fetchSharedAuthLayer()
        self.profileLayer = CTSProfileLayer.fetchSharedProfileLayer()
        self.paymentLayer = CTSPaymentLayer.fetchSharedPaymentLayer()
        
        
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
        
        customParams = ["USERDATA2":"MOB_RC|9988776655",
                        "USERDATA10":"test",
                        "USERDATA4":"MOB_RC|test@gmail.com",
                        "USERDATA3":"MOB_RC|4111XXXXXXXX1111"]
        
    }
    
    
    func requestOTPForSignIn(email emailString: String, mobileNo mobileNoString: String, completionHandler:ASMasterLinkCallback)  {
        self.authLayer?.requestMasterLink(emailString,
                                          mobile: mobileNoString,
                                          scope:CTSWalletScopeFull,
                                          completionHandler: completionHandler)
    }
    
    func doSignIn(otp otpString: String, completionHandler: ASCitrusSigninCallBack) {
        self.authLayer?.requestMasterLinkSignInWithPassword(otpString, passwordType: PasswordTypeOtp, completionHandler: completionHandler)
    }

}
