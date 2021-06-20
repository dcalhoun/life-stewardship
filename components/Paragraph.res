@react.component
let make = (~className="", ~children) =>
  <p className={className ++ " text-base lg:text-xl font-serif mb-5"}> children </p>
