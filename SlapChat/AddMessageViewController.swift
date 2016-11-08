//
//  AddMessageViewController.swift
//  SlapChat
//
//  Created by Felicity Johnson on 11/8/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import CoreData

class AddMessageViewController: UIViewController {

    
    @IBOutlet weak var contentTextField: UITextField!
    let store = DataStore.sharedInstance
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButton(_ sender: Any) {
        
        let managedContext = store.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Message", in: managedContext)
        
        if let unwrappedEntity = entity {
            let message = NSManagedObject(entity: unwrappedEntity, insertInto: managedContext) as! Message
            message.content = contentTextField.text
            message.createdAt = NSDate()
            
            store.saveContext()
            store.fetchData()
            
        }
        
        self.dismiss(animated: true, completion: nil)
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
