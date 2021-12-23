/** ****************************************************************************
 * App
 *
 * Bridges ReScript to JavaScript
 */

// Main Salem Moderator code
import * as Main from './Main.bs';

import QRCode from 'davidshimjs-qrcodejs';
import parseQrCode from 'qrcode-parser';

// Make some variables available for Rescript
window.salemAppVersion = "0.43.8";

// QR code generator
window.QRCode = QRCode
window.createQrCode = (domNode, params) => new window.QRCode(domNode, params);

// QR code parser
window.parseQrCode = parseQrCode;

/** **********************************************************************
 * Run the game. Specify the game's DOM node id.
 */

Main.run('root');

