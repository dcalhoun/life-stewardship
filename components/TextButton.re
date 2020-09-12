[@react.component]
let make =
  React.forwardRef((~children, ~href: option(string)=?, _ref) => {
    let el = {
      switch (href) {
      | Some(_) => "a"
      | None => "button"
      };
    };

    ReactDOMRe.createElement(
      el,
      ~props=ReactDOMRe.props(~className="underline", ~href?, ()),
      [|children|],
    );
  });
