[@react.component]
let make =
  React.forwardRef(
    (
      ~children,
      ~className,
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
          ~className=className ++ " rounded-full bg-blue-600 text-white p-2",
          ~href?,
          ~onClick?,
          ~type_?,
          (),
        ),
      [|children|],
    );
  });
