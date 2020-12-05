[@react.component]
let make = (~className=?, ~children) => {
  <p
    className={
      className->Belt.Option.getWithDefault("")
      ++ " text-base text-gray-900 font-serif mb-5 "
    }>
    children
  </p>;
};
