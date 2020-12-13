type formError = {
  subject: string,
  message: string,
}

@react.component
let make = (
  ~className="",
  ~cols=?,
  ~errorMessage="Required.",
  ~errors=[],
  ~id,
  ~label=?,
  ~multiline=false,
  ~name,
  ~placeholder="",
  ~required=false,
  ~rows=?,
  ~value=?,
  ~type_="text",
) => {
  let error = Belt.Array.getBy(errors, e => e.subject === name)
  let textInput = ReactDOMRe.createElement(
    multiline ? "textarea" : "input",
    ~props=ReactDOMRe.props(
      ~className=(
        error->Belt.Option.isSome
          ? "border-red-300 placeholder-red-400 text-red-500"
          : "border-gray-300 placeholder-gray-400 text-gray-900"
      ) ++ " bg-white shadow-none border rounded-md p-2 block w-full",
      ~cols?,
      ~id,
      ~name,
      ~placeholder,
      ~required,
      ~rows?,
      ~type_,
      ~value?,
      (),
    ),
    [],
  )

  <div className>
    {switch label {
    | Some(label) =>
      <label
        className={(
          error->Belt.Option.isSome ? "text-red-500" : "text-gray-900"
        ) ++ " text-base lg:text-xl text-gray-900 font-serif"}
        htmlFor=name>
        {label->React.string}
      </label>
    | None => React.null
    }}
    <Spread props={"data-error-message": errorMessage}> textInput </Spread>
    {switch error {
    | Some(error) =>
      <span className="flex items-center text-base lg:text-xl text-red-500 font-serif">
        <svg
          className="mr-1 h-6 w-6"
          xmlns="http://www.w3.org/2000/svg"
          fill="none"
          viewBox="0 0 24 24"
          stroke="currentColor">
          <path
            strokeLinecap="round"
            strokeLinejoin="round"
            strokeWidth="2"
            d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
          />
        </svg>
        {error.message->React.string}
      </span>
    | None => React.null
    }}
  </div>
}
