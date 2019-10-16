//
//  ViewController.swift
//  ToDoList
//
//  Created by Shweta Shah on 14/10/19.
//  Copyright © 2019 Agrahyah. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var todoText: NSTextField!
    @IBOutlet weak var importantCheckBox: NSButton!
    
    @IBOutlet weak var deleteBtn: NSButton!
    var appDelegate = NSApplication.shared.delegate as? AppDelegate
    var todoItems = [ToDoItem]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getTodoItems()
        // Do any additional setup after loading the view.
    }

    func getTodoItems(){
        
        if let context =  appDelegate?.persistentContainer.viewContext{
    
            do{
            
            //Set them to class property
            todoItems = try context.fetch(ToDoItem.fetchRequest())
                 
            }catch{
                
            }
            
            //update Table View
            tableView.reloadData()
        }
    }
    @IBAction func deleteClicked(_ sender: Any) {
        
        
        let todoItem = todoItems[tableView.selectedRow]
        if let context =  appDelegate?.persistentContainer.viewContext{
             
            context.delete(todoItem)
            appDelegate?.saveAction(nil)
            getTodoItems()
            deleteBtn.isHidden = true
        }
        
    }
    
    @IBAction func addClicked(_ sender: Any) {
        
        if todoText.stringValue != "" {
           if let context =  appDelegate?.persistentContainer.viewContext{
                
                //Get the todoitem context
                let todoItem = ToDoItem(context: context)
                todoItem.name = todoText.stringValue
            
                if(importantCheckBox.state == .off){
                    todoItem.important = false
                }else{
                    todoItem.important = true
                }
            
                //Saving the data
                appDelegate?.saveAction(nil)
                
                // Removing the data from the feild
                todoText.stringValue = ""
                importantCheckBox.state = .off
                
                getTodoItems()
            }
        }
    }
    
}


 // MARK: - Table View methods
extension ViewController : NSTableViewDelegate , NSTableViewDataSource{
    
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return todoItems.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        if tableColumn?.identifier == NSUserInterfaceItemIdentifier(rawValue: "ImpIndetifier"){
            if let cell =  tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "importantCell"), owner: self) as? NSTableCellView{
             let todoItem = todoItems[row]
            if todoItem.important == false{
                 cell.textField?.stringValue = ""
            }else{
                 cell.textField?.stringValue = "❗️"
            }
                 return cell
            }
            
        }else{
         
             if let cell =  tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "ToDoCell"), owner: self) as? NSTableCellView{
                 let todoItem = todoItems[row]
                if let name = todoItem.name{
                cell.textField?.stringValue = name
                }else{
                cell.textField?.stringValue = ""
                }
                return cell
            }
        }
        
        return nil
   
        
    }
    
    
    
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        deleteBtn.isHidden = false
        
        
        
    }
    
}

