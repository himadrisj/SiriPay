//
//  SPOTPViewController.swift
//  SiriPay
//
//  Created by Jatin Arora on 10/09/16.
//  Copyright © 2016 PhonePe Internet Private Limited. All rights reserved.
//

import Foundation

class SPOTPViewController : UIViewController {
    
    
    @IBOutlet weak var nextButton: UIBarButtonItem!
    
    
}

extension SPOTPViewController : UITextFieldDelegate {
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if textField.text?.characters.count == 3 {
            nextButton.enabled = true
        }
        
        return true
        
    }
    
}
