open React;

[@react.component]
let make = (~children, ~onDismiss) => {
  <div> <button onClick=onDismiss> "Dismiss"->string </button> children </div>;
};
