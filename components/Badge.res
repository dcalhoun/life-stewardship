@react.component
let make = (~ariaHidden=?, ~children, ~className="") => {
  <span
    ?ariaHidden
    className={className ++ " bg-yellow-300 text-gray-900 rounded px-1 py-0 font-sans font-bold text-sm uppercase"}>
    {children}
  </span>
}
