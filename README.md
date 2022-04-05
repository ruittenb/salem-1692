
# Moderator PWA for the card game Salem 1692

A web app for fulfilling the moderator role in the Salem 1692 card game

## The Game

- [Façade Games](https://facadegames.com/products/salem-1692)
- [BoardGameGeek](https://www.boardgamegeek.com/boardgame/175549/salem-1692)

## PWA Hosting

- [Project on GitHub](https://github.com/ruittenb/salem-1692)
- [See this web app in action](https://ruittenb.github.io/salem-1692/)
- [Firebase Console](https://console.firebase.google.com/u/1/project/salem-1692-moderator/overview)

## Technologies Used

- [ReScript](https://rescript-lang.org/docs/manual/latest/overview)
  - [ReScript Forum](https://www.reddit.com/r/rescript/)
- [Decco](https://github.com/reasonml-labs/decco)
  - [How To Encode/Decode with Decco](https://blog.thomasdeconinck.fr/articles/decoder-une-enumeration-depuis-une-api-en-rescript-avec-decco)
- [React](https://reactjs.org/docs/getting-started.html)
  - [ReScript-React](https://rescript-lang.org/docs/react/latest/introduction)
- [Firebase Realtime Database](https://firebase.google.com/docs/database)
  - [Getting Started (documentation)](https://firebase.google.com/docs/database/web/start)
  - [Getting Started (video)](https://www.youtube.com/watch?v=rQvOAnNvcNQ)
- [Git Subtree](https://www.atlassian.com/git/tutorials/git-subtree)

## Directory Structure

- [src/](src/) ReScript source files
- [dist/](dist/) Compiled files and web root
- lib/ Workdirectory for compiler
- [doc/](doc/) Dialogue scripts
- [database/](database/) Firebase rules and example data

## Building

```
make all
```

Output files will be put in `dist/`

## Serving

For running locally, a webserver may be started with:

```
make serve
```

## Supported Browsers

- Chrome 99
- Chrome for Android 99
- Firefox 98
- Firefox for Android 96
- Safari 15.4
- Safari on iOS 15.4
- Edge 99
- Android Browser 99
- Samsung Internet 16
- Opera 83

## Debugging

Debugging output (in the browser console) can be obtained by changing the User-Agent string
to contain the text "Salem/1692".

How to do this on: [Chrome](https://www.alphr.com/change-user-agent-string-google-chrome/),
[Firefox/Edge](https://geekflare.com/change-user-agent-in-browser/),
[Safari](https://www.technipages.com/how-to-change-user-agent-in-safari).


