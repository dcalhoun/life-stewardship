type align = Left | Center | Right

@react.component
let make = (~className="", ~children, ~align=Center) => {
  let alignment = switch align {
  | Center => " mx-auto"
  | _ => ""
  }
  <p
    className={className ++ alignment ++ " text-base lg:text-xl font-serif mb-5 lg:mb-8"}
    style={ReactDOM.Style.make(~maxWidth="30em", ())}>
    children
  </p>
}
