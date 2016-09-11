//
//  SPSignupViewController.swift
//  SiriPay
//
//  Created by Jatin Arora on 10/09/16.
//  Copyright © 2016 PhonePe Internet Private Limited. All rights reserved.
//

import Foundation


class SPSignupViewController : UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var nextButton: UIBarButtonItem!
    
    var emailID : String?
    var number : String?
    
    override func viewDidLoad() {
        let tapGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGestureRecogniser)
    }
    
    func viewTapped() {
        emailTextField.resignFirstResponder()
        numberTextField.resignFirstResponder()
        
        emailID = emailTextField.text
        number = numberTextField.text
        
        if let emailID = emailID where emailID.characters.count > 0 {
            
            if let number = number where number.characters.count > 0 {
                nextButton.enabled = true
            }
            
        }
    }
    
    
    @IBAction func nextButtonTapped(sender: AnyObject) {
        
        NSUserDefaults.standardUserDefaults().setObject(TEST_EMAIL, forKey: kDefaults_UserName)
        NSUserDefaults.standardUserDefaults().setObject(TEST_MOBILE, forKey: kDefaults_MobileNumber)
        NSUserDefaults.standardUserDefaults().synchronize()
        
        SPPaymentController.sharedInstance.requestOTPForSignIn(email: emailTextField.text!,
                                                               mobileNo: numberTextField.text!) { (result, error) in
                                                                
                                                                if let _ = error {
                                                                    print("Error while signing in = \(error)")
                                                                    let alert = UIAlertController(title: "Wrong username or password", message:"Please try again", preferredStyle: UIAlertControllerStyle.Alert)
                                                                    
                                                                    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil)
                                                                    
                                                                    alert.addAction(okAction)
                                                                    self.presentViewController(alert, animated: true, completion: nil)
                                                                    
                                                                    
                                                                } else {
                                                                    
                                                                    self.performSegueWithIdentifier("OTPSegueIdentifier", sender: result.userMessage)
                                                                    
                                                                }
                                                                
        }
        
    }
    
}

extension SPSignupViewController : UITextFieldDelegate {
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if textField.text?.characters.count == 9 {
            nextButton.enabled = true
        }
        
        return true
    }
    
}




