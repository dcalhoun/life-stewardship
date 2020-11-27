[@react.component]
let make = (~className=?, ~children) => {
  <p
    className={
      "text-base lg:text-2xl mb-4 lg:mb-8 "
      ++ className->Belt.Option.getWithDefault("")
    }>
    children
  </p>;
};
