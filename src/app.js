/** ****************************************************************************
 * App
 *
 * Bridges ReScript to JavaScript
 */

// Main Salem Moderator code
import * as Main from './Main.bs';
import qrCodeParser from 'qrcode-parser';

/** **********************************************************************
 * Register serviceworker if supported
 */

const debug = navigator.userAgent.includes('Salem/1692') ? '?debug=1' : '';

if ('serviceWorker' in navigator) {
    window.addEventListener('load', () => {
        navigator.serviceWorker
            .register('serviceworker.js' + debug)
            .then((registration) => {
                console.log('ServiceWorker registered with scope', registration.scope);
            })
            .catch((err) => {
                console.log('ServiceWorker registration failed:', err);
            });
    });
}

/** **********************************************************************
 * Make some variables available for Rescript
 */

window.salemAppVersion = "0.42.2";
window.qrCodeParser = qrCodeParser;

/** **********************************************************************
 * Run the game. Specify the game's DOM node id.
 */

Main.run('root');

