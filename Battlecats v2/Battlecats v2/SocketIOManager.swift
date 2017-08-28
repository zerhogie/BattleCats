//
//  SocketIOManager.swift
//  Battlecats v2
//
//  Created by Enrique Rodríguez Castañeda on 08/12/16.
//  Copyright © 2016 Swifticats. All rights reserved.
//

import Cocoa

class SocketIOManager: NSObject {
    static let sharedInstance = SocketIOManager ()
    
    override init () {
        super.init()
    }
    
    //AQUI ESTÁ LA URL PARA EL SOCKET Y EL PUERTO
    //¡¡IMPORTANTE!! AQUI ESTÁ LA RUTA DE LA RED A LA QUE SE CONECTA... -->
    var socket: SocketIOClient = SocketIOClient(socketURL: NSURL(string: "http://127.0.0.1:3000")! as URL)
    
    //Se hace la conexión y desconexión
    func hacerConexion() {
        socket.connect()
    }
    
    func cerrarConexion() {
        socket.disconnect()
    }

    //SE CONECTA AL SERVIDOR CON UN NOMBRE Y TABLERO DE JUEGO
    func connectToServerWithNickname(nickname: String, tablero: [String], completionHandler: @escaping (_ userList: [[String: AnyObject]]?) -> Void) {
        socket.emit("connectUser", nickname, tablero)
        
        socket.on("userList") { ( dataArray, ack) -> Void in
            completionHandler(dataArray[0] as? [[String: AnyObject]])
        }
        
    }
    
    func hacerJugada(casilla: String, nicknameOponente: String, completionHandler: @escaping (_ nuevaJugada: [String: AnyObject]?) -> Void) {
        socket.emit("jugada", casilla, nicknameOponente)
        
        socket.on("nuevaJugada") { ( dataArray, ack) -> Void in
            completionHandler(dataArray[0] as? [String: AnyObject])
        }
    }
    
    func escucharJugada(completionHandler: @escaping (_ nuevaJugada: [String: AnyObject]?) -> Void) {
        socket.on("nuevaJugada") { ( dataArray, ack) -> Void in
            completionHandler(dataArray[0] as? [String: AnyObject])
        }
    }
    
    func invitar(nickname: String, nicknameOponente: String, completionHandler: @escaping (_ invitacion: [String: AnyObject]?) -> Void) {
        socket.emit("invitacion", nickname, nicknameOponente)
        
        socket.on("respuesta") { ( dataArray, ack) -> Void in
            completionHandler(dataArray[0] as? [String: AnyObject])
        }
    }
    
    func esperando(completionHandler: @escaping (_ invitacion: [String: AnyObject]?) -> Void) {
        socket.on("invita") { ( dataArray, ack) -> Void in
            completionHandler(dataArray[0] as? [String: AnyObject])
        }
    }
    
    func responder(nickname: String, aceptacion: Bool) -> Void {
        socket.emit("laRespuesta", nickname, aceptacion)
    }
}
