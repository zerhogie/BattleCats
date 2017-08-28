//
//  GameViewController.swift
//  Battlecats v2
//
//  Created by Enrique Rodríguez Castañeda on 08/12/16.
//  Copyright © 2016 Swifticats. All rights reserved.
//

import Cocoa

class GameViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        let audio = NSSound(named: "Nightcore – True Stories")
        audio?.play()
        self.armarTableroAliado()
        SocketIOManager.sharedInstance.escucharJugada(completionHandler: { (jugada) -> Void in
            DispatchQueue.global().async(execute: { () -> Void in
                if jugada != nil {
                    if (jugada?["nickname"]! as! String == self.oponente["nickname"]! as! String) {
                        let tiro = jugada?["casilla"]! as! String
                        let cas: Int = Int(tiro)! - 1
                        if jugada?["resultado"] as! Bool {
                            if !self.golpes.contains(tiro) {
                                self.golpes.append(tiro)
                                self.tablaPropia[cas].image = NSImage(named: "gatoBatallaTache")
                            }
                        }
                        else {
                            self.tablaPropia[cas].image = NSImage(named: "siluetaTache")
                        }
                        self.noEsTuTurno.isHidden = true
                        self.turno = true
                    }
                    if self.golpes.count == 5 {
                        DispatchQueue.main.async {
                            self.derrota()
                        }
                    }
                }
            })
        })
        noEsTuTurno.isHidden = true
    }
    
    var nickname: String!
    
    var oponente = [String: AnyObject]()
    
    var aciertos = [String]()
    
    var golpes = [String]()
    
    var bannerLabelTimer: Timer!
    
    var tableroPropio = [String!]()
    
    var turno = Bool()
    
    //BOTONES DEL TABLERO ENEMIGO
    
    @IBAction func ataque(_ sender: NSButton) {
        if turno {
            SocketIOManager.sharedInstance.hacerJugada(casilla: sender.title, nicknameOponente: oponente["nickname"] as! String, completionHandler: { (jugada) -> Void in
                DispatchQueue.global().async(execute: { () -> Void in
                    if jugada != nil {
                        if (jugada?["nickname"]?.isEqual(self.nickname))! {
                            if jugada?["resultado"] as! Bool {
                                if !self.aciertos.contains((jugada?["casilla"])! as! String) {
                                    self.aciertos.append((jugada?["casilla"])! as! String)
                                    if self.aciertos.count == 5 {
                                        DispatchQueue.main.async {
                                            self.victoria()
                                        }
                                    }
                                }
                                sender.image = NSImage(named: "gatoTriste")
                            }
                        }
                    }
                })
            })
            sender.isEnabled = false
            self.turno = false
        }
        else {
            let noTurno = NSSound(named: "tkshredde - zoomout")
            noTurno?.play()
            noEsTuTurno.isHidden = false
        }
    }
    
    @IBOutlet weak var noEsTuTurno: NSTextField!
    
    
    
    func victoria() {
        let alert = NSAlert()
        alert.messageText = NSLocalizedString("¡Felicidades! Ganaste el juego", comment: "Mensaje que aparece cuando el usuario gana el juego")
        alert.informativeText = NSLocalizedString("Tu equipo se ha quedado con la herencia", comment: "Mensaje de información cuando el usuario gana la partida")
        alert.icon = NSImage(named: "victorioso")
        alert.runModal()
        print("Juego concluido")
        self.dismiss(self)
    }
    
    func derrota() {
        let alert = NSAlert()
        alert.messageText = NSLocalizedString("¡Jajajaja! Perdiste el juego", comment: "Mensaje que aparece cuando el usuario pierde la partida")
        alert.informativeText = NSLocalizedString("Te han robado la muchas croquetas de la herencia", comment: "Mensaje de información cuando el usuario pierde la partida")
        alert.icon = NSImage(named: "gatoMuero")
        alert.runModal()
        print("Juego concluido")
        self.dismiss(self)
    }
    //---------------------------------------
    
    //TABLERO PROPIO/ALIADO
  
    @IBOutlet weak var gatoAliado1: NSImageCell!
    @IBOutlet weak var gatoAliado2: NSImageCell!
    @IBOutlet weak var gatoAliado3: NSImageCell!
    @IBOutlet weak var gatoAliado4: NSImageCell!
    @IBOutlet weak var gatoAliado5: NSImageCell!
    @IBOutlet weak var gatoAliado6: NSImageCell!
    @IBOutlet weak var gatoAliado7: NSImageCell!
    @IBOutlet weak var gatoAliado8: NSImageCell!
    @IBOutlet weak var gatoAliado9: NSImageCell!
    @IBOutlet weak var gatoAliado10: NSImageCell!
    @IBOutlet weak var gatoAliado11: NSImageCell!
    @IBOutlet weak var gatoAliado12: NSImageCell!
    @IBOutlet weak var gatoAliado13: NSImageCell!
    @IBOutlet weak var gatoAliado14: NSImageCell!
    @IBOutlet weak var gatoAliado15: NSImageCell!
    @IBOutlet weak var gatoAliado16: NSImageCell!
    @IBOutlet weak var gatoAliado17: NSImageCell!
    @IBOutlet weak var gatoAliado18: NSImageCell!
    @IBOutlet weak var gatoAliado19: NSImageCell!
    @IBOutlet weak var gatoAliado20: NSImageCell!
    @IBOutlet weak var gatoAliado21: NSImageCell!
    @IBOutlet weak var gatoAliado22: NSImageCell!
    @IBOutlet weak var gatoAliado23: NSImageCell!
    @IBOutlet weak var gatoAliado24: NSImageCell!
    @IBOutlet weak var gatoAliado25: NSImageCell!
    
    var tablaPropia: Array<NSImageCell> = Array()
    
    func armarTableroAliado() {
        
        tablaPropia.append(gatoAliado1)
        tablaPropia.append(gatoAliado2)
        tablaPropia.append(gatoAliado3)
        tablaPropia.append(gatoAliado4)
        tablaPropia.append(gatoAliado5)
        tablaPropia.append(gatoAliado6)
        tablaPropia.append(gatoAliado7)
        tablaPropia.append(gatoAliado8)
        tablaPropia.append(gatoAliado9)
        tablaPropia.append(gatoAliado10)
        tablaPropia.append(gatoAliado11)
        tablaPropia.append(gatoAliado12)
        tablaPropia.append(gatoAliado13)
        tablaPropia.append(gatoAliado14)
        tablaPropia.append(gatoAliado15)
        tablaPropia.append(gatoAliado16)
        tablaPropia.append(gatoAliado17)
        tablaPropia.append(gatoAliado18)
        tablaPropia.append(gatoAliado19)
        tablaPropia.append(gatoAliado20)
        tablaPropia.append(gatoAliado21)
        tablaPropia.append(gatoAliado22)
        tablaPropia.append(gatoAliado23)
        tablaPropia.append(gatoAliado24)
        tablaPropia.append(gatoAliado25)
        
        for n in 0...4 {
            let i: Int = Int(self.tableroPropio[n])!
            tablaPropia[i-1].image = NSImage(named: "gatoBatalla")
        }
    }
}
