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
    var otpString: String?
    
    @IBAction func nextButtonTapped(sender: AnyObject) {
        
        SPPaymentController.sharedInstance.doSignIn(otp: otpString!) { (error) in
            
            if error == nil {
                self.performSegueWithIdentifier("SiriPaySegueIdentifier", sender: nil)
            } else {
                print("Wrong OTP with error = \(error)")
                
                let alert = UIAlertController(title: "Wrong OTP", message:"Please try again", preferredStyle: UIAlertControllerStyle.Alert)
                
                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil)
                
                alert.addAction(okAction)
                self.presentViewController(alert, animated: true, completion: nil)
            }
            
        }
        
    }
}

extension SPOTPViewController : UITextFieldDelegate {
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if textField.text?.characters.count == 3 {
            nextButton.enabled = true
        }
        
        return true
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let otp = sender as! String
        otpString = otp
    }
}
