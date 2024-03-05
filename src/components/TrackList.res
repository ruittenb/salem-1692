/* * ****************************************************************************
 * TrackList
 */

let nnbsp = ` ` // U+202F Narrow No-Break Space
let note = `♪` // U+266A Eighth Note (quaver)

@react.component
let make = (): React.element => {
  // Component
  React.array(
    Constants.musicTracks->Js.Array2.mapi((track, index) => {
      <React.Fragment key={Belt.Int.toString(index) ++ "/" ++ track}>
        <Link
          href={"https://incompetech.com/music/royalty-free/mp3-royaltyfree/" ++ track ++ ".mp3"}
          text={note ++ nnbsp ++ track}
        />
        {React.string(", ")}
      </React.Fragment>
    }),
  )
}
