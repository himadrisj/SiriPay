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
    
    @IBAction func nextButtonTapped(_ sender: AnyObject) {
        
        SPPaymentController.sharedInstance.doSignIn(otp: otpString!) { (error) in
            
            if error == nil {
                self.performSegue(withIdentifier: "SiriPaySegueIdentifier", sender: nil)
            } else {
                print("Wrong OTP with error = \(error)")
                
                let alert = UIAlertController(title: "Wrong OTP", message:"Please try again", preferredStyle: UIAlertControllerStyle.alert)
                
                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
                
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
            
        }
        
    }
}

extension SPOTPViewController : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField.text?.characters.count == 3 {
            nextButton.isEnabled = true
        }
        
        return true
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let otp = sender as! String
        otpString = otp
    }
}
