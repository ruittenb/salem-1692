
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
                    <div className="h2-no-margin"> {React.string(secret)} </div>
                </>
            } else {
                React.string(revealPrompt)
            }
        }
    </LargeButton>
}

