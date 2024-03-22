/* *****************************************************************************
 * If
 *
 * Usage:
 *   <If condition=isConnected>
 *     <p>Connection ID: {{ id }}</p>
 *   </If>
 */

@react.component
let make = (~condition: bool, ~children: React.element): React.element =>
  condition ? children : <> </>
