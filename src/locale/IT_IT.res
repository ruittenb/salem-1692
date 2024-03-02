/**
 * Locale: it_IT
 */

let table = Js.Dict.fromArray([
  // TitlePage
  ("New Game", "Nuova partita"),
  ("Start Game", "Iniziare partita"),
  ("Play Game", "Giocare partita"),
  ("Join Game", "Unisciti a una partita"),
  ("Play", "Giocare"),
  ("Settings", "Impostazioni"),
  ("Exit", "Uscire"),
  // Setup
  ("Players", "Giocatori"),
  ("Names", "Nomi"),
  (
    "Enter the names of the players in clockwise order, starting at the head of the table.",
    "Inserisci i nomi dei giocatori in senso orario, iniziando dalla testa del tavolo.",
  ),
  (
    "During the night, player buttons will be shown in this order.",
    "Durante la notte, i pulsanti del giocatore verranno mostrati in questo ordine.",
  ),
  ("(add one)", "(aggiungi uno)"),
  ("Ghost Players", "Giocatori fantasma"),
  (
    `In a two- or three-player game, nicknames for "ghost" players should be added to the list above up to a total of four players.`,
    `In una partita a due o tre giocatori, i soprannomi per i giocatori "fantasma" dovrebbero essere aggiunti all'elenco sopra fino a un totale di quattro giocatori.`,
  ),
  ("Also check the box below.", "Seleziona anche la casella qui sotto."),
  ("Please consult the ", "Si prega di consultare le "),
  ("rules for 2-3 players.", "regole per 2-3 giocatori."),
  ("With Ghosts", "Con i fantasmi"),
  ("Sound effects", "Effetti sonori"),
  ("Speech", "Dialogue"),
  ("Music", "Musica"),
  ("Seating layout", "Disposizione dei posti a sedere"),
  (
    "How are the players seated around the table?",
    "Come sono seduti i giocatori attorno al tavolo?",
  ),
  (
    "This affects the positioning of the player buttons at night.",
    `Ciò influisce sul posizionamento dei pulsanti del giocatore durante la notte.`,
  ),
  ("Language", "Lingua"),
  ("English", "English"),
  ("Nederlands", "Nederlands"),
  ("Deutsch", "Deutsch"),
  (`Français`, `Français`),
  (`Español`, `Español`),
  (`Português`, `Português`),
  ("Italiano", "Italiano"),
  (`Українська`, `Українська`),
  ("Interface only, no dialogue yet", "Solo interfaccia, ancora nessun dialogo"),
  ("Back", "Indietro"),
  ("Next", "Prossimo"),
  ("Done", "Fatto"),
  ("OK", "OK"),
  (
    "Check the boxes to compose a playlist for the nights. Each successive night, the next track from the playlist will be played.",
    `Seleziona le caselle per comporre una playlist per le notti. Ogni notte successiva, verrà riprodotto il brano successivo della playlist.`,
  ),
  // Multi-Telephone
  ("Multi-Telephone", "Multi-telefono"),
  ("Host Game", "Ospita una partita"),
  ("Game Code", "Codice di partita"),
  ("Play as Host", "Giocare come anfitrione"),
  ("Play as Guest", "Giocare come ospite"),
  ("Start Hosting", "Iniziare a ospitare"),
  ("Stop Hosting", "Smettere di ospitare"),
  ("Malformed code", "Codice non valido"),
  ("Game not found", "Partita non trovata"),
  ("Not connected", "Non connesso"),
  ("Connecting...", "Connettendo..."),
  ("Connected.", "Connesso."),
  ("Leave guest mode", `Uscire modalità ospite`), // Esci dalla ...
  (
    "You can host a game so that players can join from another smartphone.",
    `Puoi ospitare una partita in modo che i giocatori possano partecipare da un altro smartphone.`,
  ),
  (
    "You can join a game running on another smartphone.",
    `Puoi partecipare a una partita in esecuzione su un altro smartphone.`,
  ),
  (
    `Take the other smartphone and look in the app under Multi-Telephone → Play as Host. Then enter the game code here.`,
    `Prendi l'altro smartphone e cerca nell'app in Multi-telefono → Giocare come anfitrione. Quindi inserisci qui il codice della partita.`,
  ),
  (
    "It is possible to join this game from another smartphone.",
    `È possibile partecipare a questa partita da un altro smartphone.`,
  ),
  (
    `Take the other smartphone and look in the app under Multi-Telephone → Play as Guest. Then enter the following game code there.`,
    `Prendi l'altro smartphone e guarda nell'app in Multi-telefono → Giocare come ospite. Quindi inserisci lì il seguente codice della partita.`,
  ),
  ("You are currently hosting a game.", "Attualmente stai ospitando una partita."),
  (
    "If you want to join a running game, you must stop hosting first.",
    "Se vuoi partecipare a una partita in corso, devi prima smettere di ospitare.",
  ),
  (
    "If you want to host a game so that others can join, you should leave guest mode first.",
    `Se vuoi ospitare una partita in modo che altri possano partecipare, devi prima uscire dalla modalità ospite.`,
  ),
  ("", ""),
  ("No authorization to use the camera", `Nessuna autorizzazione all'uso della fotocamera`), // contains nbsp
  (
    "Please authorize the use of the camera to scan a QR code",
    `Si prega di autorizzare l'uso della fotocamera per scansionare un codice QR`,
  ), // contains nbsp
  // Credits
  ("Credits", "Credits"),
  ("Game:", "Gioco:"),
  ("Rulebook", "Regole"),
  ("website", "sito web"),
  ("version", "versione"),
  ("For use with the game: ", "Per l'utilizzo con il gioco: "),
  ("App: ", "App: "),
  ("Libraries: ", "Biblioteche: "),
  ("Sound effects: ", "Effetti sonori: "),
  ("Voice actors: ", "Doppiatori: "),
  ("Images: ", "Immagini: "),
  ("Music: ", "Musica: "),
  ("Licensed under", `Concesso in licenza con`),
  // Day
  ("A day in Salem", "Una giornata a Salem"),
  ("Dawn,", "L'alba,"),
  ("one witch", "una strega"),
  ("several witches", "diverse streghe"),
  ("Night,", "La notte,"),
  ("with constable", "con sceriffo"),
  ("without constable", "senza sceriffo"),
  ("Dawn, one witch", "L'alba, una strega"),
  ("Dawn, several witches", "L'alba, diverse streghe"),
  ("Night with constable", "La notte con sceriffo"),
  ("Night without constable", "La notte senza sceriffo"),
  (
    "Waiting for the host to announce nighttime...",
    `In attesa che l'anfitrione annunci la notte...`,
  ),
  // Dawn / Night
  ("Dawn", "L'alba"),
  ("Night", "La notte"),
  ("The witches", "Le streghe"),
  ("The witch's turn", "Il turno della strega"),
  ("The witches' turn", "Il turno delle streghe"),
  (
    "Decide-SG who should get the black cat:",
    `Strega, decidi chi dovrebbe prendersi il gatto nero:`,
  ), // contains nbsp
  (
    "Decide-PL who should get the black cat:",
    `Streghe, decidete chi dovrebbe prendersi il gatto nero:`,
  ), // contains nbsp
  ("Choose-SG a victim:", "Strega, scegli una vittima:"),
  ("Choose-PL a victim:", "Streghe, scegliete una vittima:"),
  ("The constable", "Lo sceriffo"),
  ("The constable's turn", "Il turno dello sceriffo"),
  ("Choose another player to protect:", "Sceriffo, scegli un altro giocatore da proteggere:"),
  ("Choose someone to protect:", "Sceriffo, scegli qualcuno da proteggere:"),
  ("Abort", "Interrompere"),
  ("Skip", "Saltare"),
  ("Everybody is sound asleep... what about you?", "Tutti dormono profondamente... e tu?"), // contains nbsp
  // Confirm
  ("Witch, are you sure?", "Strega, sei sicura?"),
  ("Witches, are you sure?", "Streghe, siete sicure?"),
  ("Constable, are you sure?", `Sceriffo, è sicuro?`),
  ("Confirm", "Confermare"),
  ("Yes", `Sì`),
  ("No", "No"),
  // Error
  ("Error", "Errore"),
  ("Unable to load audio", `Impossibile caricare l'audio`),
  ("Index out of bounds", "Indice fuori limite"),
  // Confess
  ("Confess", "Confessare"),
  ("Citizens of Salem,", "Cittadini di Salem,"),
  (
    "those among you who wish to confess may now do so.",
    "quelli tra voi che desiderano confessarsi possono ora farlo.",
  ),
  // Reveal
  ("The Reveal", "La rivelazione"),
  (
    "Find out what happened while you were sleeping.",
    `Scopri cosa è successo mentre stavi dormendo.`,
  ),
  ("Reveal witch's victim", "Rivelare la vittima della strega"),
  ("Reveal witches' victim", "Rivelare la vittima delle streghe"),
  ("The witch attacked-PRE", "La strega ha attaccato"),
  ("The witch attacked-POST", ""),
  ("The witches attacked-PRE", "Le streghe hanno attaccato"),
  ("The witches attacked-POST", ""),
  (" got the black cat", ` ha preso il gatto nero.`), // contains nbsp
  ("Reveal constable's protection", "Rivelare la protezione dello sceriffo"),
  ("The constable protected-PRE", "Lo sceriffo ha protetto"),
  ("The constable protected-POST", ""),
])