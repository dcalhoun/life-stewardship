open React;

module NavItem = {
  [@react.component]
  let make = (~children, ~className, ~onClick=_event => (), ~href="") => {
    <a className={className ++ " tracking-wider text-gray-700"} href onClick>
      children
    </a>;
  };
};

[@react.component]
let make = (~children) => {
  <>
    <div className="sr-only focus-within:not-sr-only">
      <a
        className="inline-block bg-white border-solid rounded-lg m-4 p-4 color-black absolute z-10"
        href="#content">
        "Skip to content"->string
      </a>
    </div>
    <div className="bg-green-600 h-4 w-full" />
    <div className="p-4 max-w-4xl mx-auto">
      <nav className="flex flex-col lg:flex-row mb-5">
        <Next.Link href="/">
          <a className="w-64 self-center mb-5">
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
        <div className="flex justify-center">
          <Next.Link href="/nonprofit" passHref=true>
            <NavItem className="ml-4"> "Nonprofit"->string </NavItem>
          </Next.Link>
          <Next.Link href="/individuals" passHref=true>
            <NavItem className="ml-4"> "Individuals"->string </NavItem>
          </Next.Link>
          <Next.Link href="/contact" passHref=true>
            <NavItem className="ml-4"> "Contact"->string </NavItem>
          </Next.Link>
        </div>
      </nav>
      <main id="content"> children </main>
    </div>
  </>;
};
