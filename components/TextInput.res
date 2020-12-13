@react.component
let make = (
  ~cols=?,
  ~errorMessage="Required.",
  ~id,
  ~invalid=false,
  ~multiline=false,
  ~name,
  ~placeholder="",
  ~required=false,
  ~rows=?,
  ~type_="text",
) => {
  let textInput = ReactDOMRe.createElement(
    multiline ? "textarea" : "input",
    ~props=ReactDOMRe.props(
      ~className=(
        invalid
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
      (),
    ),
    [],
  )

  <Spread props={"data-error-message": errorMessage}> textInput </Spread>
}
