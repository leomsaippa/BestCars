//
//  LoginViewController.swift
//  BestCars
//
//  Created by Leonardo Saippa on 24/04/21.
//

import Foundation
import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var checkBoxOutlet:UIButton!{
            didSet{
                checkBoxOutlet.setImage(UIImage(named:"unchecked"), for: .normal)
                checkBoxOutlet.setImage(UIImage(named:"checked"), for: .selected)
            }
        }
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var switchConnected: UISwitch!
    let signUpUrl = UdacityApiCall.Endpoints.udacitySignUp.url
    
    @IBOutlet weak var stackViewHorizontal: UIStackView!
    
    var emailFieldIsEmpty = true
    var passwordFieldIsEmpty = true
    
    @IBAction func signUpBtnClicked(_ sender: Any) {
        setIndicator(true)
        UIApplication.shared.open(signUpUrl, options: [:], completionHandler: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.text = ""
        passwordField.text = ""
        emailField.delegate = self
        passwordField.delegate = self
        isToEnableButton(false, button: loginButton)
        self.hideKeyboardWhenTappedAround()
        
        switchConnected.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        
        let defaults = UserDefaults.standard
        
        let email = defaults.string(forKey: "email")
        let password = defaults.string(forKey: "password")
        let isEmpty = email?.isEmpty ?? true
        print("email \(email) pass \(password) isEmpty \(isEmpty)")
        if(!isEmpty){
            showAlert(message: "Logging, please wait", title: "Logging")
            setIndicator(true)
            UdacityApiCall.login(email: email ?? "", password: password ?? "", completion: handleLoginResponse(success:error:))
        }

    }


    override func viewWillAppear(_ animated: Bool) {
        emailField.text = ""
        passwordField.text = ""
    }
    
    @IBAction func checkBox(_ sender: UIButton) {
        
        sender.checkboxAnimation {
               print("I'm done")
               //here you can also track the Checked, UnChecked state with sender.isSelected
               print(sender.isSelected)
               
           }
    }
    @IBAction func onLoginBtnClicked(_ sender: Any) {
        setIndicator(true)
        UdacityApiCall.login(email: self.emailField.text ?? "", password: self.passwordField.text ?? "", completion: handleLoginResponse(success:error:))
    }
    
    @IBAction func onSwitchChanger(_ sender: Any) {
        print(switchConnected.isOn)
    }
    func handleLoginResponse(success: Bool, error: Error?) {
        setIndicator(false)
        if success {
            DispatchQueue.main.async {
                print("SUCCESS")
                if(self.switchConnected.isOn){
                    let defaults = UserDefaults.standard
                    defaults.set(self.emailField.text, forKey: "email")
                    
                    defaults.set(self.passwordField.text, forKey: "password")
                }
               self.performSegue(withIdentifier: "loginClick", sender: nil)
                
            }
        } else {
            DispatchQueue.main.async {

                self.setIndicator(false)
                self.showAlert(message: "Something went wrong", title: "Login Error")

            }
        }
    }
    
    func setIndicator(_ isToShowIndicator: Bool) {
        if isToShowIndicator {
            DispatchQueue.main.async {
                self.indicatorView.startAnimating()
                self.isToEnableButton(false, button: self.loginButton)
            }
        } else {
            DispatchQueue.main.async {
                self.indicatorView.stopAnimating()
                self.isToEnableButton(true, button: self.loginButton)
            }
        }
        DispatchQueue.main.async {
            self.emailField.isEnabled = !isToShowIndicator
            self.passwordField.isEnabled = !isToShowIndicator
            self.loginButton.isEnabled = !isToShowIndicator
            self.signUpButton.isEnabled = !isToShowIndicator
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == emailField {
            let currenText = emailField.text ?? ""
            guard let stringRange = Range(range, in: currenText) else { return false }
            let updatedText = currenText.replacingCharacters(in: stringRange, with: string)
            
            if updatedText.isEmpty && updatedText == "" {
                emailFieldIsEmpty = true
            } else {
                emailFieldIsEmpty = false
            }
        }
        
        if textField == passwordField {
            let currenText = passwordField.text ?? ""
            guard let stringRange = Range(range, in: currenText) else { return false }
            let updatedText = currenText.replacingCharacters(in: stringRange, with: string)
            
            if updatedText.isEmpty && updatedText == "" {
                passwordFieldIsEmpty = true
            } else {
                passwordFieldIsEmpty = false
            }
        }
        
        if emailFieldIsEmpty == false && passwordFieldIsEmpty == false {
            isToEnableButton(true, button: loginButton)
        } else {
            isToEnableButton(false, button: loginButton)
        }
        
        return true
        
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        isToEnableButton(false, button: loginButton)
        if textField == emailField {
            emailFieldIsEmpty = true
        }
        if textField == passwordField {
            passwordFieldIsEmpty = true
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            onLoginBtnClicked(loginButton)
        }
        return true
    }
}

extension UIViewController {

    
    func openLinkClicked(_ url: String) {
        guard let url = URL(string: url), UIApplication.shared.canOpenURL(url) else {
            showAlert(message: "Can`t open current link.", title: "Invalid Link")
            return
        }
        UIApplication.shared.open(url, options: [:])
    }
    
    func showAlert(message: String, title: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true)
    }
    
    func isToEnableButton(_ enabled: Bool, button: UIButton) {
        if enabled {
            button.isEnabled = true
            button.alpha = 1.0
        } else {
            button.isEnabled = false
            button.alpha = 0.5
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }

}

extension UIButton {
    //MARK:- Animate check mark
    func checkboxAnimation(closure: @escaping () -> Void){
        guard let image = self.imageView else {return}
        
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
            image.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            
        }) { (success) in
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
                self.isSelected = !self.isSelected
                //to-do
                closure()
                image.transform = .identity
            }, completion: nil)
        }
        
    }
}
