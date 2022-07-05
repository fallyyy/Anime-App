//
//  SignInViewController.swift
//  CharactersList
//
//  Created by  dollyally on 29.06.2022.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textFieldNameId: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var buttonSignIn: UIButton!
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldNameId.delegate = self
        textFieldPassword.delegate = self
        buttonSignIn.layer.cornerRadius = 16
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldNameId.resignFirstResponder()
        textFieldPassword.resignFirstResponder()
        return true
    }
    
    func displayMessage(userMessage: String) -> Void {
        let alertController = UIAlertController(title: "Alert",
                                                message: userMessage,
                                                preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { [weak self] action in
            self?.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(OKAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func buttonSignInTapped(_ sender: Any) {
        guard let userName = textFieldNameId.text,
              let userPassword = textFieldPassword.text else {
            displayMessage(userMessage: "One of the required fields is missing")
            return
        }
        
        guard let myUrl = URL(string: "https://shikimori.one/api/animes") else {
            displayMessage(userMessage: "Wrong domain link")
            return
        }
        
        myActivityIndicator.startAnimating()
        
        var request = URLRequest(url: myUrl)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "conntent-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let requestBody = [
            "userName": userName,
            "userPassword": userPassword
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            displayMessage(userMessage: "Something went wrong")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.myActivityIndicator.stopAnimating()
                
                if error == nil {
                    self?.displayMessage(userMessage: "Could not sucsessfully perform this request. Please try again later")
                    print("error")
                    return
                }
                do {
                    let json = try JSONSerialization.jsonObject(with: data! , options: .mutableContainers) as?  NSDictionary
                    
                    if let parseJSON = json {
                        
                     let accessToken = parseJSON ["token"] as? String
                     let userId = parseJSON ["id"] as? String
                        print("Accsess token: \(String(describing: accessToken))")
                    
                        if (accessToken?.isEmpty) != nil {
                            self?.displayMessage(userMessage: "Could not sucsessfully perform this request. Please try again later")
                            return
                         
                        }
                        
                        DispatchQueue.main.async {
                            let homePage = self?.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as? ViewController
                            let appDelegate = UIApplication.shared.delegate
                            appDelegate?.window??.rootViewController = homePage
                        }
                     
                    }else {
                        self?.displayMessage(userMessage: "Could not sucsessfully perform this request. Please try again later")
                    }
                    
                } catch {
                    self?.myActivityIndicator.stopAnimating()
                    self?.displayMessage(userMessage: "Could not sucsessfully perform this request. Please try again later")
                }
              
            }
        }
        task.resume()
    }
  
}
