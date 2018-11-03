//
//  homeViewController.swift
//  schoolQ
//
//  Created by Mitchell Markoff on 10/5/18.
//  Copyright © 2018 Mitchell Markoff. All rights reserved.
//

import UIKit
import FirebaseDatabase

class homeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var ref:DatabaseReference!
    var databaseHandle: DatabaseHandle!
    var postData = [String]()
    var valueToPass: String!
    
    
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        if valueToPass == nil {
            
            valueToPass = "Hi"
            
       }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        ref = Database.database().reference()
        
        databaseHandle = ref?.child("Posts").observe(.childAdded, with: { (snapshot) in
            
            let post = snapshot.value as? String
            if let actualPost = post {
            self.postData.append(actualPost)
                
            self.tableView.reloadData()
                
            }
            
            
        })
     

        // Do any additional setup after loading the view.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return postData.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
        cell?.textLabel!.text = postData[indexPath.row]
        
        return cell!
    }
    
   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
       
        
        let indexPath = tableView.indexPathForSelectedRow;
        let currentCell = tableView.cellForRow(at: indexPath!);
        
        
         valueToPass = currentCell?.textLabel?.text
        performSegue(withIdentifier: "answer", sender: self)
        }

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
     if (segue.identifier == "answer" ) {
           let viewController = segue.destination as! answerViewController
           viewController.passedValue = valueToPass
    
           }
    }
   
}
