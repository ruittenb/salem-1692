
/** ****************************************************************************
 * NightPage
 */

open Types

@react.component
let make = (
    ~phase: page
): React.element => {
    let title: string = switch phase {
        | NightWitch     => "The witches" // TODO translate
        | NightConstable => "The constable" // TODO translate
        | _              => "Night"
    }
    <div id="night-page" className="page">
        <div id="night-subpage" className="page">
        {React.string(title)}
        </div>
    </div>
}

