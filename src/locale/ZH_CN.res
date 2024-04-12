/**
 * Locale: zh_CN - placeholder file, translation needed
 */
let table = Js.Dict.fromArray([
  // TitlePage
  ("New Game", "New Game"),
  ("Start Game", "Start Game"),
  ("Play Game", "Play Game"),
  ("Join Game", "Join Game"),
  ("Play", "Play"),
  ("Settings", "Settings"),
  ("Exit", "Exit"),
  // Setup
  ("Players", "Players"),
  ("Names", "Names"),
  (
    "Enter the names of the players in clockwise order, starting at the head of the table.",
    "Please enter the names of the players in clockwise order, starting at the head of the table.",
  ),
  (
    "During the night, player buttons will be shown in this order.",
    "During the night, player buttons will be shown in this order.",
  ),
  ("(add one)", "(add one)"),
  ("Ghost Players", "Ghost Players"),
  (
    `In a two- or three-player game, nicknames for "ghost" players should be added to the list above up to a total of four players.`,
    `In a two- or three-player game, nick­names for "ghost" players should be added to the list above up to a total of four players.`,
  ), // soft hyphen
  ("Also check the box below.", "Also check the box below."),
  ("Please consult the ", "Please consult the "),
  ("rules for 2-3 players.", "rules for 2-3 players."),
  ("With Ghosts", "With Ghosts"),
  ("Sound effects", "Sound FX"),
  ("Speech", "Discourse"),
  ("Music", "Music"),
  ("Seating layout", "Seating Layout"),
  ("How are the players seated around the table?", "How are the players seated around the table?"),
  (
    "This affects the positioning of the player buttons at night.",
    "This affects the positioning of the player buttons during the night.",
  ),
  ("Language", "Language"),
  ("Interface only, no dialogue yet", "Interface only, no dialogue yet"),
  ("Back", "Back"),
  ("Next", "Next"),
  ("Done", "Done"),
  ("OK", "OK"),
  (
    "Check the boxes to compose a playlist for the nights. Each successive night, the next track from the playlist will be played.",
    "Check the boxes to compose a playlist for the nights. Each successive night, the next track from the playlist will be played.",
  ),
  // Multi-Telephone
  ("Multi-Telephone", "Multi-Telephone"),
  ("Host Game", "Host Game"),
  ("Game Code", "Game Code"),
  ("Play as Host", "Play as Host"),
  ("Play as Guest", "Play as Guest"),
  ("Start Hosting", "Start Hosting"),
  ("Stop Hosting", "Stop Hosting"),
  ("Malformed code", "Malformed code"),
  ("Game not found", "Game not found"),
  ("Not connected", "Not connected"),
  ("Connecting...", "Connecting..."),
  ("Connected.", "Connected."),
  ("Leave guest mode", "Leave Guest Mode"),
  (
    "You can host a game so that players can join from another smartphone.",
    "You can host a game so that players can join from another smartphone.",
  ),
  (
    "You can join a game running on another smartphone.",
    "You can join a game running on another smartphone.",
  ),
  (
    `Take the other smartphone and look in the app under Multi-Telephone → Play as Host. Then enter the game code here.`,
    `Take the other smartphone and look in the app under Multi-Telephone → Play as Host. Then enter the game code here.`,
  ),
  (
    "It is possible to join this game from another smartphone.",
    "It is possible to join this game from another smartphone.",
  ),
  (
    `Take the other smartphone and look in the app under Multi-Telephone → Play as Guest. Then enter the following game code there.`,
    `Take the other smartphone and look in the app under Multi-Telephone → Play as Guest. Then enter the following game code there.`,
  ),
  ("You are currently hosting a game.", "You are currently hosting a game."),
  (
    "If you want to join a running game, you must stop hosting first.",
    "If you want to join a running game, you must stop hosting first.",
  ),
  (
    "If you want to host a game so that others can join, you should leave guest mode first.",
    "If you want to host a game so that others can join, you should leave guest mode first.",
  ),
  ("", ""),
  ("No authorization to use the camera", `No authorization to use the camera`), // contains nbsp
  (
    "Please authorize the use of the camera to scan a QR code",
    `Please authorize the use of the camera to scan a QR code`,
  ), // contains nbsp
  // Credits
  ("Credits", "Credits"),
  ("Game:", "Game:"),
  ("Rulebook", "Rulebook"),
  ("website", "website"),
  ("version", "version"),
  ("For use with the game: ", "For use with the game: "),
  ("App: ", "App: "),
  ("Libraries: ", "Libraries: "),
  ("Sound effects: ", "Sound effects: "),
  ("Voice actors: ", "Voice actors: "),
  ("Images: ", "Images: "),
  ("Music: ", "Music: "),
  ("Licensed under ", "Licensed under "),
  // Daytime
  ("A day in Salem", "A day in Salem"),
  ("Dawn,", "Dawn,"),
  ("one witch", "one witch"),
  ("several witches", "several witches"),
  ("Night,", "Night,"),
  ("with constable", "with constable"),
  ("without constable", "without constable"),
  ("Dawn, one witch", "Dawn, one witch"),
  ("Dawn, several witches", "Dawn, several witches"),
  ("Night with constable", "Night with constable"),
  ("Night without constable", "Night without constable"),
  (
    "Waiting for the host to announce nighttime...",
    "Waiting for the host to announce nighttime...",
  ),
  // Dawn / Night
  ("Dawn", "Dawn"),
  ("Night", "Night"),
  ("The witches", "The witches"),
  ("The witch's turn", "The witch's turn"),
  ("The witches' turn", "The witches' turn"),
  ("Decide-SG who should get the black cat:", `Decide who should get the black cat:`), // contains nbsp
  ("Decide-PL who should get the black cat:", `Decide who should get the black cat:`), // contains nbsp
  ("Choose-SG a victim:", "Choose a victim:"),
  ("Choose-PL a victim:", "Choose a victim:"),
  ("The constable", "The constable"),
  ("The constable's turn", "The constable's turn"),
  ("Choose another player to protect:", "Choose any other player to protect:"),
  ("Choose someone to protect:", "Choose someone to protect:"),
  ("Abort", "Abort"),
  ("Skip", "Skip"),
  (
    "Everybody is sound asleep... what about you?",
    `Everybody is sound asleep... what about you?`,
  ), // contains nbsp
  // Confirm
  ("Witch, are you sure?", "Witch, are you sure?"),
  ("Witches, are you sure?", "Witches, are you sure?"),
  ("Constable, are you sure?", "Constable, are you sure?"),
  ("Confirm", "Confirm"),
  ("Yes", "Yes"),
  ("No", "No"),
  // Error
  ("Error", "Error"),
  ("Unable to load audio", "Unable to load audio"),
  ("Index out of bounds", "Index out of bounds"),
  // Confess
  ("Confess", "Confess"),
  ("Residents of Salem,", "Residents of Salem,"),
  (
    "those among you who wish to confess may now do so.",
    "those among you who wish to confess may now do so.",
  ),
  // Reveal
  ("The Reveal", "The Reveal"),
  (
    "Find out what happened while you were sleeping.",
    "Find out what happened while you were sleeping.",
  ),
  ("Reveal witch's victim", "Reveal the witch's victim"),
  ("Reveal witches' victim", "Reveal the witches' victim"),
  ("The witch attacked-PRE", "The witch attacked "),
  ("The witch attacked-POST", ""),
  ("The witches attacked-PRE", "The witches attacked "),
  ("The witches attacked-POST", ""),
  (" got the black cat", ` got the black cat`), // contains nbsp
  (`Reveal constable's protégé`, `Reveal the constable's protégé`),
  ("The constable protected-PRE", "The constable protected "),
  ("The constable protected-POST", ""),
  ("Nobody-SUBJ", "Nobody"),
  ("nobody-OBJ", "nobody"),
  ("The constable did not protect anybody", "The constable did not protect anybody"),
])