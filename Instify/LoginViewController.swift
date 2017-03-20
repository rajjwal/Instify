//
//  LoginViewController.swift
//  Instify
//
//  Created by Rajjwal Rawal on 3/19/17.
//  Copyright © 2017 Rajjwal Rawal. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!){
            user, error in
            if user != nil{
                print("You're logged in!")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            else{
                let alertController = UIAlertController(title: "ERROR!", message: "Invalid Username or Password", preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                    // handle cancel response here. Doing nothing will dismiss the view.
                }
                // add the cancel action to the alertController
                alertController.addAction(cancelAction)
                
                
                self.present(alertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }
                
            }
        }
        
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        // call sign up function on the object
        
        newUser.signUpInBackground {
            (succeeded: Bool, error:Error?) -> Void in
            if succeeded {
                print("Created a user")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                
            }
            else{
                print("Error: ",error!.localizedDescription as Any)
                
                let alertController = UIAlertController(title: "ERROR!", message: error!.localizedDescription, preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                    // handle cancel response here. Doing nothing will dismiss the view.
                }
                // add the cancel action to the alertController
                alertController.addAction(cancelAction)
                
                self.present(alertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }
            }
        }
        
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
