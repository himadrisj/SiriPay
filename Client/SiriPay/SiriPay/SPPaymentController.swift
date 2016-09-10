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

}
