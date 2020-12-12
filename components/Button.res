@react.component
let make = React.forwardRef((~children, ~className="", ~href: option<
  string,
>=?, ~loading=false, ~onClick: option<ReactEvent.Mouse.t => unit>=?, ~type_: option<
  string,
>=?, _ref) => {
  let element = switch href {
  | Some(_) => "a"
  | None => "button"
  }

  let noop = _event => ()
  let onClickCallback = switch (onClick, loading) {
  | (Some(cb), false) => cb
  | (_, true) => noop
  | (None, _) => noop
  }

  ReactDOMRe.createElement(
    element,
    ~props=ReactDOMRe.props(
      ~className=className ++
      (loading
        ? " bg-gray-400 cursor-wait"
        : " bg-green-600") ++ " rounded-lg text-white text-base font-semibold p-3 px-8",
      ~href?,
      ~onClick=onClickCallback,
      ~type_?,
      (),
    ),
    [loading ? "Sending message..."->React.string : children],
  )
})
