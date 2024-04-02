/**
 * Locale: hu_HU
 *
 * Note: this is a machine translation that needs to be reviewed
 */
let table = Js.Dict.fromArray([
  // TitlePage
  ("New Game", `Új játék`),
  ("Start Game", `Játék kezdése`),
  ("Play Game", `Játékot játszani`),
  ("Join Game", `Belépni a játékba`),
  ("Play", `Játék`),
  ("Settings", `Beállítások`),
  ("Exit", `Kijárat`),
  // Setup
  ("Players", `Játékosok`),
  ("Names", `Nevek`),
  (
    "Enter the names of the players in clockwise order, starting at the head of the table.",
    `Írja be a játékosok nevét az óramutató járásával megegyező irányban, az asztal élétől kezdve.`,
  ),
  (
    "During the night, player buttons will be shown in this order.",
    `Az éjszaka folyamán a játékos gombjai ebben a sorrendben jelennek meg.`,
  ),
  ("(add one)", `(hozzáadni egyet)`),
  ("Ghost Players", `Szellemjátékosok`),
  (
    `In a two- or three-player game, nicknames for "ghost" players should be added to the list above up to a total of four players.`,
    `Egy két- vagy háromfős játékban a "szellem" játékosok beceneveit fel kell venni a fenti listára, összesen négy játékos erejéig.`,
  ),
  ("Also check the box below.", `Jelölje be az alábbi négyzetet is.`),
  ("Please consult the ", `Kérjük, forduljon a `),
  ("rules for 2-3 players.", `2-3 játékosra vonatkozó szabályok.`),
  ("With Ghosts", `Szellemekkel`),
  ("Sound effects", `Hang hatások`),
  ("Speech", `Társalgás`),
  ("Music", `Zene`),
  ("Seating layout", `Ülések elrendezése`),
  (
    "How are the players seated around the table?",
    `Hogyan ülnek a játékosok az asztal körül?`,
  ),
  (
    "This affects the positioning of the player buttons at night.",
    `Ez hatással van a lejátszó gombjainak éjszakai elhelyezkedésére.`,
  ),
  ("Language", `Nyelv`),
  ("Interface only, no dialogue yet", `Csak interfész, még nincs párbeszéd`),
  ("Back", `Vissza`),
  ("Next", `Következő`),
  ("Done", `Kész`),
  ("OK", `Rendben`),
  (
    "Check the boxes to compose a playlist for the nights. Each successive night, the next track from the playlist will be played.",
    `Jelölje be a jelölőnégyzeteket, hogy összeállítson egy lejátszási listát az éjszakákra. Minden egymást követő este lejátssza a lejátszási listáról a következő számot.`,
  ),
  // Multi-Telephone
  ("Multi-Telephone", `Több telefon`),
  ("Host Game", `Gazdajáték`),
  ("Game Code", `Játék kód`),
  ("Play as Host", `Játssz házigazdaként`),
  ("Play as Guest", `Játék vendégként`),
  ("Start Hosting", `Kezdje el a hostingot`),
  ("Stop Hosting", `Állítsa le a hostingot`),
  ("Malformed code", `Rosszul formázott kód`),
  ("Game not found", `A játék nem található`),
  ("Not connected", `Nem kapcsolódik`),
  ("Connecting...", `Csatlakozás...`),
  ("Connected.", `Csatlakoztatva.`),
  ("Leave guest mode", `Vendég mód elhagyása`),
  (
    "You can host a game so that players can join from another smartphone.",
    `Rendszerezhet egy játékot, hogy a játékosok egy másik okostelefonról csatlakozhassanak.`,
  ),
  (
    "You can join a game running on another smartphone.",
    `Csatlakozhatsz egy másik okostelefonon futó játékhoz.`,
  ),
  (
    `Take the other smartphone and look in the app under Multi-Telephone → Play as Host. Then enter the game code here.`,
    `Vegye elő a másik okostelefont, és keresse meg az alkalmazásban a Több telefon → Játssz házigazdaként menüpontot. Ezután írja be ide a játék kódját.`,
  ),
  (
    "It is possible to join this game from another smartphone.",
    `Lehetőség van egy másik okostelefonról is csatlakozni ehhez a játékhoz.`,
  ),
  (
    `Take the other smartphone and look in the app under Multi-Telephone → Play as Guest. Then enter the following game code there.`,
    `Vegye elő a másik okostelefont, és keresse meg az alkalmazásban a Több telefon → Játék vendégként menüpontot. Ezután írja be a következő játékkódot.`,
  ),
  ("You are currently hosting a game.", `Jelenleg egy játék házigazdája.`),
  (
    "If you want to join a running game, you must stop hosting first.",
    `Ha csatlakozni szeretne egy futójátékhoz, először le kell állítania a fogadást.`,
  ),
  (
    "If you want to host a game so that others can join, you should leave guest mode first.",
    `Ha úgy akarsz házigazdát adni egy játéknak, hogy mások is csatlakozhassanak hozzá, először ki kell lépned a vendég módból.`,
  ),
  ("", ""),
  ("No authorization to use the camera", `Nincs engedély a kamera használatára`),
  (
    "Please authorize the use of the camera to scan a QR code",
    `Kérjük, engedélyezze a kamera használatát QR-kód beolvasására`,
  ),
  // Credits
  ("Credits", `Kreditek`),
  ("Game:", `Játszma:`),
  ("Rulebook", `Szabálykönyv`),
  ("website", `weboldal`),
  ("version", `változat`),
  ("For use with the game: ", `Játékhoz használható: `),
  ("App: ", `Alkalmazás: `),
  ("Libraries: ", `Könyvtárak: `),
  ("Sound effects: ", `Hang hatások: `),
  ("Voice actors: ", `Színészek: `),
  ("Images: ", `Képek: `),
  ("Music: ", `Zene:`),
  ("Licensed under ", `Licenc alatt `),
  // Daytime
  ("A day in Salem", `Egy nap Salemben`),
  ("Dawn,", `Hajnal,`),
  ("one witch", `egy boszorkány`),
  ("several witches", `több boszorkány`),
  ("Night,", `Éjszaka,`),
  ("with constable", `rendőrrel`), // -> rendőrbíró
  ("without constable", `rendőrbíró nélkül`),
  ("Dawn, one witch", `Hajnal, egy boszorkány`),
  ("Dawn, several witches", `Hajnal, több boszorkány`),
  ("Night with constable", `Éjszaka rendőrnél`), // -> rendőrbíró
  ("Night without constable", `Éjszaka rendőrbíró nélkül`),
  (
    "Waiting for the host to announce nighttime...",
    `Várom, hogy a házigazda bejelentse az éjszakát...`,
  ),
  // Dawn / Night
  ("Dawn", `Hajnal`),
  ("Night", `Éjszaka`),
  ("The witches", `A boszorkányok`),
  ("The witch's turn", `A boszorkány sora`),
  ("The witches' turn", `A boszorkányok sora`),
  (
    "Decide-SG who should get the black cat:",
    `Boszorkány, döntsd el, ki kapja meg a fekete macskát:`,
  ),
  (
    "Decide-PL who should get the black cat:",
    `Boszorkányok, döntsétek el, ki kapja meg a fekete macskát:`,
  ),
  ("Choose-SG a victim:", `Boszorkány, válassz áldozatot:`),
  ("Choose-PL a victim:", `Boszorkányok, válasszatok áldozatot:`),
  ("The constable", `A rendőrbíró`),
  ("The constable's turn", `A rendőrbíró sora`),
  ("Choose another player to protect:", `Válassz másik játékost, akit meg akarsz védeni:`),
  ("Choose someone to protect:", `Válassz valakit, akit megvédel:`),
  ("Abort", `Elvetél`),
  ("Skip", `Kihagyás`),
  ("Everybody is sound asleep... what about you?", `Mindenki mélyen alszik... mi van veled?`),
  // Confirm
  ("Witch, are you sure?", `Boszorkány, biztos vagy benne?`),
  ("Witches, are you sure?", `Boszorkányok, biztos vagy benne?`),
  ("Constable, are you sure?", `Rendőrbíró, biztos vagy benne?`),
  ("Confirm", `Megerősít`),
  ("Yes", `Igen`),
  ("No", `Nem`),
  // Error
  ("Error", `Hiba`),
  ("Unable to load audio", `Nem sikerült betölteni a hangot`),
  ("Index out of bounds", `Index a határokon kívül`),
  // Confess
  ("Confess", `Bevallani`),
  ("Citizens of Salem,", `Salem polgárai,`),
  (
    "those among you who wish to confess may now do so.",
    `akik közületek szeretnének gyónni, most megtehetik.`,
  ),
  // Reveal
  ("The Reveal", `A feltárás`),
  (
    "Find out what happened while you were sleeping.",
    `Derítsd ki, mi történt, miközben aludtál.`,
  ),
  ("Reveal witch's victim", `Felfedd a boszorkány áldozatát`),
  ("Reveal witches' victim", `Felfedd a boszorkányok áldozatát`),
  ("The witch attacked-PRE", `A boszorkány megtámadta `),
  ("The witch attacked-POST", ""),
  ("The witches attacked-PRE", `A boszorkányok megtámadták `),
  ("The witches attacked-POST", ""),
  (" got the black cat", ` megvan a fekete macska`),
  (`Reveal constable's protégé`, `Fedezze fel a rendőrbíró pártfogóját`),
  ("The constable protected-PRE", `A rendőrbíró megvédte `),
  ("The constable protected-POST", ""),
])