type theme = Primary | Secondary

@react.component
let make = React.forwardRef((
  ~children,
  ~className="",
  ~href: option<string>=?,
  ~onClick: option<ReactEvent.Mouse.t => unit>=?,
  ~theme: theme=Primary,
  ~type_: option<string>=?,
  _ref,
) => {
  let element = switch href {
  | Some(_) => "a"
  | None => "button"
  }

  ReactDOMRe.createElement(
    element,
    ~props=ReactDOMRe.props(
      ~className=className ++
      " underline " ++
      switch theme {
      | Primary => "text-green-700"
      | Secondary => "text-gray-900"
      },
      ~href?,
      ~onClick?,
      ~type_?,
      (),
    ),
    [children],
  )
})
