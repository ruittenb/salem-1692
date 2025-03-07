/**
 * Locale: de_DE
 */
let table = Dict.fromArray([
  // TitlePage
  ("New Game", "Neues Spiel"),
  ("Start Game", "Spiel starten"),
  ("Play Game", "Spielen"),
  ("Join Game", "Spiel beitreten"),
  ("Play", "Spielen"),
  ("Settings", `Einstel­lungen`), // soft hyphen
  ("Exit", `Schließen`),
  // Setup
  ("Players", "Spieler"),
  ("Names", "Namen"),
  (
    "Enter the names of the players in clockwise order, starting at the head of the table.",
    `Geben Sie die Namen der Spieler ein, im Uhrzeigersinn beginnend am Kopfende des Tisches.`,
  ),
  (
    "During the night, player buttons will be shown in this order.",
    `Während der Nacht werden die Spieler-Tasten in dieser Reihenfolge angezeigt.`,
  ),
  ("(add one)", `(hinzufügen)`),
  ("Ghost Players", "Geisterspieler"),
  (
    `In a two- or three-player game, nicknames for "ghost" players should be added to the list above up to a total of four players.`,
    `In einem Spiel mit zwei oder drei Spielern sollten Spitznamen für "Geister"-Spieler zur obigen Liste hinzugefügt werden, bis zu einer Gesamtzahl von vier Spielern.`,
  ),
  ("Also check the box below.", `Kreuzen Sie auch das Kästchen unten an.`),
  ("Please consult the ", "Bitte beachten Sie die "),
  ("rules for 2-3 players.", `Regeln für 2-3 Spieler.`),
  ("With Ghosts", "Mit Geistern"),
  ("Sound effects", "Soundeffekte"),
  ("Speech", "Dialog"),
  ("Music", "Musik"),
  ("Stay active", "Aktiv halten"),
  (
    "This keeps the screen active during the night, so that other players cannot see whether you used your phone.",
    `Dies hält den Bildschirm aktiv während der Nacht, so dass andere Spieler nicht sehen können, ob Sie Ihr Telefon verwendet haben.`,
  ),
  ("Seating layout", "Sitzordnung"),
  ("How are the players seated around the table?", "Wie sitzen die Spieler am Tisch?"),
  (
    "This affects the positioning of the player buttons at night.",
    `Dies beeinflusst die Positionierung der Spieler-Tasten während der Nacht.`,
  ),
  ("Language", "Sprache"),
  ("Interface only, no dialogue yet", "Nur Schnittstelle, noch kein Dialog"),
  ("Back", `Zurück`),
  ("Next", "Weiter"),
  ("Done", "Fertig"),
  ("OK", "OK"),
  (
    "Check the boxes to compose a playlist for the nights. Each successive night, the next track from the playlist will be played.",
    `Aktivieren Sie die Kästchen, um eine Playlist für die Nächte zu erstellen. Jede nachfolgende Nacht wird der nächste Titel aus der Playlist abgespielt.`,
  ),
  // Multi-Telephone
  ("Multi-Telephone", "Multi-Telefon"),
  ("Host Game", "Spiel hosten"),
  ("Game Code", "Spielcode"),
  ("Play as Host", "Als Gastgeber spielen"),
  ("Play as Guest", "Als Gast spielen"),
  ("Start Hosting", `Anfangen zu hosten`),
  ("Stop Hosting", `Aufhören zu hosten`),
  ("Malformed code", "Fehlerhafter Code"),
  ("Game not found", "Spiel nicht gefunden"),
  ("Not connected", "Nicht verbunden"),
  ("Connecting...", "Verbinden..."),
  ("Connected.", "Verbunden."),
  ("Leave guest mode", "Gastmodus verlassen"),
  (
    "You can host a game so that players can join from another smartphone.",
    `Sie können ein Spiel hosten, dem andere Spieler von einem anderen Smartphone aus beitreten können.`,
  ),
  (
    "You can join a game running on another smartphone.",
    `Sie können an einem Spiel beitreten, das auf einem anderen Smartphone läuft.`,
  ),
  (
    `Take the other smartphone and look in the app under Multi-Telephone → Play as Host. Then enter the game code here.`,
    `Nehmen Sie das andere Smartphone und schauen Sie in der App unter Multi-Telefon → Als Gastgeber spielen. Dann geben Sie hier den Spielcode ein.`,
  ),
  (
    "It is possible to join this game from another smartphone.",
    `Es ist möglich an diesem Spiel beizutreten von einem anderen Smartphone aus.`,
  ),
  (
    `Take the other smartphone and look in the app under Multi-Telephone → Play as Guest. Then enter the following game code there.`,
    `Nehmen Sie das andere Smartphone und schauen Sie in der App unter Multi-Telefon → Als Gast spielen. Dann geben Sie dort den folgenden Spielcode rein.`,
  ),
  ("You are currently hosting a game.", "Sie hosten gerade ein Spiel."),
  (
    "If you want to join a running game, you must stop hosting first.",
    `Wenn Sie einem laufenden Spiel beitreten möchten, müssen Sie zuerst das Hosten beenden.`,
  ),
  (
    "If you want to host a game so that others can join, you should leave guest mode first.",
    `Wenn Sie ein Spiel hosten möchten, damit andere Spieler beitreten können, müssen Sie zuerst den Gastmodus verlassen.`,
  ),
  ("", ""),
  ("No authorization to use the camera", "Keine Berechtigung um die Kamera zu benutzen"),
  (
    "Please authorize the use of the camera to scan a QR code",
    "Bitte autorisieren Sie die Verwendung der Kamera zum Scannen eines QR-Codes",
  ),
  // Credits
  (
    "Please note! As of March 2025, this app will no longer be downloadable from the Google Play Store. Please use the link or QR code above.",
    `Bitte beachten! Ab März 2025 ist diese App nicht mehr im Google Play Store herunterladbar. Bitte verwenden Sie den Link oder QR-Code oben.`,
  ),
  ("Credits", "Credits"),
  ("Game:", "Spiel:"),
  ("Rulebook", "Spielregeln"),
  ("website", "Webseite"),
  ("version", "Version"),
  ("For use with the game: ", "Zur Verwendung mit dem Spiel: "),
  ("App: ", "App: "),
  ("Libraries: ", "Bibliotheken: "),
  ("Sound effects: ", "Soundeffekte: "),
  ("Voice actors: ", "Sprecher: "),
  ("Images: ", "Bilder: "),
  ("Music: ", "Musik: "),
  ("Licensed under ", "Lizenziert unter "),
  // Day
  ("A day in Salem", "Ein Tag in Salem"),
  ("Dawn,", "Morgengrauen,"),
  ("one witch", "eine Hexe"),
  ("several witches", "mehrere Hexen"),
  ("Night,", `Nacht,`),
  ("with constable", "mit Sheriff"),
  ("without constable", "ohne Sheriff"),
  ("Dawn, one witch", "Morgengrauen, eine Hexe"),
  ("Dawn, several witches", "Morgengrauen, mehrere Hexen"),
  ("Night with constable", "Nacht mit Sheriff"),
  ("Night without constable", "Nacht ohne Sheriff"),
  (
    "Waiting for the host to announce nighttime...",
    `Warten bis der Gastgeber die Nacht ankündigt...`,
  ),
  // Dawn / Night
  ("Dawn", `Morgen­grauen`), // contains soft hyphen
  ("Night", "Die Nacht"),
  ("The witches", "Die Hexen"),
  ("The witch's turn", `Die Hexe ist an der Reihe`), // contains nbsp
  ("The witches' turn", `Die Hexen sind an der Reihe`), // contains nbsp
  (
    "Decide-SG who should get the black cat:",
    `Entscheiden Sie, wer die schwarze Katze bekommen soll:`,
  ), // contains nbsp
  (
    "Decide-PL who should get the black cat:",
    `Entscheiden Sie, wer die schwarze Katze bekommen soll:`,
  ), // contains nbsp
  ("Choose-SG a victim:", `Wählen Sie ein Opfer:`),
  ("Choose-PL a victim:", `Wählen Sie ein Opfer:`),
  ("The constable", "Der Sheriff"),
  ("The constable's turn", ` Der Sheriff ist an der Reihe `), // contains nbsp
  (
    "Choose any other player to protect:",
    `Wählen Sie einen anderen Spieler aus, den Sie beschützen möchten:`,
  ),
  ("Choose someone to protect:", `Wählen Sie jemanden, den Sie beschützen möchten:`),
  ("Abort", "Abbrechen"),
  ("Skip", `Überspringen`),
  ("Everybody is sound asleep... what about you?", "Alle schlafen tief und fest... und du?"),
  // Confirm
  ("Witch, are you sure?", "Hexe, sind Sie sicher?"),
  ("Witches, are you sure?", "Hexen, sind Sie sicher?"),
  ("Constable, are you sure?", "Sheriff, sind Sie sicher?"),
  ("Confirm", `Bestätigen`),
  ("Yes", "Ja"),
  ("No", "Nein"),
  // Error
  ("Error", "Fehler"),
  ("Unable to load audio", "Audio kann nicht geladen werden"),
  ("Index out of bounds", `Index außerhalb der Grenzen`),
  // Confess
  ("Confess", "Beichten"),
  ("Residents of Salem,", `Einwohner von Salem,`),
  (
    "those among you who wish to confess may now do so.",
    `diejenigen unter Ihnen, die beichten möchten, können dies jetzt tun.`,
  ),
  // Reveal
  ("The Reveal", `Die Enthüllung`),
  (
    "Find out what happened while you were sleeping.",
    `Finden Sie heraus, was passiert ist, während Sie geschlafen haben.`,
  ),
  ("Reveal witch's victim", `Opfer der Hexe enthüllen`),
  ("Reveal witches' victim", `Opfer der Hexen enthüllen`),
  ("The witch attacked-PRE", "Die Hexe hat "),
  ("The witch attacked-POST", " angegriffen"),
  ("The witches attacked-PRE", "Die Hexen haben "),
  ("The witches attacked-POST", " angegriffen"),
  (" got the black cat", " hat die schwarze Katze bekommen"),
  (`Reveal constable's protégé`, `Schützling des Sheriffs enthüllen`),
  ("The constable protected-PRE", "Der Sheriff hat "),
  ("The constable protected-POST", ` beschützt`),
  ("Nobody-SUBJ", "Niemand"),
  ("nobody-OBJ", "niemanden"),
  ("The constable did not protect anybody", `Der Sheriff hat niemanden beschützt`),
])
