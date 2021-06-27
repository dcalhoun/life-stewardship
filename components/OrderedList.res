@react.component
let make = (~children) =>
  <ol
    className="list-decimal mx-auto pl-6 lg:pl-8 text-base lg:text-xl font-serif"
    style={ReactDOM.Style.make(~maxWidth="30em", ())}>
    children
  </ol>
