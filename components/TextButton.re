[@react.component]
let make =
  React.forwardRef(
    (
      ~className,
      ~children,
      ~href: option(string)=?,
      ~onClick: option(ReactEvent.Mouse.t => unit)=?,
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
      ~props=ReactDOMRe.props(~className=className ++ " underline", ~href?, ~onClick?, ()),
      [|children|],
    );
  });
