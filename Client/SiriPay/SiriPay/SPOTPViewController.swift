//
//  SPOTPViewController.swift
//  SiriPay
//
//  Created by Jatin Arora on 10/09/16.
//  Copyright 
//

import Foundation

class SPOTPViewController : UIViewController {
    
    
    @IBOutlet weak var nextButton: UIBarButtonItem!
    var otpString: String?
    
    @IBOutlet weak var otpField: UITextField!
    
    override func viewDidLoad() {
        if (!UserDefaults.standard.bool(forKey: kDefaults_SignedIn)) {
            SPPaymentController.sharedInstance.requestOTPForSignIn(email: TEST_EMAIL,
                                                               mobileNo: TEST_MOBILE) { (result, error) in
                                                                
            }
        }

        
    }
    
    @IBAction func nextButtonTapped(_ sender: AnyObject) {
        
        SPPaymentController.sharedInstance.doSignIn(otp: otpField.text!) { (error) in
            
            if error == nil {
                
                UserDefaults.standard.set(true, forKey: kDefaults_SignedIn)
                UserDefaults.standard.synchronize()
                
                self.performSegue(withIdentifier: "SiriPaySegueIdentifier", sender: nil)
                
            } else {
                CTSOauthManager.readPasswordSigninOuthData();
                
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
    
}
