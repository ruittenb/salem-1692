/**
 * Locale: uk_UA
 */

let table = Js.Dict.fromArray([
  // TitlePage
  ("New Game", `Нова гра`),
  ("Start Game", `Почни гру`),
  ("Play Game", `Грати у гру`),
  ("Join Game", `Приєднуйся до гри`),
  ("Play", `Грати`),
  ("Settings", `Налашту­вання`),
  ("Exit", `Вихід`),
  // Setup
  ("Players", `Гравці`),
  ("Names", `Імена`),
  (
    "Enter the names of the players in clockwise order, starting at the head of the table.",
    `Будь ласка, введіть імена гравців за годинниковою стрілкою, починаючи з голови столу.`,
  ),
  (
    "During the night, player buttons will be shown in this order.",
    `Протягом ночі кнопки гравців відображатимуться в такому порядку.`,
  ),
  ("(add one)", `(додати один)`),
  ("Ghost Players", `Гравці-привиди`),
  (
    `In a two- or three-player game, nicknames for "ghost" players should be added to the list above up to a total of four players.`,
    `У грі з двома або трьома гравцями псевдоніми гравців-«привидів» слід додати до списку вище, загалом до чотирьох гравців.`,
  ), // soft hyphen
  ("Also check the box below.", `Також поставте прапорець нижче.`),
  ("Please consult the ", `Ознайомтеся з `),
  ("rules for 2-3 players.", `правилами для 2-3 гравців.`),
  ("With Ghosts", `З привидами`),
  ("Sound effects", `Звукові ефекти`),
  ("Speech", `Діалог`),
  ("Music", `Музика`),
  ("Seating layout", `Схема сидіння`),
  (
    "How are the players seated around the table?",
    `Як розташовуються гравці за столом?`,
  ),
  (
    "This affects the positioning of the player buttons at night.",
    `Це впливає на розташу­вання кнопок плеєра вночі.`,
  ),
  ("Language", `Мова`),
  ("English", "English"),
  ("Nederlands", "Nederlands"),
  ("Deutsch", "Deutsch"),
  (`Français`, `Français`),
  (`Español`, `Español`),
  (`Português`, `Português`),
  ("Italiano", "Italiano"),
  (`Українська`, `Українська`),
  (
    "Interface only, no dialogue yet",
    `Лише інтерфейс, поки що немає діалогу`,
  ),
  ("Back", `Назад`),
  ("Next", `Далі`),
  ("Done", `Готово`),
  ("OK", `В порядку`),
  (
    "Check the boxes to compose a playlist for the nights. Each successive night, the next track from the playlist will be played.",
    `Поставте прапорці, щоб скласти список відтворення на ніч. Кожного наступного вечора буде відтворюватися наступний трек зі списку відтворення.`,
  ),
  // Multi-Telephone
  ("Multi-Telephone", `Мульти-телефон`),
  ("Host Game", `Провести гру`),
  ("Game Code", `Код гри`),
  ("Play as Host", `Грати як господар`),
  ("Play as Guest", `Грати як гість`),
  ("Start Hosting", `Почати хостинг`),
  ("Stop Hosting", `Зупинити хостинг`),
  ("Malformed code", `Неправильний код`),
  ("Game not found", `Гра не знайдена`),
  ("Not connected", `Не підключений`),
  ("Connecting...", `Підключення…`),
  ("Connected.", `Підключено.`),
  ("Leave guest mode", `Вийти з гостьового режиму`),
  (
    "You can host a game so that players can join from another smartphone.",
    `Ви можете розмістити гру, щоб гравці могли приєднатися з іншого смартфона.`,
  ),
  (
    "You can join a game running on another smartphone.",
    `Ви можете приєднатися до гри, яка працює на іншому смартфоні.`,
  ),
  (
    `Take the other smartphone and look in the app under Multi-Telephone → Play as Host. Then enter the game code here.`,
    `Візьміть інший смартфон і подивіться в додатку в розділі Мульти-телефон → Грати як господар. Потім введіть тут код гри.`,
  ),
  (
    "It is possible to join this game from another smartphone.",
    `До цієї гри можна приєднатися з іншого смартфона.`,
  ),
  (
    `Take the other smartphone and look in the app under Multi-Telephone → Play as Guest. Then enter the following game code there.`,
    `Візьміть інший смартфон і подивіться в програмі в розділі Мульти-телефон → Грати як гість. Потім введіть туди наступний код гри.`,
  ),
  ("You are currently hosting a game.", `Ви зараз розміщуєте гру.`),
  (
    "If you want to join a running game, you must stop hosting first.",
    `Якщо ви хочете приєднатися до запущеної гри, ви повинні спершу припинити розміщення.`,
  ),
  (
    "If you want to host a game so that others can join, you should leave guest mode first.",
    `Якщо ви хочете провести гру, щоб інші могли приєднатися, вам слід спочатку вийти з режиму гостя.`,
  ),
  ("", ""),
  (
    "No authorization to use the camera",
    `Немає дозволу на використання камери`,
  ),
  (
    "Please authorize the use of the camera to scan a QR code",
    `Будь ласка, авторизуйте використання камери для сканування QR-коду`,
  ),
  // Credits
  ("Credits", `Кредити`),
  ("Game:", `Гра:`),
  ("Rulebook", `Правильник`),
  ("website", `веб-сайт`),
  ("version", `версія`),
  ("For use with the game: ", `Для використання з грою: `),
  ("App: ", `Мобільний застосунок: `),
  ("Libraries: ", `Бібліотеки: `),
  ("Sound effects: ", `Звукові ефекти: `),
  ("Voice actors: ", `Актори озвучування: `),
  ("Images: ", `Зображення: `),
  ("Music: ", `Музика: `),
  ("Licensed under", `Ліцензія згідно`),
  // Day
  ("Daytime", "A day in Salem"),
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
  ("Citizens of Salem,", "Citizens of Salem,"),
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