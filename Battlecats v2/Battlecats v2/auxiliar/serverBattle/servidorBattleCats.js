var app = require('express')();
var http = require('http').Server(app);
var io = require('socket.io')(http);
var port = 3000;

var userList = [];

app.get('/', function(req, res){
  res.send('<h1>AppCoda - SocketChat Server</h1>');
});


http.listen(port, function(){
  console.log('Listening on *:', port);
});


io.on('connection', function(clientSocket){
  console.log('a user connected');

  clientSocket.on('disconnect', function(){
    console.log('user disconnected');

    var clientNickname;
    var tablero = [];
    for (var i=0; i<userList.length; i++) {
      if (userList[i]["id"] == clientSocket.id) {
        userList[i]["isConnected"] = false;
        clientNickname = userList[i]["nickname"];
        tablero = userList[i]["utablero"];
        break;
      }
    }

    io.emit("userList", userList);
    io.emit("userExitUpdate", clientNickname);
    io.emit("userTablero", tablero);
  });


  clientSocket.on("exitUser", function(clientNickname){
    for (var i=0; i<userList.length; i++) {
      if (userList[i]["id"] == clientSocket.id) {
        userList.splice(i, 1);
        break;
      }
    }
    io.emit("userExitUpdate", clientNickname);
  });

  clientSocket.on("exitUser", function(clientNickname){
    for (var i=0; i<userList.length; i++) {
      if (userList[i]["id"] == clientSocket.id) {
        userList.splice(i, 1);
        break;
      }
    }
    io.emit("userExitUpdate", clientNickname);
  });

  clientSocket.on('jugada', function(casilla, nicknameOp){
    var resultado = false;
    var jugada = {};
    for (var i=0; i<userList.length; i++) {
      if (userList[i]["nickname"] == nicknameOp) {
        var tabla = userList[i]["utablero"];
        for(var j=0; j<tabla.length; j++) {
          if(tabla[j] == casilla) {
            resultado = true;
            break;
          }
        }
        break;
      }
    }
    var atacante;
    for (var i=0; i<userList.length; i++) {
    	if (userList[i]["id"] == clientSocket.id) {
    		atacante = userList[i]["nickname"];
    		break;
    	}
    }
    jugada["casilla"] = casilla;
    jugada["nickname"] = atacante;
    jugada["nicknameOp"] = nicknameOp;
    jugada["resultado"] = resultado;
    var message = "El jugador " + atacante + " ha atacado a " + nicknameOp;
    console.log(message);
    if (resultado) {
    	console.log("¡Le ha dado!");
    } else {
    	console.log("¡Fallo!");
    }
    io.emit('nuevaJugada', jugada);
  });

  clientSocket.on("invitacion", function(clientNickname, nicknameOp) {
  	var invitacion = {}
  	invitacion["anfitrion"] = clientNickname;
  	invitacion["invitado"] = nicknameOp;
  	console.log(clientNickname + " ha invitado a jugar a " + nicknameOp);
  	io.emit("invita", invitacion);
  });

  clientSocket.on("laRespuesta", function(clientNickname, aceptacion) {
  	var respuesta = {}
  	respuesta["aceptacion"] = aceptacion;
  	respuesta["quien"] = clientNickname;
  	io.emit("respuesta",respuesta);
  });

  clientSocket.on("connectUser", function(clientNickname, tablero) {
      var message = "User " + clientNickname + " was connected.";
      var message2 = "Su tablero ha sido guardado";
      console.log(message);
      console.log(message2);

      var userInfo = {};
      var foundUser = false;
      for (var i=0; i<userList.length; i++) {
        if (userList[i]["nickname"] == clientNickname) {
          userList[i]["isConnected"] = true
          userList[i]["id"] = clientSocket.id;
          userList[i]["utablero"] = tablero;
          userInfo = userList[i];
          foundUser = true;
          break;
        }
      }

      if (!foundUser) {
        userInfo["id"] = clientSocket.id;
        userInfo["nickname"] = clientNickname;
        userInfo["isConnected"] = true
        userInfo["utablero"] = tablero;
        userList.push(userInfo);
      }

      io.emit("userList", userList);
      io.emit("userConnectUpdate", userInfo)
  });

});


