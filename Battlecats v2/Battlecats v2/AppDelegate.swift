//
//  AppDelegate.swift
//  Battlecats v2
//
//  Created by Enrique Rodríguez Castañeda on 08/12/16.
//  Copyright © 2016 Swifticats. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func applicationDidBecomeActive(_ aNotification: Notification) {
        SocketIOManager.sharedInstance.hacerConexion()
    }

    func applicationDidEnterBackground(_ aNotification: Notification) {
        SocketIOManager.sharedInstance.cerrarConexion()
    }

}

