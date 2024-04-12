/**
 * Locale: th_TH
 *
 * Note: this is a machine translation that needs to be reviewed
 */
let table = Js.Dict.fromArray([
  // TitlePage
  ("New Game", `เกมใหม่`),
  ("Start Game", `เริ่มเกม`),
  ("Play Game", `เล่นเกม`),
  ("Join Game", `เข้าร่วมเกม`),
  ("Play", `เล่น`),
  ("Settings", `การตั้งค่า`),
  ("Exit", `ออก`),
  // Setup
  ("Players", `ผู้เล่น`),
  ("Names", `ชื่อ`),
  (
    "Enter the names of the players in clockwise order, starting at the head of the table.",
    `กรอกชื่อผู้เล่นตามเข็มนาฬิกา โดยเริ่มจากหัวโต๊ะ`,
  ),
  (
    "During the night, player buttons will be shown in this order.",
    `ในช่วงกลางคืน ปุ่มผู้เล่นจะแสดงตามลำดับนี้`,
  ),
  ("(add one)", `(เพิ่มหนึ่งรายการ)`),
  ("Ghost Players", `ผู้เล่นผี`),
  (
    `In a two- or three-player game, nicknames for "ghost" players should be added to the list above up to a total of four players.`,
    `ในเกมที่มีผู้เล่นสองหรือสามคน ควรเพิ่มชื่อเล่นของผู้เล่น "ผี" ในรายการด้านบนให้มีผู้เล่นทั้งหมดสี่คน`,
  ),
  (
    "Also check the box below.",
    `ทำเครื่องหมายในช่องด้านล่างด้วย`,
  ),
  ("Please consult the ", `โปรดปรึกษา `),
  ("rules for 2-3 players.", `กฎสำหรับผู้เล่น 2-3 คน`),
  ("With Ghosts", `กับผี`),
  ("Sound effects", `เอฟเฟกต์เสียง`),
  ("Speech", `วาทกรรม`),
  ("Music", `ดนตรี`),
  ("Seating layout", `แผนผังที่นั่ง`),
  (
    "How are the players seated around the table?",
    `ผู้เล่นนั่งรอบโต๊ะอย่างไร`,
  ),
  (
    "This affects the positioning of the player buttons at night.",
    `สิ่งนี้ส่งผลต่อตำแหน่งของปุ่มผู้เล่นในเวลากลางคืน`,
  ),
  ("Language", `ภาษา`),
  (
    "Interface only, no dialogue yet",
    `อินเทอร์เฟซเท่านั้น ยังไม่มีบทสนทนา`,
  ),
  ("Back", `ย้อนกลับ`),
  ("Next", `ถัดไป`),
  ("Done", `เสร็จสิ้น`),
  ("OK", `ตกลง`),
  (
    "Check the boxes to compose a playlist for the nights. Each successive night, the next track from the playlist will be played.",
    `ทำเครื่องหมายที่ช่องเพื่อเขียนเพลย์ลิสต์สำหรับคืนนี้ แต่ละคืนติดต่อกัน เพลงถัดไปจากเพลย์ลิสต์จะถูกเล่น`,
  ),
  // Multi-Telephone
  ("Multi-Telephone", `โทรศัพท์หลายเครื่อง`),
  ("Host Game", `โฮสต์เกม`),
  ("Game Code", `รหัสเกม`),
  ("Play as Host", `เล่นเป็นเจ้าบ้าน`),
  ("Play as Guest", `เล่นในฐานะแขก`),
  ("Start Hosting", `เริ่มโฮสติ้ง`),
  ("Stop Hosting", `หยุดโฮสติ้ง`),
  ("Malformed code", `รหัสมีรูปแบบไม่ถูกต้อง`),
  ("Game not found", `ไม่พบเกม`),
  ("Not connected", `ไม่ได้เชื่อมต่อ`),
  ("Connecting...", `กำลังเชื่อมต่อ...`),
  ("Connected.", `เชื่อมต่อแล้ว`),
  ("Leave guest mode", `ออกจากโหมดผู้มาเยือน`),
  (
    "You can host a game so that players can join from another smartphone.",
    `คุณสามารถโฮสต์เกมเพื่อให้ผู้เล่นสามารถเข้าร่วมจากสมาร์ทโฟนเครื่องอื่นได้`,
  ),
  (
    "You can join a game running on another smartphone.",
    `คุณสามารถเข้าร่วมเกมที่ทำงานบนสมาร์ทโฟนเครื่องอื่นได้`,
  ),
  (
    `Take the other smartphone and look in the app under Multi-Telephone → Play as Host. Then enter the game code here.`,
    `นำสมาร์ทโฟนอีกเครื่องหนึ่งแล้วดูในแอปภายใต้โทรศัพท์หลายเครื่อง → เล่นเป็นโฮสต์ จากนั้นกรอกรหัสเกมที่นี่`,
  ),
  (
    "It is possible to join this game from another smartphone.",
    `เป็นไปได้ที่จะเข้าร่วมเกมนี้จากสมาร์ทโฟนเครื่องอื่น`,
  ),
  (
    `Take the other smartphone and look in the app under Multi-Telephone → Play as Guest. Then enter the following game code there.`,
    `นำสมาร์ทโฟนอีกเครื่องหนึ่งแล้วดูในแอปภายใต้โทรศัพท์หลายเครื่อง → เล่นในฐานะแขก จากนั้นกรอกรหัสเกมต่อไปนี้ที่นั่น`,
  ),
  (
    "You are currently hosting a game.",
    `คุณกำลังโฮสต์เกมอยู่`,
  ),
  (
    "If you want to join a running game, you must stop hosting first.",
    `หากคุณต้องการเข้าร่วมเกมที่กำลังดำเนินอยู่ คุณต้องหยุดการโฮสต์ก่อน`,
  ),
  (
    "If you want to host a game so that others can join, you should leave guest mode first.",
    `หากคุณต้องการโฮสต์เกมเพื่อให้ผู้อื่นสามารถเข้าร่วมได้ คุณควรออกจากโหมดผู้มาเยือนก่อน`,
  ),
  ("", ""),
  (
    "No authorization to use the camera",
    `ไม่ได้รับอนุญาตให้ใช้กล้อง`,
  ),
  (
    "Please authorize the use of the camera to scan a QR code",
    `โปรดอนุญาตให้ใช้กล้องเพื่อสแกนโค้ด QR`,
  ),
  // Credits
  ("Credits", `เครดิต`),
  ("Game:", `เกม:`),
  ("Rulebook", `กฎเกณฑ์`),
  ("website", `เว็บไซต์`),
  ("version", `เวอร์ชัน`),
  ("For use with the game: ", `สำหรับใช้กับเกม: `),
  ("App: ", `แอป: `),
  ("Libraries: ", `ไลบรารี: `),
  ("Sound effects: ", `เอฟเฟกต์เสียง: `),
  ("Voice actors: ", `นักพากย์: `),
  ("Images: ", `รูปภาพ: `),
  ("Music: ", `เพลง: `),
  ("Licensed under ", `ได้รับอนุญาตภายใต้ `),
  // Daytime
  ("A day in Salem", `หนึ่งวันในซาเลม`),
  ("Dawn,", `รุ่งอรุณ`),
  ("one witch", `แม่มดคนหนึ่ง`),
  ("several witches", `แม่มดหลายตัว`),
  ("Night,", `กลางคืน`),
  ("with constable", `กับตำรวจ`),
  ("without constable", `ไม่มีตำรวจ`),
  ("Dawn, one witch", `รุ่งอรุณแม่มดคนหนึ่ง`),
  ("Dawn, several witches", `รุ่งอรุณแม่มดหลายตัว`),
  ("Night with constable", `คืนกับตำรวจ`),
  ("Night without constable", `คืนที่ไม่มีตำรวจ`),
  (
    "Waiting for the host to announce nighttime...",
    `กำลังรอเจ้าภาพประกาศเวลากลางคืน...`,
  ),
  // Dawn / Night
  ("Dawn", `รุ่งอรุณ`),
  ("Night", `กลางคืน`),
  ("The witches", `แม่มด`),
  ("The witch's turn", `ตาของแม่มด`),
  ("The witches' turn", `การกลับมาของแม่มด`),
  (
    "Decide-SG who should get the black cat:",
    `ตัดสินใจว่าใครควรจะได้แมวดำ:`,
  ),
  (
    "Decide-PL who should get the black cat:",
    `ตัดสินใจว่าใครควรจะได้แมวดำ:`,
  ),
  ("Choose-SG a victim:", `เลือกเหยื่อ SG:`),
  ("Choose-PL a victim:", `เลือกเหยื่อ PL:`),
  ("The constable", `ตำรวจ`),
  ("The constable's turn", `ตาของตำรวจ`),
  (
    "Choose another player to protect:",
    `เลือกผู้เล่นอื่นที่จะปกป้อง:`,
  ),
  ("Choose someone to protect:", `เลือกคนที่จะปกป้อง:`),
  ("Abort", `ยกเลิก`),
  ("Skip", `ข้าม`),
  (
    "Everybody is sound asleep... what about you?",
    `ทุกคนหลับไปแล้ว... แล้วคุณล่ะ?`,
  ),
  // Confirm
  ("Witch, are you sure?", `แม่มดคุณแน่ใจเหรอ?`),
  ("Witches, are you sure?", `แม่มดคุณแน่ใจเหรอ?`),
  ("Constable, are you sure?", `ตำรวจคุณแน่ใจเหรอ?`),
  ("Confirm", `ยืนยัน`),
  ("Yes", `ใช่`),
  ("No", `ไม่`),
  // Error
  ("Error", `ข้อผิดพลาด`),
  ("Unable to load audio", `ไม่สามารถโหลดเสียงได้`),
  ("Index out of bounds", `ดัชนีอยู่นอกขอบเขต`),
  // Confess
  ("Confess", `สารภาพ`),
  ("Residents of Salem,", `พลเมืองของซาเลม`),
  (
    "those among you who wish to confess may now do so.",
    `บรรดาผู้ที่ประสงค์จะสารภาพก็สามารถทำได้ในขณะนี้`,
  ),
  // Reveal
  ("The Reveal", `การเปิดเผย`),
  (
    "Find out what happened while you were sleeping.",
    `ค้นหาว่าเกิดอะไรขึ้นในขณะที่คุณหลับอยู่`,
  ),
  ("Reveal witch's victim", `เปิดเผยเหยื่อของแม่มด`),
  ("Reveal witches' victim", `เปิดเผยเหยื่อของแม่มด`),
  ("The witch attacked-PRE", `แม่มดโจมตี-PRE`),
  ("The witch attacked-POST", `แม่มดโจมตี-POST`),
  ("The witches attacked-PRE", `แม่มดโจมตี-PRE`),
  ("The witches attacked-POST", `แม่มดโจมตี-POST`),
  (" got the black cat", ` มีแมวดำ`),
  (
    `Reveal constable's protégé`,
    `เปิดเผยบุตรบุญธรรมของตำรวจ`,
  ),
  (
    "The constable protected-PRE",
    `ตำรวจที่ได้รับการคุ้มครอง-PRE`,
  ),
  (
    "The constable protected-POST",
    `ตำรวจที่ได้รับการคุ้มครอง-POST`,
  ),
  ("Nobody-SUBJ", `ใคร`),
  ("nobody-OBJ", `ใคร`),
  (
    "The constable did not protect anybody",
    `ตำรวจไม่ได้ปกป้องใครเลย`,
  ),
])