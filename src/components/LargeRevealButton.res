
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
    ~revealed: bool,
    ~onClick: clickHandler,
): React.element => {

    <LargeButton label="" onClick>
        {
            if revealed {
                <>
                    <div> {React.string(revelationPromptPre)} </div>
                    <div>
                        <span className="font-large"> {React.string(secret)} </span>
                        <span> {React.string(revelationPromptPost)} </span>
                    </div>
                </>
            } else {
                React.string(revealPrompt)
            }
        }
    </LargeButton>
}

