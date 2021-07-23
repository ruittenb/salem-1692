
/** ****************************************************************************
 * LargeRevealButton
 */

@@warning("-33") // Unused 'open Types'

open Types

@react.component
let make = (
    ~revealPrompt: string,
    ~revelationPromptPre: string,
    ~revelationPromptPost: string,
    ~secret: string,
): React.element => {

    let (revealed, setRevealed) = React.useState(_ => false)

    <LargeButton label="" onClick={ _event => setRevealed(prev => !prev) }>
        {
            if revealed {
                <>
                    <div> {React.string(revelationPromptPre)} </div>
                    <div>
                        <span className="h2-no-margin"> {React.string(secret)} </span>
                        <span> {React.string(revelationPromptPost)} </span>
                    </div>
                </>
            } else {
                React.string(revealPrompt)
            }
        }
    </LargeButton>
}

