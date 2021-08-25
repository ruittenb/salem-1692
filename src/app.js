
/** ****************************************************************************
 * App
 *
 * Bridges ReScript to JavaScript
 */

import * as Main from './Main.bs'

/*
if ('serviceWorker' in navigator) {
    window.addEventListener('load', () => {
        navigator.serviceWorker.register('serviceworker.js').then(() => {
            console.log('Service Worker Registered')
        })
    })
}
*/

Main.run('root')

