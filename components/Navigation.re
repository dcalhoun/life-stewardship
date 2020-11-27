open React;

module NavItem = {
  [@react.component]
  let make =
    React.forwardRef(
      (~children, ~className="", ~href="", ~onClick=_event => (), _ref) => {
      <a
        className={
          "bg-gray-200 rounded-lg p-2 flex-1 text-center " ++ className
        }
        href
        onClick>
        children
      </a>
    });
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
        <NavItem className="mr-2"> "Nonprofit"->string </NavItem>
      </Next.Link>
      <Next.Link href="/individuals" passHref=true>
        <NavItem className="mx-2"> "Individuals"->string </NavItem>
      </Next.Link>
      <Next.Link href="/contact" passHref=true>
        <NavItem className="ml-2"> "Contact"->string </NavItem>
      </Next.Link>
    </div>
  </nav>;
};
