open React;

type formError = {
  subject: string,
  message: string,
};

[@react.component]
let make = (~children, ~errors, ~label, ~name) => {
  let error = Belt.Array.getBy(errors, e => e.subject === name);
  <div>
    <label htmlFor=name> label->string </label>
    children
    {switch (error) {
     | Some(error) => <span> error.message->string </span>
     | None => React.null
     }}
  </div>;
};
