//
//  PodcastsViewController.swift
//  Pod Player
 //
//  Created by Shweta Shah on 17/10/19.
//  Copyright © 2019 Agrahyah. All rights reserved.
//

import Cocoa

class PodcastsViewController: NSViewController {

    @IBOutlet weak var addPodCastTextField: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    
    @IBAction func addPodcastBtnClicked(_ sender: Any) {
        
        
        if let url = URL(string: addPodCastTextField.stringValue) {
            
        
        URLSession.shared.dataTask(with: url) { (data: Data?, urlResponse: URLResponse?, error: Error?) in
            
            if(error != nil){
                print(error)
            }else{
                
                if(data != nil){
                let parse = Parse()
                
                parse.getPodcastData(data: data!)
                }
                
            }
    
            }.resume()
        }
        
        
    }
    
    
    
}

class user{
    var GUID : String
     
    init(){
        
    }
    
}

