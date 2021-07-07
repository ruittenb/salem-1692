
/**
 * ReScript      : https://rescript-lang.org/docs/manual/latest/overview
 * ReScript-React: https://rescript-lang.org/docs/react/latest/introduction
 * ReactJS       : https://reactjs.org/docs/getting-started.html
 */

import * as Main from './Main.bs';

class App {
    constructor() {
        this.state = Main.init();
    }

    run() {
        this.state = Main.render({ state: this.state });
        console.log(this.state);
    }
}

window.App = App;

