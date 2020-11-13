//
//  BlogView.swift
//  BlogPost
//
//  Created by Las Rock on 11/12/20.
//

import UIKit

import Firebase
class BlogView: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    

    @IBOutlet weak var tableView: UITableView!
    
    var blogBrain:[BlogBrain]=[]
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource=self
        
        tableView.delegate=self
        
        navigationItem.hidesBackButton = true
        
        tableView.register(UINib(nibName: "BlogCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        
        loadItem()
        
    }
    
    //MARK: - fetch and set req
    @IBAction func addBlog(_ sender: UIBarButtonItem) {
        
        var title = UITextField()
        var author = UITextField()
        
        
        
        let alert = UIAlertController(title: "add a new story", message: "", preferredStyle: .alert)
        
        alert.addTextField { (titleAlert) in
            titleAlert.placeholder = "add title"
            title=titleAlert
        }
        alert.addTextField { (authorAlert) in
            authorAlert.placeholder = "add author name"
            author=authorAlert
        }
        
        let action = UIAlertAction(title: "add story", style: .default) {_ in
            self.blogBrain.append(BlogBrain(title: title.text!, author: author.text!))
            self.saveItem(title: title.text!, author: author.text!)
            
            
        }
        alert.addAction(action)
        
       
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    func saveItem(title:String, author:String){
        db.collection(FStore.blogCollection).addDocument(data: [FStore.titleField:title,FStore.authorField:author]) { (error) in
            
            //the sender field is for the nameof email in db and the body is for the message send
            //and the collection name is for the name of the db in fire store
            if let e=error{
                print("there was an issue with fabase\(e)")
                
            }
            else{
                print("success")
                DispatchQueue.main.async {
                    
                }
            }
        }
    }
    
    func loadItem(){
        db.collection(FStore.blogCollection).order(by: FStore.titleField).addSnapshotListener { (QuerySnapshot, error) in
        self.blogBrain=[]
        if let e = error{
            print("issue in fire store\(e)")
        }
        else{
            if let snapshotDocuments = QuerySnapshot?.documents{
                for doc in snapshotDocuments{
                    let data=doc.data()
                    if let title=data[FStore.titleField] as? String, let author=data[FStore.authorField] as? String{
                        self.blogBrain.append(contentsOf: [BlogBrain(title: title, author: author)])
                        DispatchQueue.main.async {
                            //its good programming to use dipatch queue when there is a clouser because closuer happens in background
                            self.tableView.reloadData()
                            //this will trigger the datasources again so that it will appear every time or noyhing will appear
                            let indexPath = IndexPath(row: self.blogBrain.count - 1, section: 0)
                            //
                            self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                        }
                    }
                }
            }
        }
    }
}
    
    
    
    //MARK: - tableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blogBrain.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: Ident.cellIdent, for: indexPath)
        as! BlogCell
        
        cell.titleLabel.text=blogBrain[indexPath.row].title
        cell.authorLabel.text=blogBrain[indexPath.row].author
        
        return cell
    }
    
    
    //MARK: - tableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: Ident.postSegue, sender: self)
    }
}
