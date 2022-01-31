/** ****************************************************************************
 * TypesComposite
 */

open Types

/** **********************************************************************
 * Game Types
 */

@decco type gameState = {
    gameType: GameTypeCodec.t,
    language: LanguageCodec.t,
    players: players,
    seating: SeatingCodec.t,
    hasGhostPlayers: bool,
    doPlayEffects: bool,
    doPlaySpeech: bool,
    doPlayMusic: bool,
    backgroundMusic: array<string>,
}
type gameStateSetter = (gameState => gameState) => unit

let gameStateDecodeAndReconnect = (encoded, _startMaster, _startSlave) => { // FIXME
    gameState_decode(encoded)
}

type turnState = {
    nrWitches: NumerusCodec.t,
    nightType: NightTypeCodec.t,
    choiceWitches: option<player>,
    choiceConstable: option<player>,
}
type turnStateSetter = (turnState => turnState) => unit

/** **********************************************************************
 * Firebase Types
 */

@decco type dbRecord = {
    masterGameId: GameTypeCodec.gameId,
    masterPhase: PhaseCodec.t,
    masterPlayers: array<player>,
    masterSeating: SeatingCodec.t,
    masterNumberWitches: NumerusCodec.t,
    masterNightType: NightTypeCodec.t,
    masterHasGhostPlayers: bool,
    slaveChoiceWitches: player,
    slaveChoiceConstable: player,
    slaveConfirmWitches: DecisionCodec.t,
    slaveConfirmConstable: DecisionCodec.t,
    updatedAt: string,
}

