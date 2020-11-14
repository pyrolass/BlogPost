//
//  PostView.swift
//  BlogPost
//
//  Created by Las Rock on 11/12/20.
//

import UIKit
import Firebase
class PostView: UIViewController {
    
    
    @IBOutlet weak var uploadIsEnabled: UIButton!
    @IBOutlet weak var deleteIsEnabled: UIButton!
    @IBOutlet weak var editEnabled: UIBarButtonItem!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    var titleP:String?
    var userEmail:String?
    
    
    let db=Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        titleLabel.text=titleP
        loadItem()
        textView.isEditable=false
    }
    
    @IBAction func editButton(_ sender: UIBarButtonItem) {
        
        textView.isEditable=true
        
    }
    
    @IBAction func uploadButton(_ sender: UIButton) {
        
        db.collection(FStore.blogCollection).document(titleLabel.text!).setData([FStore.postsInfo:textView.text], merge:true){ err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
                
            }
        }
    }
    
    @IBAction func deleteButton(_ sender: UIButton) {
        db.collection(FStore.blogCollection).document(titleLabel.text!).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }

    }
    
    func loadItem(){
        let blogRef = db.collection(FStore.blogCollection)
        let query = blogRef.whereField(FStore.titleField, isEqualTo: titleLabel.text).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    
                    let data=document.data()
                    if let post=data[FStore.postsInfo] as? String{
                        self.textView.text=post
                    }
                    if let user=data[FStore.authorEmail] as? String{
                        if user==Auth.auth().currentUser?.email{
                            self.navigationItem.rightBarButtonItem != nil
                        }
                        else{
                            self.navigationItem.rightBarButtonItem = nil
                            self.uploadIsEnabled.isHidden=true
                            self.deleteIsEnabled.isHidden=true
                        }
                    }
                }
            }
        }
        
    }
    
    
}
