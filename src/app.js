/** ****************************************************************************
 * App
 *
 * Bridges ReScript to JavaScript
 */

/** **********************************************************************
 * Imports
 */

import { version } from '../package.json';
import QRCode from 'davidshimjs-qrcodejs';
import parseQrCode from 'qrcode-parser';
import * as Main from './Main.res.js';

/** **********************************************************************
 * Make some variables available for Rescript
 */

window.salemAppVersion = version;

// QR code generator
window.QRCode = QRCode
window.createQrCode = (domNode, params) => new window.QRCode(domNode, params);

// QR code parser
window.parseQrCode = parseQrCode;

/** **********************************************************************
 * Run the game. Specify the game's DOM node id.
 */

Main.run('root');

