open React;

module NavItem = {
  [@react.component]
  let make = (~children, ~href="", ~onClick=_event => ()) => {
    <a
      className="bg-gray-200 rounded-lg mx-2 p-2 flex-1 text-center"
      href
      onClick>
      children
    </a>;
  };
};

[@react.component]
let make = () => {
  <nav className="flex flex-col py-4">
    <Next.Link href="/">
      <a className="block w-64 self-center mb-4">
        <div
          className="relative"
          style={ReactDOM.Style.make(~paddingBottom="21.0344828%", ())}>
          <img
            className="absolute h-full w-full object-contain"
            src="/logo.png"
            alt="Life Stewardship logo"
          />
        </div>
      </a>
    </Next.Link>
    <div className="flex">
      <Next.Link href="/nonprofit" passHref=true>
        <NavItem> "Nonprofit"->string </NavItem>
      </Next.Link>
      <Next.Link href="/individuals" passHref=true>
        <NavItem> "Individuals"->string </NavItem>
      </Next.Link>
      <Next.Link href="/contact" passHref=true>
        <NavItem> "Contact"->string </NavItem>
      </Next.Link>
    </div>
  </nav>;
};
