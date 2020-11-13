//
//  LoginView.swift
//  BlogPost
//
//  Created by Las Rock on 11/12/20.
//

import UIKit
import Firebase

class LoginView: UIViewController {

 
    @IBOutlet weak var emailT: UITextField!
    
    @IBOutlet weak var passT: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
   
    
    @IBAction func loginPress(_ sender: UIButton) {
        
        if let email=emailT.text, let password=passT.text{
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                guard let strongSelf = self else { return }
                if let e=error{
                    print(e)
                }
                else{
                    self?.performSegue(withIdentifier: Ident.loginSeg, sender: self)
                }
            }
        }
    }
        
}
    
    
    

