/** ****************************************************************************
 * Timer
 */

open Constants

@get external innerWidth: (Dom.window) => float = "innerWidth"

let p = "[Timer] "
let containerFraction = 0.8 // fraction of window width
let zeroTime = 5 // when to stop the timer, leaving some room for the barrel
let deadSpace = 75. // width of the barrel and flame together
let containerWidth = window->innerWidth *. containerFraction -. deadSpace

/**                                                            *
 * <--------------------- innerWidth ------------------------> *
 *         <---- containerFraction * innerWidth ----->         *
 *                                                             *
 *         +-----------------------------------------+         *
 *         |  /‾‾‾‾\                     v  v        |         *
 *         | (======)                    vvv         |         *
 *         |  \____/======================v          |         *
 *         +-----------------------------------------+         *
 *         |  barrel        fuse         flame       |         *
 *         +-----------------------------------------+         *
 *                                                             *
 *                  <---- fuseLength ---->                     *
 *          <------>                     <--->                 *
 *          deadSpace                  deadSpace               *
 */

@react.component
let make = (
    ~onAlarm: unit => unit = () => (),
): React.element => {
    let (remainingTime, setRemainingTime) = React.useState(_ => 100) // percent
    // total available time lies somewhere between 6 and 12 seconds
    let delay = React.useRef(Js.Math.random_int(60, 120))

    let tick = () => {
        if (remainingTime > zeroTime) {
            setRemainingTime(prevRemainingTime => prevRemainingTime - 1)
        } else if (remainingTime === zeroTime) {
            // let alarm go off only once
            setRemainingTime(prevRemainingTime => prevRemainingTime - 1)
            Utils.logDebug(p ++ "Alarm goes off")
            onAlarm()
        }
        // as soon as remainingTime is negative, no timer will be installed any more
    }

    // Runs only once right after mounting the component
    React.useEffect0(() => {
        Utils.logDebug(p ++ "Setting tick time to " ++ Belt.Int.toString(delay.current) ++ "ms")
        None // Cleanup
    })
    // Run every tick
    React.useEffect1(() => {
        let timerId = Js.Global.setTimeout(tick, delay.current)
        // Cleanup
        Some(() => {
            Js.Global.clearTimeout(timerId)
        })
    }, [ remainingTime ])

    let fuseLength = containerWidth *. remainingTime->Belt.Int.toFloat /. 100.
    let style = ReactDOM.Style.make(
        ~width=Belt.Float.toString(fuseLength) ++ "px", ()
    )

    // Component
    <div className="timer-container">
        <img className="barrel" src="images/timer-barrel-60.png" />
        <div className="rope" style />
        <img className="flame" src="images/timer-flame-40.webp" />
    </div>
}
