/**
 * Locale: pt_BR
 */
let table = Js.Dict.fromArray([
  // TitlePage
  ("New Game", "Novo jogo"),
  ("Start Game", `Começar jogo`),
  ("Play Game", "Jogar"),
  ("Join Game", "Entrar no jogo"),
  ("Play", "Jogar"),
  ("Settings", `Configu­rações`), // soft hyphen
  ("Exit", "Sair"),
  // Setup
  ("Players", "Jogadores"),
  ("Names", "Nomes"),
  (
    "Enter the names of the players in clockwise order, starting at the head of the table.",
    `Insira os nomes dos jogadores em sentido horário, começando pela cabeça da mesa.`,
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
  ("Also check the box below.", `Marque também a caixa abaixo.`),
  ("Please consult the ", "Consulte as "),
  ("rules for 2-3 players.", "regras para 2-3 jogadores."),
  ("With Ghosts", "Com fantasmas"),
  ("Sound effects", "Efeitos sonoros"),
  ("Speech", "Discurso"),
  ("Music", `Música`),
  ("Seating layout", `Disposição dos assentos`),
  (
    "How are the players seated around the table?",
    `Como os jogadores estão sentados em volta da mesa?`,
  ),
  (
    "This affects the positioning of the player buttons at night.",
    `Isto afeta o posiciona­mento dos botões dos jogadores durante a noite.`,
  ),
  ("Language", "Linguagem"),
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
    `Você pode hospedar um jogo para que os jogadores possam participar usando outro smartphone`,
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
  ("No authorization to use the camera", `Não autorização para usar a câmera`), // contains nbsp
  (
    "Please authorize the use of the camera to scan a QR code",
    `Autorize o uso da câmera para ler um código QR`, // contains nbsp
  ),
  // Credits
  ("Credits", `Créditos`),
  ("Game:", "Jogo:"),
  ("Rulebook", "Livro de regras"),
  ("website", "website"),
  ("version", `versão`),
  ("For use with the game: ", "Para usar com o jogo: "),
  ("App: ", "Aplicativo: "),
  ("Libraries: ", "Bibliotecas: "),
  ("Sound effects: ", "Efeitos sonoros: "),
  ("Voice actors: ", "Dubladores: "),
  ("Images: ", "Imagens: "),
  ("Music: ", `Música: `),
  ("Licensed under ", "Licenciado sob "),
  // Day
  ("A day in Salem", `Um dia em Salém`),
  ("Dawn,", "O amanhecer,"),
  ("one witch", "uma bruxa"),
  ("several witches", `várias bruxas`),
  ("Night,", "A noite,"),
  ("with constable", "com vigilante"),
  ("without constable", "sem vigilante"),
  ("Dawn, one witch", "O amanhecer, uma bruxa"),
  ("Dawn, several witches", `O amanhecer, várias bruxas`),
  ("Night with constable", "Noite com vigilante"),
  ("Night without constable", "Noite sem vigilante"),
  ("Waiting for the host to announce nighttime...", `Esperando o anfitrião anunciar a noite...`),
  // Dawn / Night
  ("Dawn", "O amanhecer"),
  ("Night", "A noite"),
  ("The witches", "As bruxas"),
  ("The witch's turn", "A vez da bruxa"),
  ("The witches' turn", "A vez das bruxas"),
  ("Decide-SG who should get the black cat:", `Decida quem deve ficar com o gato preto:`), // contains nbsp
  ("Decide-PL who should get the black cat:", `Decidam quem deve ficar com o gato preto:`), // contains nbsp
  ("Choose-SG a victim:", `Escolha uma vítima:`),
  ("Choose-PL a victim:", `Escolham uma vítima:`),
  ("The constable", "O vigilante"),
  ("The constable's turn", "A vez do vigilante"),
  ("Choose another player to protect:", "Escolha outro jogador para proteger:"),
  ("Choose someone to protect:", `Escolha alguém para proteger`),
  ("Abort", "Abortar"),
  ("Skip", "Pular"),
  ("Everybody is sound asleep... what about you?", `Todo mundo está dormindo... e você?`), // contains nbsp
  // Confirm
  ("Witch, are you sure?", `Bruxa, você tem certeza?`),
  ("Witches, are you sure?", `Bruxas, vocês têm certeza?`),
  ("Constable, are you sure?", `Vigilante, você tem certeza?`),
  ("Confirm", "Confirmar"),
  ("Yes", "Sim"),
  ("No", `Não`),
  // Error
  ("Error", "Erro"),
  ("Unable to load audio", `Não foi possível carregar o áudio`),
  ("Index out of bounds", `Índice fora dos limites`),
  // Confess
  ("Confess", `A confissão`),
  ("Residents of Salem,", `Cidadãos de Salém,`),
  (
    "those among you who wish to confess may now do so.",
    `aqueles entre vocês que desejam, podem agora confessar.`,
  ),
  // Reveal
  ("The Reveal", `A revelação`),
  (
    "Find out what happened while you were sleeping.",
    `Descubram o que aconteceu enquanto vocês dormiam.`,
  ),
  ("Reveal witch's victim", `Revelar a vítima da bruxa`),
  ("Reveal witches' victim", `Revelar a vítima das bruxas`),
  ("The witch attacked-PRE", "A bruxa atacou "),
  ("The witch attacked-POST", ""),
  ("The witches attacked-PRE", "As bruxas atacaram "),
  ("The witches attacked-POST", ""),
  (" got the black cat", ` pegou o gato preto`), // contains nbsp
  (`Reveal constable's protégé`, `Revelar o protegido do vigilante`),
  ("The constable protected-PRE", "O vigilante protegeu "),
  ("The constable protected-POST", ""),
])
