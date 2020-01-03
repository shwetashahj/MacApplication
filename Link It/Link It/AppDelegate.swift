//
//  AppDelegate.swift
//  Link It
//
//  Created by Shweta Shah on 16/10/19.
//  Copyright © 2019 Agrahyah. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    //To keep the instance of status item alive
    var item : NSStatusItem? = nil
    

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        //This is to show the status item at the top status bar
        //If we do not assign it to item it can die when flow go out from this function
        item = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        //You can add many things here like  action, image, title. etc
       // item?.title = "Link It!"
        item?.action = #selector(linkIt)
        
        //Now to show menu on click of the status bar item we need to create a menu
        let menu = NSMenu()
        
        //To add items in menu we need menu item.
        menu.addItem(NSMenuItem(title: "Link It", action:#selector(AppDelegate.linkIt), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Quit", action:#selector(AppDelegate.quit), keyEquivalent: ""))
        
        //Adding menu into item
        item?.menu = menu
        
        item?.image = NSImage(named: "link")
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    
    
    @objc func linkIt(){
        print("WE Made IT")
    }
    
     @objc func quit(){
        NSApplication.shared.terminate(self)
    }

    
    func printPasteboard(){
        
        if let items = NSPasteboard.general.pasteboardItems{
            for item in items{
                for type in item.types{
                    print(type)
                }
                
            }
        }
    }

}

