/**
 * Locale: pt_BR
 */

let table = Js.Dict.fromArray([
  // TitlePage
  ("New Game", "Novo jogo"),
  ("Start Game", `Começar jogo`),
  ("Play Game", "Jogar"),
  ("Join Game", "Entrar jogo"),
  ("Play", "Jogar"),
  ("Settings", `Configu­rações`), // soft hyphen
  ("Exit", "Sair"),
  // Setup
  ("Players", "Jogadores"),
  ("Names", "Nomes"),
  (
    "Enter the names of the players in clockwise order, starting at the head of the table.",
    `Por favor, insira os nomes dos jogadores em sentido horário, começando na cabeceira da mesa.`,
  ),
  (
    "During the night, player buttons will be shown in this order.",
    `Durante a noite, os botões dos jogadores serão mostrados nesta ordem.`,
  ),
  ("(add one)", "(mais um)"),
  ("Ghost Players", "Jogadores fantasmas"),
  (
    `In a two- or three-player game, nicknames for "ghost" players should be added to the list above up to a total of four players.`,
    `Em um jogo para dois ou três jogadores, apelidos para jogadores “fantasmas” devem ser adicionados à lista acima, até um total de quatro jogadores.`,
  ),
  ("Please consult the ", "Por favor consulte as "),
  ("rules for 2-3 players.", "regras para 2-3 jogadores."),
  ("Also check the box below.", `Marque também a caixa abaixo.`),
  ("With Ghosts", "Com fantasmas"),
  ("Sound effects", "Efeitos sonoros"),
  ("Speech", "Discurso"),
  ("Music", `Música`),
  ("Seating layout", `Disposição dos assentos`),
  (
    "How are the players seated around the table?",
    `Como estão os jogadores sentados à volta da mesa?`,
  ),
  (
    "This affects the positioning of the player buttons at night.",
    `Isto afeta o posiciona­mento dos botões dos jogadores durante a noite.`,
  ),
  ("Language", "Linguagem"),
  ("English", "English"),
  ("Nederlands", "Nederlands"),
  ("Deutsch", "Deutsch"),
  (`Français`, `Français`),
  (`Español`, `Español`),
  ("Italiano", "Italiano"),
  ("Interface only, no dialogue yet", `Apenas interface, sem diálogo ainda`),
  ("Back", "Voltar"),
  ("Next", `Avançar`),
  ("Done", "Feito"),
  ("OK", "OK"),
  (
    "Check the boxes to compose a playlist for the nights. Each successive night, the next track from the playlist will be played.",
    `Marque as caixas para compor uma playlist para as noites. A cada noite sucessiva, a próxima faixa da lista de reprodução será reproduzida.`,
  ),
  // Multi-Telephone
  ("Multi-Telephone", "Multi-telefone"),
  ("Host Game", "Hospedar jogo"),
  ("Game Code", `Código de jogo`),
  ("Play as Host", `Jogar como anfitrião`),
  ("Play as Guest", "Jogar como visitante"),
  ("Start Hosting", `Começar a hospedar`),
  ("Stop Hosting", "Parar de hospedar"),
  ("Malformed code", `Código malformado`),
  ("Game not found", `Jogo não encontrado`),
  ("Not connected", `Não conectado`),
  ("Connecting...", "Conectando..."),
  ("Connected.", "Conectado."),
  ("Leave guest mode", "Sair do modo visitante"),
  (
    "You can host a game so that players can join from another smartphone.",
    `Você pode hospedar um jogo para que os jogadores possam participar de outro smartphone`,
  ),
  (
    "You can join a game running on another smartphone.",
    `Você pode entrar em um jogo em execução em outro smartphone.`,
  ),
  (
    `Take the other smartphone and look in the app under Multi-Telephone → Play as Host. Then enter the game code here.`,
    `Pegue o outro smartphone e procure no aplicativo em Multi-telefone → Jogar como anfitrião. Em seguida, insira o código do jogo aqui.`,
  ),
  (
    "It is possible to join this game from another smartphone.",
    `É possível entrar neste jogo a partir de outro smartphone.`,
  ),
  (
    `Take the other smartphone and look in the app under Multi-Telephone → Play as Guest. Then enter the following game code there.`,
    `Pegue o outro smartphone e procure no aplicativo em Multi-telefone → Jogar como visitante. Em seguida, insira o seguinte código do jogo.`,
  ),
  ("You are currently hosting a game.", `Você está hospedando um jogo no momento.`),
  (
    "If you want to join a running game, you must stop hosting first.",
    `Se você deseja entrar em um jogo em execução, primeiro você deve parar de hospedar.`,
  ),
  (
    "If you want to host a game so that others can join, you should leave guest mode first.",
    `Se você deseja hospedar um jogo para que outros possam participar, você deve primeiro sair do modo visitante.`,
  ),
  ("", ""),
  ("No authorization to use the camera", `Sem autorização para usar a câmera`), // contains nbsp
  (
    "Please authorize the use of the camera to scan a QR code",
    `Por favor, autorize o uso da câmera para ler um código QR`, // contains nbsp
  ),
  // Credits
  ("Credits", `Créditos`),
  ("Game:", "Jogo:"),
  ("Rulebook", "Livro de regras"),
  ("website", "website"), // TODO
  ("version", `versão`),
  ("For use with the game: ", "Para usar com o jogo: "),
  ("App: ", "App: "),
  ("Libraries: ", "Bibliotecas: "),
  ("Sound effects: ", "Efeitos sonoros: "),
  ("Voice actors: ", "Dubladores: "),
  ("Images: ", "Imagens: "),
  ("Music: ", `Música: `),
  ("Licensed under", "Licenciado sob"),
  // Day
  ("Daytime", "O dia"),
  ("Dawn,", "O amanhecer,"),
  ("one witch", "one witch"), // TODO
  ("several witches", "several witches"),
  ("Night,", "A noite,"),
  ("with constable", "with constable"),
  ("without constable", "without constable"),
  ("Dawn, one witch", "Dawn, one witch"),
  ("Dawn, several witches", "Dawn, several witches"),
  ("Night with constable", "Night with constable"),
  ("Night without constable", "Night without constable"),
  ("Waiting for the host to announce nighttime...", `Esperando o anfitrião anunciar a noite...`),
  // Dawn / Night
  ("Dawn", "O amanhecer"),
  ("Night", "A noite"),
  ("The witches", "The witches"),
  ("The witch's turn", "The witch's turn"),
  ("The witches' turn", "The witches' turn"),
  ("Decide-SG who should get the black cat:", `Decida quem deve ficar com o gato preto:`), // contains nbsp
  ("Decide-PL who should get the black cat:", `Decidam quem deve ficar com o gato preto:`), // contains nbsp
  ("Choose-SG a victim:", `Escolha uma vítima:`),
  ("Choose-PL a victim:", `Escolham uma vítima:`),
  ("The constable", "The constable"),
  ("The constable's turn", "The constable's turn"),
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
  ("Everyone,", "Everyone,"),
  ("decide whether you want to confess", "decide whether you want to confess"),
  // Reveal
  ("The Reveal", "The Reveal"),
  ("Click to show:", "Click to show:"),
  ("Reveal witch's victim", "Reveal witch's victim"),
  ("Reveal witches' victim", "Reveal witches' victim"),
  ("The witch attacked-PRE", "The witch attacked"),
  ("The witch attacked-POST", ""),
  ("The witches attacked-PRE", "The witches attacked"),
  ("The witches attacked-POST", ""),
  (" got the black cat", ` got the black cat`), // contains nbsp
  ("Reveal constable's protection", "Reveal constable's protection"),
  ("The constable protected-PRE", "The constable protected"),
  ("The constable protected-POST", ""),
])