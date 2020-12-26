module NavItem = {
  @react.component
  let make = React.forwardRef((~children, ~className="", ~onClick=_event => (), ~href="", _ref) => {
    <a
      className={className ++ " tracking-wider font-semibold text-gray-700 mx-4 lg:ml-12 lg:mr-0"}
      href
      onClick>
      children
    </a>
  })
}

@react.component
let make = (~children) => <>
  <div className="sr-only focus-within:not-sr-only">
    <a
      className="inline-block bg-gray-600 border-solid rounded-lg m-5 mt-9 p-4 text-gray-200 absolute z-10"
      href="#content">
      {"Skip to content"->React.string}
    </a>
  </div>
  <div className="bg-green-600 h-4 w-full" />
  <div className="p-4 max-w-4xl mx-auto">
    <nav className="flex flex-col lg:flex-row items-center lg:py-5 mb-5">
      <Next.Link href="/">
        <a className="w-64 self-center mb-5 lg:mb-0">
          <Next.Image
            className="absolute h-full w-full object-contain" height=54 src="/logo.png" width=256
          />
        </a>
      </Next.Link>
      <div className="flex flex-1 justify-center lg:justify-end">
        <Next.Link href="/nonprofit" passHref=true>
          <NavItem> {"Nonprofit"->React.string} </NavItem>
        </Next.Link>
        <Next.Link href="/individuals" passHref=true>
          <NavItem> {"Individuals"->React.string} </NavItem>
        </Next.Link>
        <Next.Link href="/contact" passHref=true>
          <NavItem> {"Contact"->React.string} </NavItem>
        </Next.Link>
      </div>
    </nav>
    <main id="content"> children </main>
  </div>
</>
