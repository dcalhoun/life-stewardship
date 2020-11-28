open React;

type formError = {
  subject: string,
  message: string,
};

[@react.component]
let make = (~className, ~children, ~errors, ~label, ~name) => {
  let error = Belt.Array.getBy(errors, e => e.subject === name);
  <div className>
    <label className="text-base lg:text-2xl mb-4 lg:mb-8" htmlFor=name>
      label->string
    </label>
    children
    {switch (error) {
     | Some(error) =>
       <span className="text-base lg:text-2xl mb-4 lg:mb-8">
         error.message->string
       </span>
     | None => React.null
     }}
  </div>;
};
