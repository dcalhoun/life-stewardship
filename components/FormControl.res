type formError = {
  subject: string,
  message: string,
}

@react.component
let make = (~className, ~children, ~errors, ~label, ~name) => {
  let error = Belt.Array.getBy(errors, e => e.subject === name)
  <div className>
    <label className="text-base lg:text-xl text-gray-900 font-serif" htmlFor=name>
      {label->React.string}
    </label>
    children
    {switch error {
    | Some(error) =>
      <span className="text-base lg:text-xl text-red-500 font-serif">
        {error.message->React.string}
      </span>
    | None => React.null
    }}
  </div>
}
