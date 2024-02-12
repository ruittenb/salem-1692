/**
 * Locale: fr_FR
 */

let table = Js.Dict.fromArray([
  // TitlePage
  ("New Game", "Nouveau jeu"),
  ("Start Game", `Démarrer jeu`),
  ("Play Game", "Jouer"),
  ("Join Game", "Joindre un jeu"),
  ("Play", "Jouer"),
  ("Settings", `Configu­ration`), // soft hyphen
  ("Exit", "Fermer"),
  // Setup
  ("Players", "Joueurs"),
  ("Names", "Noms"),
  (
    "Enter the names of the players in clockwise order, starting at the head of the table.",
    `Saisissez les noms des joueurs dans le sens des aiguilles d'une montre, en commençant par la tête de la table.`,
  ),
  (
    "During the night, player buttons will be shown in this order.",
    `Pendant la nuit, les boutons des joueurs seront affichés dans cet ordre.`,
  ),
  ("(add one)", "(ajouter)"),
  ("Ghost Players", `Joueurs fantômes`),
  (
    `In a two- or three-player game, nicknames for "ghost" players should be added to the list above up to a total of four players.`,
    `Dans une partie à deux ou trois joueurs, les surnoms des joueurs "fantômes" doivent être ajoutés à la liste ci-dessus jusqu'à un total de quatre joueurs.`,
  ),
  ("Please consult the ", "Veuillez consulter les "),
  ("rules for 2-3 players.", `règles pour 2-3 joueurs.`),
  ("Also check the box below.", `Cochez également la case ci-dessous.`),
  ("With Ghosts", `Avec fantômes`),
  ("Sound effects", "Effets sonores"),
  ("Speech", "Discours"),
  ("Music", "Musique"),
  ("Seating layout", `Disposition des sièges`),
  (
    "How are the players seated around the table?",
    "Comment les joueurs sont-ils assis autour de la table?",
  ),
  (
    "This affects the positioning of the player buttons at night.",
    `Cela affecte le positionnement des boutons des joueurs pendant la nuit.`,
  ),
  ("Language", "Langue"),
  ("English", "English"),
  ("Nederlands", "Nederlands"),
  ("Deutsch", "Deutsch"),
  (`Français`, `Français`),
  (`Español`, `Español`),
  (`Português`, `Português`),
  ("Italiano", "Italiano"),
  ("Interface only, no dialogue yet", "Interface uniquement, pas encore de dialogue"),
  ("Back", "Retour"),
  ("Next", "Suivant"),
  ("Done", `Prêt`),
  ("OK", "OK"),
  (
    "Check the boxes to compose a playlist for the nights. Each successive night, the next track from the playlist will be played.",
    `Cochez les cases pour composer une playlist pour les nuits. Chaque nuit successive, la piste suivante de la playlist sera jouée.`,
  ),
  // Multi-Telephone
  ("Multi-Telephone", `Multi-téléphone`),
  ("Host Game", `Héberger jeu`),
  ("Game Code", "Code du jeu"),
  ("Play as Host", `Jouer en tant qu'hôte`),
  ("Play as Guest", `Jouer en tant qu'invité`),
  ("Start Hosting", `Commencer à héberger`),
  ("Stop Hosting", `Arrêter d'héberger`),
  ("Malformed code", `Code mal formé`),
  ("Game not found", `Jeu non trouvé`),
  ("Not connected", `Non connecté`),
  ("Connecting...", `En train de connecter…`), // ellipsis
  ("Connected.", `Connecté.`),
  ("Leave guest mode", `Quitter mode invité`),
  (
    "You can host a game so that players can join from another smartphone.",
    `Vous pouvez héberger un jeu que d'autres joueurs peuvent rejoindre depuis un autre smartphone.`,
  ),
  (
    "You can join a game running on another smartphone.",
    `Vous pouvez rejoindre un jeu en cours sur un autre smartphone.`,
  ),
  (
    `Take the other smartphone and look in the app under Multi-Telephone → Play as Host. Then enter the game code here.`,
    `Prenez l'autre smartphone et regardez dans l'application sous Multi-téléphone → Jouer en tant qu'hôte. Puis, saisissez le code du jeu ici.`,
  ),
  (
    "It is possible to join this game from another smartphone.",
    `Il est possible de rejoindre ce jeu à partir d'un autre smartphone.`,
  ),
  (
    `Take the other smartphone and look in the app under Multi-Telephone → Play as Guest. Then enter the following game code there.`,
    `Prenez l'autre smartphone et regardez dans l'application sous Multi-téléphone → Jouer en tant qu'invité. Puis, saisissez le code du jeu suivant là-bas.`,
  ),
  ("You are currently hosting a game.", `Vous hébergez actuellement un jeu.`),
  (
    "If you want to join a running game, you must stop hosting first.",
    `Si vous souhaitez rejoindre un jeu en cours, il faut d'abord arrêter d'héberger.`,
  ),
  (
    "If you want to host a game so that others can join, you should leave guest mode first.",
    `Si vous souhaitez héberger un jeu afin que d'autres joueurs puissent le rejoindre, if faut d'abord quitter le mode invité.`,
  ),
  ("", ""),
  ("No authorization to use the camera", `Pas autorisé à utiliser la caméra`), // contains nbsp
  (
    "Please authorize the use of the camera to scan a QR code",
    `Veuillez autoriser l'utilisation de la caméra pour scanner un code QR`,
  ),
  // Credits
  ("Credits", `Crédits`),
  ("Game:", "Jeu:"),
  ("Rulebook", `Règles du jeu`),
  ("website", "site web"),
  ("version", "version"),
  ("For use with the game: ", "Pour utiliser avec le jeu: "),
  ("App: ", "App: "),
  ("Libraries: ", `Bibliothèques: `),
  ("Sound effects: ", "Effets sonores: "),
  ("Voice actors: ", "Acteurs de voix: "),
  ("Images: ", "Images: "),
  ("Music: ", "Musique: "),
  ("Licensed under", "Sous licence"),
  // Day
  ("Daytime", `La journée`),
  ("Dawn,", "L'aube,"),
  ("one witch", `une sorcière`),
  ("several witches", `plusieurs sorcières`),
  ("Night,", "La nuit,"),
  ("with constable", `avec shérif`),
  ("without constable", `sans shérif`),
  ("Dawn, one witch", `L'aube, une sorcière`),
  ("Dawn, several witches", `L'aube, plusieurs sorcières`),
  ("Night with constable", `Nuit avec shérif`),
  ("Night without constable", `Nuit sans shérif`),
  ("Waiting for the host to announce nighttime...", `En attendant que l'hôte annonce la nuit...`),
  // Dawn / Night
  ("Dawn", "L'aube"),
  ("Night", "La nuit"),
  ("The witches", `Les sorcières`),
  ("The witch's turn", `Le tour de la sorcière`),
  ("The witches' turn", `Le tour des sorcières`),
  ("Decide-SG who should get the black cat:", `Décide qui devrait avoir le chat noir:`), // contains nbsp
  ("Decide-PL who should get the black cat:", `Décidez qui devrait avoir le chat noir:`), // contains nbsp
  ("Choose-SG a victim:", "Choisis une victime:"),
  ("Choose-PL a victim:", "Choisissez une victime:"),
  ("The constable", `Le shérif`),
  ("The constable's turn", `Le tour du shérif`),
  ("Choose someone to protect:", `Choisis un protégé:`),
  ("Abort", `Arrêter`),
  ("Skip", "Sauter"),
  ("Everybody is sound asleep... what about you?", `Tout le monde dort profondément... et toi?`), // contains nbsp
  // Confirm
  ("Witch, are you sure?", `Sorcière, tu es sûre?`),
  ("Witches, are you sure?", `Les sorcières, vous êtes sûres?`),
  ("Constable, are you sure?", `Shérif, tu es sûr?`),
  ("Confirm", "Confirmer"),
  ("Yes", "Oui"),
  ("No", "Non"),
  // Error
  ("Error", "Erreur"),
  ("Unable to load audio", `Impossible de télécharger le fichier audio`),
  ("Index out of bounds", `Index hors de portée`),
  // Confess
  ("Confess", "L'aveu"),
  ("Everyone,", "Les joueurs,"),
  ("decide whether you want to confess", `décidez si vous voulez avouer`),
  // Reveal
  ("The Reveal", `La révélation`),
  ("Click to show:", `Cliquez pour montrer:`),
  ("Reveal witch's victim", `Révéler victime de la sorcière`),
  ("Reveal witches' victim", `Révéler victime des sorcières`),
  ("The witch attacked-PRE", `La sorcière a attaqué`),
  ("The witch attacked-POST", ""),
  ("The witches attacked-PRE", `Les sorcières ont attaqué`),
  ("The witches attacked-POST", ""),
  (" got the black cat", " a eu le chat noir"),
  ("Reveal constable's protection", `Révéler protégé du shérif`),
  ("The constable protected-PRE", `Le shérif a protégé`),
  ("The constable protected-POST", ""),
])