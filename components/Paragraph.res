@react.component
let make = (~className="", ~children) =>
  <p
    className={className ++ " text-base lg:text-xl font-serif mb-5 lg:mb-8"}
    style={ReactDOM.Style.make(~maxWidth="30em", ())}>
    children
  </p>
