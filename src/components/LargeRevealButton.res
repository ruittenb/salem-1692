
/** ****************************************************************************
 * LargeRevealButton
 */

@@warning("-33") // Unused 'open Types'

open Types

@react.component
let make = (
    ~revealPrompt: string,
    ~revelationPrompt: string,
    ~secret: string,
): React.element => {

    let (revealed, setRevealed) = React.useState(_ => false)

    <LargeButton label="" onClick={ _event => setRevealed(prev => !prev) }>
        {
            if revealed {
                <>
                    <div> {React.string(revelationPrompt)} </div>
                    <h2> {React.string(secret)} </h2>
                </>
            } else {
                React.string(revealPrompt)
            }
        }
    </LargeButton>
}

