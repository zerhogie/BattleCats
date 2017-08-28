//
//  SelectionController.swift
//  Battlecats v2
//
//  Created by Enrique Rodríguez Castañeda on 08/12/16.
//  Copyright © 2016 Swifticats. All rights reserved.
//

import Cocoa

class SelectionController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func viewDidDisappear() {
        super.viewDidDisappear()
        
    }
   
    @IBOutlet weak var restantes: NSTextFieldCell?
    
    public var elegidos = [String]()
    
    var users = [[String: AnyObject]]()
    
    @IBOutlet weak var nickname: NSTextFieldCell!
    
    //PREPARANDO EL USERVIEWCONTROLLER (LA SIGUIENTE VENTAN)
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "idSegueUsers" {
                let userViewController = segue.destinationController as! UserViewController
                userViewController.nickname = nickname.title
                userViewController.tablero = elegidos
                userViewController.users = users
            }
        }
    }
    
    
    //Poniendo las función de los botones del tablero
    @IBAction func posicion(_ sender: NSButton) {
        if ((restantes?.integerValue)! > 0) {
            self.elegidos.append(sender.title)
            restantes?.integerValue -= 1
            sender.isEnabled = false
        }
        if restantes?.integerValue == 0{
            if nickname.title == "" || nickname == nil {
                let warning = NSAlert()
                warning.messageText = "Ingresa tu nombre de usuario"
                warning.informativeText = "Para jugar necesitas identificarte"
                warning.runModal()
            }
            else {
                self.performSegue(withIdentifier: "idSegueUsers", sender: self)
            }
            self.dismiss(self)
        }
    }
    
    @IBAction func gatos(_ sender: NSTextFieldCell) {
        if sender.integerValue == 0 {
            self.performSegue(withIdentifier: "a_jugar", sender: self)
            self.dismiss(self)
        }
    }
}
