@react.component
let make = (~children) =>
  <ul
    className="list-disc mx-auto pl-6 lg:pl-8 text-base lg:text-xl font-serif"
    style={ReactDOM.Style.make(~maxWidth="30em", ())}>
    children
  </ul>
