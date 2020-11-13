//
//  RegisterView.swift
//  BlogPost
//
//  Created by Las Rock on 11/12/20.
//

import UIKit
import Firebase

class RegisterView: UIViewController {

 
    @IBOutlet weak var emailT: UITextField!
    
    @IBOutlet weak var passT: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

 
    @IBAction func registerPress(_ sender: UIButton) {
        
        if let email=emailT.text, let password=passT.text{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e=error{
                    print(e.localizedDescription)
                    //localizedDiscription gives the error in selcted language
                }
                else{
                    self.performSegue(withIdentifier: Ident.regsiterSeg, sender: self)
                }
            }
            
        }
    }
    
}
