/** ****************************************************************************
 * Eyes
 */

@react.component
let make = (
    ~verticalFill: bool = false
): React.element =>
    <img src="images/overlay-night.webp" className={verticalFill ? "eyes-image vertical-fill" : "eyes-image"} />

