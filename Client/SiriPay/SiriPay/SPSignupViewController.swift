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
        
        NSUserDefaults.standardUserDefaults().setObject(emailTextField.text, forKey: kDefaults_UserName)
        NSUserDefaults.standardUserDefaults().setObject(emailTextField.text, forKey: kDefaults_MobileNumber)
        NSUserDefaults.standardUserDefaults().synchronize()
        
    }
    
    
}
