/**
 * Locale: fr_FR
 */
let table = Js.Dict.fromArray([
  // TitlePage
  ("New Game", "Nouvelle partie"),
  ("Start Game", "Lancer la partie"),
  ("Play Game", "Jouer"),
  ("Join Game", "Rejoindre une partie"),
  ("Play", "Jouer"),
  ("Settings", `Configu­ration`), // soft hyphen
  ("Exit", "Fermer"),
  // Setup
  ("Players", "Joueurs"),
  ("Names", "Noms"),
  (
    "Enter the names of the players in clockwise order, starting at the head of the table.",
    `Saisissez les noms des joueurs dans le sens des aiguilles d'une montre, en commençant par la personne assise en bout de table.`,
  ),
  (
    "During the night, player buttons will be shown in this order.",
    `Pendant la Nuit, les boutons des joueurs s'afficheront dans l'ordre renseigné ci-dessous.`,
  ),
  ("(add one)", "(Ajouter un joueur)"),
  ("Ghost Players", `Joueurs fantômes`),
  (
    `In a two- or three-player game, nicknames for "ghost" players should be added to the list above up to a total of four players.`,
    `Lors d’une partie à 2 ou 3 joueurs, ajoutez des « fantômes » jusqu'à atteindre un total de 4 joueurs et entrez leurs noms dans la liste.`,
  ),
  ("Also check the box below.", `Veuillez également cocher la case ci-dessous `),
  ("Please consult the ", "et lire les "),
  ("rules for 2-3 players.", `Règles pour 2-3 joueurs.`),
  ("With Ghosts", `Avec fantômes`),
  ("Sound effects", "Effets sonores"),
  ("Speech", "Discours"),
  ("Music", "Musique"),
  ("Stay active", `Rester actif`),
  (
    "This keeps the screen active during the night, so that other players cannot see whether you used your phone.",
    `Ceci maintient l'écran actif pendant la nuit, afin que les autres joueurs ne puissent pas voir si vous avez utilisé votre téléphone.`,
  ),
  ("Seating layout", `Disposition des sièges`),
  (
    "How are the players seated around the table?",
    `Comment les joueurs sont-ils assis autour de la table ?`,
  ),
  (
    "This affects the positioning of the player buttons at night.",
    `Cela affecte la position de leurs boutons pendant la Nuit.`,
  ),
  ("Language", "Langue"),
  ("Interface only, no dialogue yet", "Interface uniquement, pas encore de dialogue"),
  ("Back", "Retour"),
  ("Next", "Suivant"),
  ("Done", `Prêt`),
  ("OK", "OK"),
  (
    "Check the boxes to compose a playlist for the nights. Each successive night, the next track from the playlist will be played.",
    `Cochez les cases afin de composer une playlist thématique, dont les pistes seront jouées successivement au fil des Nuits.`,
  ),
  // Multi-Telephone
  ("Multi-Telephone", `Multi-téléphone`),
  ("Host Game", `Héberger une partie`),
  ("Game Code", "Code de la partie"),
  ("Play as Host", `Jouer en tant qu'hôte`),
  ("Play as Guest", `Jouer en tant qu'invité`),
  ("Start Hosting", `Commencer à héberger`),
  ("Stop Hosting", `Arrêter d'héberger`),
  ("Malformed code", `Code erroné`),
  ("Game not found", `Partie non trouvée`),
  ("Not connected", `Non connecté`),
  ("Connecting...", `Connexion en cours…`), // ellipsis
  ("Connected.", `Connecté`),
  ("Leave guest mode", `Quitter le mode invité`),
  (
    "You can host a game so that players can join from another smartphone.",
    `Vous pouvez héberger une partie afin que d'autres joueurs la rejoignent depuis un autre smartphone.`,
  ),
  (
    "You can join a game running on another smartphone.",
    `Vous pouvez rejoindre une partie en cours sur un autre smartphone.`,
  ),
  (
    `Take the other smartphone and look in the app under Multi-Telephone → Play as Host. Then enter the game code here.`,
    `Prenez l'autre smartphone, allez dans le menu « Multi-téléphone → Jouer en tant qu'hôte » sur l'application, puis saisissez ci-dessous le code de partie indiqué là-bas.`,
  ),
  (
    "It is possible to join this game from another smartphone.",
    `Il est possible de rejoindre cette partie depuis un autre smartphone.`,
  ),
  (
    `Take the other smartphone and look in the app under Multi-Telephone → Play as Guest. Then enter the following game code there.`,
    `Prenez l'autre smartphone, allez dans le menu « Multi-téléphone → Jouer en tant qu'invité » sur l'application, puis saisissez là-bas le code de partie indiqué ci-dessous.`,
  ),
  ("You are currently hosting a game.", `Vous hébergez actuellement une partie.`),
  (
    "If you want to join a running game, you must stop hosting first.",
    `Si vous souhaitez rejoindre une partie en cours, vous devez d'abord arrêter d'héberger.`,
  ),
  (
    "If you want to host a game so that others can join, you should leave guest mode first.",
    `Si vous souhaitez héberger une partie afin que d'autres joueurs puissent la rejoindre, vous devez d'abord quitter le mode invité.`,
  ),
  ("", ""),
  ("No authorization to use the camera", `Autorisation manquante pour l'appareil photo`), // contains nbsp
  (
    "Please authorize the use of the camera to scan a QR code",
    `Veuillez autoriser l'utilisation de l'appareil photo pour scanner un QR code`,
  ),
  // Credits
  ("Credits", `Crédits`),
  ("Game:", `Jeu :`),
  ("Rulebook", `Livret de règles`),
  ("website", "site web"),
  ("version", "version"),
  ("For use with the game: ", `À utiliser avec le jeu : `),
  ("App: ", `Application : `),
  ("Libraries: ", `Bibliothèques : `),
  ("Sound effects: ", `Effets sonores : `),
  ("Voice actors: ", `Doubleurs : `),
  ("Images: ", `Images : `),
  ("Music: ", `Musique : `),
  ("Licensed under ", "Sous licence "),
  // Day
  ("A day in Salem", `Une journée à Salem`),
  ("Dawn,", "L'Aube,"),
  ("one witch", `une seule Sorcière`),
  ("several witches", `plusieurs Sorcières`),
  ("Night,", "La Nuit,"),
  ("with constable", `avec Prévôt`),
  ("without constable", `sans Prévôt`),
  ("Dawn, one witch", `L'Aube, une seule Sorcière`),
  ("Dawn, several witches", `L'Aube, plusieurs Sorcières`),
  ("Night with constable", `La Nuit, avec Prévôt`),
  ("Night without constable", `La Nuit, sans Prévôt`),
  ("Waiting for the host to announce nighttime...", `En attendant que l'hôte annonce la Nuit...`),
  // Dawn / Night
  ("Dawn", "L'Aube"),
  ("Night", "La Nuit"),
  ("The witches", `Les Sorcières`),
  ("The witch's turn", `Action de la Sorcière`),
  ("The witches' turn", `Action des Sorcières`),
  ("Decide-SG who should get the black cat:", `Décidez qui recevra le Chat noir :`), // contains nbsp
  ("Decide-PL who should get the black cat:", `Décidez qui recevra le Chat noir :`), // contains nbsp
  ("Choose-SG a victim:", `Choisissez une victime :`),
  ("Choose-PL a victim:", `Choisissez une victime :`),
  ("The constable", `Le Prévôt`),
  ("The constable's turn", `Action du Prévôt`),
  ("Choose another player to protect:", `Choisissez un autre joueur à protéger :`),
  ("Choose someone to protect:", `Choisissez un joueur à protéger :`),
  ("Abort", `Arrêter`),
  ("Skip", "Passer"),
  (
    "Everybody is sound asleep... what about you?",
    `Tout le monde dort profondément... et vous ?`,
  ), // contains nbsp
  // Confirm
  ("Witch, are you sure?", `Sorcière, êtes-vous sûre ?`),
  ("Witches, are you sure?", `Sorcières, êtes-vous sûres ?`),
  ("Constable, are you sure?", `Prévôt, êtes-vous sûr ?`),
  ("Confirm", "Confirmer"),
  ("Yes", "Oui"),
  ("No", "Non"),
  // Error
  ("Error", "Erreur"),
  ("Unable to load audio", `Impossible de télécharger le fichier audio`),
  ("Index out of bounds", `Impossible d'accéder à l'index`),
  // Confess
  ("Confess", "La confession"),
  ("Residents of Salem,", "Citoyens de Salem,"),
  (
    "those among you who wish to confess may now do so.",
    `ceux d'entre vous qui le souhaitent peuvent se confesser.`,
  ),
  // Reveal
  ("The Reveal", `La révélation`),
  (
    "Find out what happened while you were sleeping.",
    `Découvrez ce qui s'est passé pendant que vous dormiez.`,
  ),
  ("Reveal witch's victim", `Révéler la victime de la Sorcière`),
  ("Reveal witches' victim", `Révéler la victime des Sorcières`),
  ("The witch attacked-PRE", `La Sorcière s'en est prise à `),
  ("The witch attacked-POST", ""),
  ("The witches attacked-PRE", `Les Sorcières s'en sont prises à `),
  ("The witches attacked-POST", ""),
  (" got the black cat", ` a reçu le Chat noir`),
  (`Reveal constable's protégé`, `Révéler le protégé du Prévôt`),
  ("The constable protected-PRE", `Le Prévôt a sauvé `),
  ("The constable protected-POST", ""),
  ("Nobody-SUBJ", "Personne"),
  ("nobody-OBJ", /* ne */ "personne"),
  ("The constable did not protect anybody", `Le Prévôt n'a sauvé personne`),
])
