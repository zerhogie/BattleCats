//
//  UserViewController.swift
//  Battlecats v2
//
//  Created by Enrique Rodríguez Castañeda on 08/12/16.
//  Copyright © 2016 Swifticats. All rights reserved.
//

import Cocoa

class UserViewController: NSViewController, NSOutlineViewDelegate, NSOutlineViewDataSource{
    
    @IBOutlet weak var usersTable: NSOutlineView!
    
    @IBOutlet weak var tablaScroll: NSScrollView!
    
    
    var users = [[String: AnyObject]]()
    
    var tablero = [String!]()
    
    var oponente = [String: AnyObject]()
    
    var nickname: String!
    
    var configurationOK = false
    
    var anfitrion: String!
    
    var turno = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do view setup here.
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        if !configurationOK {
            configureTable()
            configurationOK = true
        }
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        SocketIOManager.sharedInstance.connectToServerWithNickname(nickname: self.nickname, tablero: self.tablero, completionHandler: { (userList) -> Void in
            DispatchQueue.global().async(execute: { () -> Void in
                if userList != nil {
                    self.users = userList!
                    DispatchQueue.main.async {
                        self.usersTable.reloadData()
                        self.usersTable.isHidden = false
                    }
                }
            })
        })
        SocketIOManager.sharedInstance.esperando(completionHandler: { (invitacion) -> Void in
            DispatchQueue.global().async(execute: { () -> Void in
                if invitacion != nil {
                    if invitacion?["invitado"] as? String == self.nickname {
                        self.anfitrion = invitacion?["anfitrion"] as! String!
                        DispatchQueue.main.async {
                            let aceptacion = self.mostrarAlerta(titulo: NSLocalizedString("Invitación", comment: "Mensaje que aparece en el título de la alerta de la invitación"), mensaje: (self.anfitrion + NSLocalizedString("Te invita a jugar una partida", comment: "Mensaje que se muestra cuando un usuario invita a otro a jugar una partida")), btnPositivo: NSLocalizedString("Aceptar", comment: "Mensaje que aparece en el botón de aceptar"), btnNegativo: NSLocalizedString("Rechazar", comment: "Mensaje que aparece en el boton de rechazar"))
                            if aceptacion {
                                for item in self.users {
                                    if item["nickname"] as? String == self.anfitrion {
                                        self.oponente = item
                                        self.turno = false
                                        self.performSegue(withIdentifier: "idSeguePlay", sender: self)
                                    }
                                }
                            }
                            SocketIOManager.sharedInstance.responder(nickname: self.nickname, aceptacion: aceptacion)
                        }
                    }
                }
            })
        })
    }
    
    func mostrarAlerta(titulo: String, mensaje: String, btnPositivo: String, btnNegativo: String) -> Bool {
        let alert: NSAlert = NSAlert()
        alert.messageText = titulo
        alert.informativeText = mensaje
        alert.alertStyle = NSAlertStyle.warning
        alert.addButton(withTitle: btnPositivo)
        alert.addButton(withTitle: btnNegativo)
        return alert.runModal() == NSAlertFirstButtonReturn
    }
    
    //CONFIGURACIÓN DE LA TABLA
    
    func configureTable() {
        usersTable.numberOfChildren(ofItem: users)
        usersTable.delegate = self
        usersTable.dataSource = self
        usersTable.register(NSNib(nibNamed: "UserCell", bundle: nil), forIdentifier: "idCellUser")
        usersTable.isHidden = true
        
    }
    
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        return users.count
    }
    
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        return users[index]
    }
    
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        return false
    }
    var cont = 0
  
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        var view = NSTableCellView()
        view = (outlineView.make(withIdentifier: "UserCell", owner: self) as? NSTableCellView)!
        view.textField?.stringValue = users[outlineView.childIndex(forItem: item)]["nickname"] as! String
        view.textField?.textColor = (users[outlineView.childIndex(forItem: item)]["isConnected"] as! Bool) ? NSColor.green : NSColor.red
        return view
    }
    
    @IBAction func doubleClickItem(_ sender: NSOutlineView) {
        oponente = sender.item(atRow: sender.selectedRow) as! [String : AnyObject]
        if (oponente["nickname"] as? String != nickname) {
            invitarASeleccionado()
        }
        else {
            let advertencia = NSAlert()
            advertencia.messageText = NSLocalizedString("No puedes invitarte a ti mismo", comment: "Mensaje que aparece cuando intenta invitarse a si mismo a jugar")
            advertencia.icon = NSImage(named: "gatoTriste")
        }
    }
    
    func invitarASeleccionado() {
        SocketIOManager.sharedInstance.invitar(nickname: nickname, nicknameOponente: oponente["nickname"] as! String, completionHandler: { (laRespuesta) -> Void in
            DispatchQueue.global().async(execute: { () -> Void in
                if laRespuesta != nil {
                    if laRespuesta?["quien"] as? String == self.oponente["nickname"] as? String {
                        if (laRespuesta?["aceptacion"] as? Bool)! {
                            self.turno = true
                            self.performSegue(withIdentifier: "idSeguePlay", sender: self)
                        }
                        else {
                            DispatchQueue.main.async {
                                let alert = NSAlert()
                                alert.messageText = NSLocalizedString("Lo sientimos", comment: "Una disculpa")
                                alert.informativeText = (laRespuesta?["quien"] as? String)! + NSLocalizedString(" rechazó tu invitación", comment: "Mensaje que aparece cuando un usuario rechaza la invitación")
                                alert.runModal()
                            }
                        }
                    }
                }
            })
        })
    }
    
    
    //---------------------------
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "idSeguePlay" {
                let gameViewController = segue.destinationController as! GameViewController
                gameViewController.nickname = nickname
                gameViewController.tableroPropio = tablero
                gameViewController.oponente = oponente
                gameViewController.turno = turno
            }
            if identifier == "idSeguePlayIA" {
                let gameIAViewController = segue.destinationController as! GameIAViewController
                gameIAViewController.nickname = nickname
                gameIAViewController.tableroPropio = tablero
            }
        }
    }
   
    @IBAction func salir(_ sender: NSButton) {
        if mostrarAlerta(titulo: NSLocalizedString("¿Seguro que quieres salir?", comment: "Pregunta de confirmación para salir"), mensaje: NSLocalizedString("Presiona desconectar para salir", comment: "Comentario del mensaje de confirmación para salir"), btnPositivo: NSLocalizedString("Desconectar", comment: "Botón para desconectar"), btnNegativo: NSLocalizedString("Cancelar", comment: "Botón para cancelar")) {
            self.dismiss(self)
            SocketIOManager.sharedInstance.cerrarConexion()
            SocketIOManager.sharedInstance.hacerConexion()
        }
    }
    
    //PASA A LA VENTANA DE JUEGO
    
    @IBAction func btnAyuda(_ sender: NSButton) {
        let alert = NSAlert()
        alert.messageText = NSLocalizedString("Para mandar una invitación da doble clic sobre el nombre del usuario", comment: "Mensaje que aparece en la ayuda del usuario para explicar como mandar una invitación")
        alert.informativeText = NSLocalizedString("¡Juguemos Battlecats!", comment: "Mensaje de información de la alerta para la ayuda de mandar una invitación")
        alert.icon = NSImage(named: "Gato dormido")
        alert.runModal()
    }
    
    
}

