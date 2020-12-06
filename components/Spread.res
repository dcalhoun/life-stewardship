@react.component
let make = (~props, ~children) => ReasonReact.cloneElement(children, ~props, [])
