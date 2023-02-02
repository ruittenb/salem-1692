
let fs = require('fs');

const MILLISECONDS_IN_DAY = 24 * 60 * 60 * 1000;
const MILLISECONDS_IN_WEEK = 7 * MILLISECONDS_IN_DAY;

function getFilename() {
    return process.argv.length > 2 ? process.argv[2] : 'salem.json';
}

function processJsonData(jsonString) {
    const data = JSON.parse(jsonString);
    delete data.games._keep;
    return data;
}

function cmp(a, b) {
    switch (true) {
        case a > b: return -1;
        case a < b: return 1;
        default: return 0;
    }
}

function getMostRecentGame(games) {
    const gamesSorted = games.sort((a, b) => {
        const res = cmp(a.updatedAt, b.updatedAt);
        return res;
    });
    return gamesSorted[0];
}

function main() {
    const filename = getFilename();
    console.log(`Processing file ${filename}`);
    fs.readFile(filename, 'utf8', (err, dataStr) => {
        if (err) {
            return console.error(err);
        }
        const data = processJsonData(dataStr);
        const games = Object.values(data.games);
        if (games.length) {
            console.log(`Contains ${games.length} games`);
        } else {
            return console.error('Abort: no games found in data');
        }
        const mostRecentGame = getMostRecentGame(games);
        console.log(`Most recent game date: ${mostRecentGame.updatedAt}`);
        if (new Date() - new Date(mostRecentGame.updatedAt) < MILLISECONDS_IN_DAY) {
            return console.error('Abort: this game may still be in progress');
        }
        console.log('Go ahead and purge');
    });
}

main();
