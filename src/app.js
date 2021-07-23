
/** ****************************************************************************
 * App
 *
 * Bridges ReScript to JavaScript
 */

import * as Main from './Main.bs'

/** **********************************************************************
 * Register serviceworker if supported
 */

/*
if ('serviceWorker' in navigator) {
    window.addEventListener('load', () => {
        navigator.serviceWorker
            .register('/serviceworker.js')
            .then((registration) => {
                console.log('ServiceWorker registered with scope', registration.scope);
            })
            .catch((err) => {
                console.log('ServiceWorker registration failed:', err);
            });
    })
}
*/

/** **********************************************************************
 * Run the game. Specify the game's DOM node.
 */

Main.run('root')

