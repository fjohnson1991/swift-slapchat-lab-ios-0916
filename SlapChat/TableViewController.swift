//
//  TableViewController.swift
//  SlapChat
//
//  Created by Ian Rahman on 7/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    var messagesArray = [Message]()
    let store = DataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()


        if messagesArray.isEmpty {
            generateTestData()
            sortMessage()
        }
        
        tableView.reloadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        store.fetchData()
        sortMessage()
        tableView.reloadData()
    }
    
    func sortMessage() {
        messagesArray = store.messages
        messagesArray.sort { (messageOne, messageTwo) -> Bool in
            (messageOne.createdAt)?.compare(messageTwo.createdAt as! Date) == ComparisonResult.orderedAscending
        }
    }
    
    
    func generateTestData() {
        
        let managedContext = DataStore.sharedInstance.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Message", in: managedContext)
        
        if let unwrappedEntity = entity {
            let message = NSManagedObject(entity: unwrappedEntity, insertInto: managedContext) as! Message
            message.content = "hello"
            message.createdAt = NSDate()
        
            store.saveContext()
            store.fetchData()
        
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)
        guard let contentToShow = messagesArray[indexPath.row].content else {return cell}
        cell.textLabel?.text = contentToShow
        
        return cell
    }
    
    
    
    
}
