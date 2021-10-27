
# Moderator PWA for the card game Salem 1692

A PWA for representing the moderator in the Salem 1692 card game

## The Game

- [Salem 1692](https://facadegames.com/products/salem-1692)
- [BoardGameGeek](https://www.boardgamegeek.com/boardgame/175549/salem-1692)

## PWA Hosting

- [Project on GitHub](https://github.com/ruittenb/salem-1692)
- [Active Website](https://ruittenb.github.io/salem-1692/dist/) Click here to see the website in action.
- [Firebase Console](https://console.firebase.google.com/u/1/project/salem-1692-moderator/overview)

## Technologies Used

- [ReScript](https://rescript-lang.org/docs/manual/latest/overview)
- [ReScript Forum](https://www.reddit.com/r/rescript/)
- [React](https://reactjs.org/docs/getting-started.html)
- [Firebase Realtime Database](https://firebase.google.com/docs/database)

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

## Debugging

Debugging output (in the browser console) can be obtained by
[changing the User-Agent string](https://www.alphr.com/change-user-agent-string-google-chrome/)
to contain the text "Salem/1692".

