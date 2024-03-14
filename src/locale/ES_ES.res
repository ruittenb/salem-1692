/**
 * Locale: es_ES
 */

let table = Js.Dict.fromArray([
  // TitlePage
  ("New Game", "Nuevo juego"),
  ("Start Game", "Comenzar juego"),
  ("Play Game", "Jugar"),
  ("Join Game", "Unirse a un juego"),
  ("Play", "Jugar"),
  ("Settings", `Configu­ración`), // soft hyphen
  ("Exit", "Salir"),
  // Setup
  ("Players", "Jugadores"),
  ("Names", "Nombres"),
  (
    "Enter the names of the players in clockwise order, starting at the head of the table.",
    "Introduzca los nombres de los jugadores en el orden de las agujas del reloj, comenzando por la cabecera de la mesa.",
  ),
  (
    "During the night, player buttons will be shown in this order.",
    `Por la noche, los botones de los jugadores se mostrarán en este orden.`,
  ),
  ("(add one)", `(añadir uno)`),
  ("Ghost Players", "Jugadores fantasmas"),
  (
    `In a two- or three-player game, nicknames for "ghost" players should be added to the list above up to a total of four players.`,
    `En un juego de dos o tres juga­dores, los apodos para los jugadores "fantasmas" deben agregarse a la lista anterior hasta un total de cuatro jugadores.`,
  ), // soft hyphen
  ("Also check the box below.", `También marca la casilla de abajo.`),
  ("Please consult the ", "Por favor consulta las "),
  ("rules for 2-3 players.", `reglas para 2-3 jugadores.`),
  ("With Ghosts", "Con fantasmas"),
  ("Sound effects", "Sonidos"),
  ("Speech", `Diálogo`),
  ("Music", `Música`),
  ("Seating layout", `Posición de los jugadores`),
  (
    "How are the players seated around the table?",
    `¿Cómo están sentados los jugadores alrededor de la mesa?`,
  ),
  (
    "This affects the positioning of the player buttons at night.",
    `Esto afecta la posición de los botones de los jugadores por la noche.`,
  ),
  ("Language", "Idioma"),
  ("English", "English"),
  ("Nederlands", "Nederlands"),
  ("Deutsch", "Deutsch"),
  (`Français`, `Français`),
  (`Español`, `Español`),
  (`Português`, `Português`),
  ("Italiano", "Italiano"),
  (`Українська`, `Українська`),
  (`日本語`, `日本語`),
  ("Interface only, no dialogue yet", `Interfaz solamente, sin diálogo todavía`),
  ("Back", "Regresar"),
  ("Next", "Avanzar"),
  ("Done", "Listo"),
  ("OK", "OK"),
  (
    "Check the boxes to compose a playlist for the nights. Each successive night, the next track from the playlist will be played.",
    `Marca las pistas para crear una lista de reproducción para las noches. Cada noche sucesiva, se reproducirá la siguiente pista de la lista de reproducción.`,
  ),
  // Multi-Telephone
  ("Multi-Telephone", `Multi-teléfono`),
  ("Host Game", "Albergar juego"),
  ("Game Code", `Código del juego`),
  ("Play as Host", `Jugar como anfitrión`),
  ("Play as Guest", `Jugar como invitado`),
  ("Start Hosting", "Empezar a albergar"),
  ("Stop Hosting", "Dejar de albergar"),
  ("Malformed code", `Código con formato incorrecto`),
  ("Game not found", "Juego no encontrado"),
  ("Not connected", "No conectado"),
  ("Connecting...", "Conectando..."),
  ("Connected.", "Conectado."),
  ("Leave guest mode", "Dejar como invitado"),
  (
    "You can host a game so that players can join from another smartphone.",
    `Puedes albergar un juego al que otros jugadores pueden unirse desde otro smartphone.`,
  ),
  (
    "You can join a game running on another smartphone.",
    "Puedes unirte a un juego en progreso en otro smartphone.",
  ),
  (
    `Take the other smartphone and look in the app under Multi-Telephone → Play as Host. Then enter the game code here.`,
    `Tome el otro smartphone y busque en la aplicación en Multi-teléfono → Jugar como anfitrión. Luego ingrese el código aquí.`,
  ),
  (
    "It is possible to join this game from another smartphone.",
    `Es posible unirse a este juego desde otro smartphone.`,
  ),
  (
    `Take the other smartphone and look in the app under Multi-Telephone → Play as Guest. Then enter the following game code there.`,
    `Tome el otro smartphone y busque en la aplicación en Multi-teléfono → Jugar como invitado. Luego ingrese el siguiente código allí.`,
  ),
  ("You are currently hosting a game.", `Actualmente estás albergando un juego.`),
  (
    "If you want to join a running game, you must stop hosting first.",
    `Si deseas unirte a un juego en progreso, primero debes dejar de albergar.`,
  ),
  (
    "If you want to host a game so that others can join, you should leave guest mode first.",
    `Si deseas albergar un juego para que otros jugadores puedan unirse, primero debes dejar del modo de invitado.`,
  ),
  ("", ""),
  ("No authorization to use the camera", `No autorización para usar la cámara`), // contains nbsp
  (
    "Please authorize the use of the camera to scan a QR code",
    `Autorice el uso de la cámara para escanear un código QR`,
  ),
  // Credits
  ("Credits", `Créditos`),
  ("Game:", "Juego:"),
  ("Rulebook", "Reglas del juego"),
  ("website", "sitio web"),
  ("version", `versión`),
  ("For use with the game: ", "Para usar con el juego: "),
  ("App: ", `Aplicación: `),
  ("Libraries: ", "Bibliotecas: "),
  ("Sound effects: ", "Efectos de sonido: "),
  ("Voice actors: ", "Actores de voz: "),
  ("Images: ", `Imágenes: `),
  ("Music: ", `Música: `),
  ("Licensed under ", "Licencia "),
  // Day
  ("A day in Salem", `Un día en Salem`),
  ("Dawn,", "El amanecer,"),
  ("one witch", "una bruja"),
  ("several witches", "varias brujas"),
  ("Night,", "La noche,"),
  ("with constable", "con alguacil"),
  ("without constable", "sin alguacil"),
  ("Dawn, one witch", "El amanecer, una bruja"),
  ("Dawn, several witches", "El amanecer, varias brujas"),
  ("Night with constable", "Noche con alguacil"),
  ("Night without constable", "Noche sin alguacil"),
  (
    "Waiting for the host to announce nighttime...",
    `Esperando hasta que el anfitrión anuncie la noche...`,
  ),
  // Dawn / Night
  ("Dawn", "El amanecer"),
  ("Night", "La noche"),
  ("The witches", "Las brujas"),
  ("The witch's turn", "Turno de la bruja"),
  ("The witches' turn", "Turno de las brujas"),
  ("Decide-SG who should get the black cat:", `Decide quién debe recibir el gato negro:`), // contains nbsp
  ("Decide-PL who should get the black cat:", `Decidan quién debe recibir el gato negro:`), // contains nbsp
  ("Choose-SG a victim:", `Elige una víctima:`),
  ("Choose-PL a victim:", `Eligen una víctima:`),
  ("The constable", "El alguacil"),
  ("The constable's turn", "Turno del alguacil"),
  ("Choose another player to protect:", "Elige otro jugador para proteger:"),
  ("Choose someone to protect:", `Elige a quién quieres proteger:`),
  ("Abort", "Abortar"),
  ("Skip", "Saltar"),
  ("Everybody is sound asleep... what about you?", `Todos duermen profundamente... ¿y tú?`), // contains nbsp
  // Confirm
  ("Witch, are you sure?", `Bruja, ¿estás segura?`),
  ("Witches, are you sure?", `Brujas, ¿estáis seguras?`), // están?
  ("Constable, are you sure?", `Alguacil, ¿estás seguro?`),
  ("Confirm", "Confirmar"),
  ("Yes", `Sí`),
  ("No", "No"),
  // Error
  ("Error", "Error"),
  ("Unable to load audio", "No se puede cargar el audio"),
  ("Index out of bounds", `Índice fuera de los límites`),
  // Confess
  ("Confess", `La confesión`),
  ("Citizens of Salem,", "Ciudadanos de Salem,"),
  (
    "those among you who wish to confess may now do so.",
    "aquellos entre vosotros que lo deseen, ahora pueden confesar.",
  ),
  // Reveal
  ("The Reveal", `La revelación`),
  ("Find out what happened while you were sleeping.", `Descubran qué pasó mientras dormían.`),
  ("Reveal witch's victim", `Revelar la víctima de la bruja`),
  ("Reveal witches' victim", `Revelar la víctima de las brujas`),
  ("The witch attacked-PRE", `La bruja atacó a`),
  ("The witch attacked-POST", ""),
  ("The witches attacked-PRE", `Las brujas atacaron a`),
  ("The witches attacked-POST", ""),
  (" got the black cat", ` consiguió el gato negro`), // contains nbsp
  (`Reveal constable's protégé`, `Revelar el protegido del alguacil`), // contains nbsp
  ("The constable protected-PRE", `El alguacil protegió a`),
  ("The constable protected-POST", ""),
])
