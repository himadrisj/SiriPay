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
        
        if let emailID = emailID , emailID.characters.count > 0 {
            
            if let number = number , number.characters.count > 0 {
                nextButton.isEnabled = true
            }
            
        }
    }
    
    
    @IBAction func nextButtonTapped(_ sender: AnyObject) {
        
        UserDefaults.standard.set(emailTextField.text, forKey: kDefaults_UserName)
        UserDefaults.standard.set(numberTextField.text, forKey: kDefaults_MobileNumber)
        UserDefaults.standard.synchronize()
        
        SPPaymentController.sharedInstance.requestOTPForSignIn(email: emailTextField.text!,
                                                               mobileNo: numberTextField.text!) { (result, error) in
                                                                
                                                                if let _ = error {
                                                                    print("Error while signing in = \(error)")
                                                                    let alert = UIAlertController(title: "Wrong username or password", message:"Please try again", preferredStyle: UIAlertControllerStyle.alert)
                                                                    
                                                                    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
                                                                    
                                                                    alert.addAction(okAction)
                                                                    self.present(alert, animated: true, completion: nil)
                                                                    
                                                                    
                                                                } else {
                                                                    
                                                                    self.performSegue(withIdentifier: "OTPSegueIdentifier", sender: self)
                                                                    
                                                                }
                                                                
        }
        
    }
    
}

extension SPSignupViewController : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField.text?.characters.count == 9 {
            nextButton.isEnabled = true
        }
        
        return true
    }
    
}




