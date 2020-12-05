[@react.component]
let make =
  React.forwardRef(
    (
      ~children,
      ~className="",
      ~href: option(string)=?,
      ~onClick: option(ReactEvent.Mouse.t => unit)=?,
      ~type_: option(string)=?,
      _ref,
    ) => {
    let element = {
      switch (href) {
      | Some(_) => "a"
      | None => "button"
      };
    };

    ReactDOMRe.createElement(
      element,
      ~props=
        ReactDOMRe.props(
          ~className=className ++ " rounded-lg bg-green-600 text-white text-sm font-semibold uppercase p-3",
          ~href?,
          ~onClick?,
          ~type_?,
          (),
        ),
      [|children|],
    );
  });
