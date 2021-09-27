
/** ****************************************************************************
 * App
 *
 * Bridges ReScript to JavaScript
 */

// Main Salem Moderator code
import * as Main from './Main.bs';

// Import the Firebase functions we need
import { initializeApp } from 'firebase/app';
import { getDatabase, ref, onValue } from 'firebase/database';

/** **********************************************************************
 * Register serviceworker if supported
 */

if ('serviceWorker' in navigator) {
    window.addEventListener('load', () => {
        navigator.serviceWorker
            .register('serviceworker.js')
            .then((registration) => {
                console.log('ServiceWorker registered with scope', registration.scope);
            })
            .catch((err) => {
                console.log('ServiceWorker registration failed:', err);
            });
    });
}

/** **********************************************************************
 * Connect to Firebase
 */

// Your web app's Firebase configuration
const firebaseConfig = {
    apiKey            : "AIzaSyD_SDDuyHYXcj_xiw8V_BXmWb_X9TUWpK8",
    authDomain        : "salem-1692-moderator.firebaseapp.com",
    databaseURL       : "https://salem-1692-moderator-default-rtdb.europe-west1.firebasedatabase.app",
    projectId         : "salem-1692-moderator",
    storageBucket     : "salem-1692-moderator.appspot.com",
    messagingSenderId : "910714101001",
    appId             : "1:910714101001:web:1a9d4882f11f07376807d8",
}

// Initialize Firebase
const firebaseApp = initializeApp(firebaseConfig);
const firebaseDb = getDatabase(firebaseApp);
const gamesRef = ref(firebaseDb, 'games');

const myGameRef = ref(firebaseDb, 'games/a45-t81-p03');
onValue(myGameRef, (snapshot) => {
  const data = snapshot.val();
  console.log(data);
});

/** **********************************************************************
 * Make some variables available for Rescript
 */

window.salemAppVersion = "0.27.2";

/** **********************************************************************
 * Run the game. Specify the game's DOM node id.
 */

Main.run('root');

