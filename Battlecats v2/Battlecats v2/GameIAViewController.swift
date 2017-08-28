//
//  GameIAViewController.swift
//  Battlecats v2
//
//  Created by Enrique Rodríguez Castañeda on 07/03/17.
//  Copyright © 2017 Swifticats. All rights reserved.
//

import Cocoa

class GameIAViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        let audio = NSSound(named: "Nightcore – True Stories")
        audio?.play()
        self.armarTableroAliado()
        self.generarTableroEnemigo()
        noEsTuTurno.isHidden = true
    }
    @IBOutlet weak var noEsTuTurno: NSTextField!
    
    var nickname: String!
    
    var oponente = [String: AnyObject]()
    
    var aciertos = [String]()
    
    var golpes = [String]()
    
    var bannerLabelTimer: Timer!
    
    var tableroPropio = [String]()
    
    var juegoTerminado = false
    
    var ataquesEnemigo = [String]()
    
    @IBAction func ataque(_ sender: NSButton) {
        if !self.juegoTerminado {
            if tableroEnemigo.contains(sender.title) {
                if !self.aciertos.contains(sender.title) {
                    self.aciertos.append(sender.title)
                    if self.aciertos.count == 5 {
                        self.victoria()
                        self.juegoTerminado = true
                    }
                }
                sender.image = NSImage(named: "gatoTriste")
            }
        }
        
        if !self.juegoTerminado {
            sender.isEnabled = false
            var rand = Int(arc4random_uniform(25)) + 1
            while ataquesEnemigo.contains(String(rand)) {
                rand = Int(arc4random_uniform(25)) + 1
            }
            let golpe = String(rand)
            ataquesEnemigo.append(golpe)
            if tableroPropio.contains(golpe) {
                if !self.golpes.contains(golpe) {
                    self.golpes.append(golpe)
                    self.tablaPropia[rand-1].image = NSImage(named: "gatoBatallaTache")
                }
                if self.golpes.count == 5 {
                    self.derrota()
                    juegoTerminado = true
                }
            }
        }
    }
    
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
    
    //Tablero enemigo
    var tableroEnemigo: Array<String> = Array()
    
    func generarTableroEnemigo() {
        while tableroEnemigo.count<5 {
            let rand = Int(arc4random_uniform(25))+1
            if(!tableroEnemigo.contains(String(rand))) {
                tableroEnemigo.append(String(rand))
            }
        }
        print("tablero enemigo: ", tableroEnemigo)
        print("Tablero propio: ", tableroPropio)
    }
    
    
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
