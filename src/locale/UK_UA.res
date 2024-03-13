/**
 * Locale: uk_UA
 */

let table = Js.Dict.fromArray([
  // TitlePage
  ("New Game", `Нова гра`),
  ("Start Game", `Почни гру`),
  ("Play Game", `Грати`),
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
    `Поставте прапорці, щоб скласти список відтворення на ніч. Кожного наступного вечора буде відтворю­ватися наступний трек зі списку відтворення.`,
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
  ("Leave guest mode", `Вийти з режиму гостя`),
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
  ("Licensed under ", `Ліцензія згідно `),
  // Day
  ("A day in Salem", `День в Салемі`),
  ("Dawn,", `Світанок,`),
  ("one witch", `одна відьма`),
  ("several witches", `кілька відьом`),
  ("Night,", `Ніч,`),
  ("with constable", `з констеблем`),
  ("without constable", `без констебля`),
  ("Dawn, one witch", `Світанок, одна відьма`),
  ("Dawn, several witches", `Світанок, кілька відьом`),
  ("Night with constable", `Ніч з констеблем`),
  ("Night without constable", `Ніч без констебля`),
  (
    "Waiting for the host to announce nighttime...",
    `Чекаємо, поки ведучий оголосить ніч...`,
  ),
  // Dawn / Night
  ("Dawn", `Світанок`),
  ("Night", `Ніч`),
  ("The witches", `Відьми`),
  ("The witch's turn", `Черга відьми`),
  ("The witches' turn", `Черга відьом`),
  (
    "Decide-SG who should get the black cat:",
    `Виріши, кому дістатися чорного кота:`,
  ), // contains nbsp
  (
    "Decide-PL who should get the black cat:",
    `Вирішуйте, кому дістатися чорного кіта:`,
  ), // contains nbsp
  ("Choose-SG a victim:", `Вибери жертву:`),
  ("Choose-PL a victim:", `Вибирайте жертву:`),
  ("The constable", `Констебль`),
  ("The constable's turn", `Черга констебля`),
  (
    "Choose another player to protect:",
    `Вибери будь-якого іншого гравця для захисту:`,
  ),
  ("Choose someone to protect:", `Вибери когось для захисту:`),
  ("Abort", `Перервати`),
  ("Skip", `Пропустити`),
  ("Everybody is sound asleep... what about you?", `Всі міцно сплять... а ти?`),
  // Confirm
  ("Witch, are you sure?", `Відьма, ти впевнена?`),
  ("Witches, are you sure?", `Відьми, ви впевнені?`),
  ("Constable, are you sure?", `Констебль, ти впевнений?`),
  ("Confirm", `Підтвердити`),
  ("Yes", `Так`),
  ("No", `Немає`),
  // Error
  ("Error", `Помилка`),
  ("Unable to load audio", `Неможливо завантажити аудіо`),
  ("Index out of bounds", `Індекс поза межами`),
  // Confess
  ("Confess", `Сповідатися`),
  ("Citizens of Salem,", `Громадяни Салема,`),
  (
    "those among you who wish to confess may now do so.",
    `ті з вас, хто хоче зізнатися, тепер можуть це зробити.`,
  ),
  // Reveal
  ("The Reveal", `Розкриття`),
  (
    "Find out what happened while you were sleeping.",
    `Дізнайтеся, що сталося, коли ви спали.`,
  ),
  ("Reveal witch's victim", `Розкрийте жертву відьми`),
  ("Reveal witches' victim", `Розкрийте жертву відьом`),
  ("The witch attacked-PRE", `Відьма напала на`),
  ("The witch attacked-POST", ""),
  ("The witches attacked-PRE", `Відьми напали на`),
  ("The witches attacked-POST", ""),
  (" got the black cat", ` отримав чорного кота`), // contains nbsp
  (`Reveal constable's protégé`, `Покажіть, кого захищав констебль`),
  ("The constable protected-PRE", `Констебль захистив`),
  ("The constable protected-POST", ""),
])
