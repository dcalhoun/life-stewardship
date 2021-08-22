module NavItem = {
  @react.component
  let make = React.forwardRef((~children, ~className="", ~onClick=_event => (), ~href="", _ref) => {
    <a
      className={className ++ " flex-1 lg:flex-initial mx-4 lg:ml-12 lg:mr-0 py-2 lg:py-0 text-center tracking-wider font-semibold text-gray-700"}
      href
      onClick>
      children
    </a>
  })
}

@react.component
let make = (~children, ~preview=false) => <>
  <div className="sr-only focus-within:not-sr-only">
    <a
      className="inline-block bg-gray-600 border-solid rounded-lg m-5 mt-9 p-4 text-gray-200 absolute z-10"
      href="#content">
      {"Skip to content"->React.string}
    </a>
  </div>
  {switch preview {
  | true =>
    <div className="bg-yellow-300 w-full p-3 text-center">
      {"Preview mode enabled. "->React.string}
      <TextButton className="font-bold" href="/api/preview?disable" theme=TextButton.Secondary>
        {"Disable"->React.string}
      </TextButton>
      {"."->React.string}
    </div>

  | false => React.null
  }}
  <div className="bg-green-700 h-4 w-full" />
  <div className="p-4 max-w-4xl mx-auto">
    <nav className="flex flex-col lg:flex-row items-center lg:py-5 mb-5">
      <Next.Link href="/">
        <a className="w-64 self-center mb-5 lg:mb-0">
          <Next.Image
            alt="Life Stewardship LLC logo"
            className="absolute h-full w-full object-contain"
            height=54
            src="/logo.png"
            width=256
          />
        </a>
      </Next.Link>
      <div className="flex flex-1 justify-between lg:justify-end flex-wrap">
        <Next.Link href="/nonprofit" passHref=true>
          <NavItem> {"Nonprofit"->React.string} </NavItem>
        </Next.Link>
        <Next.Link href="/individuals" passHref=true>
          <NavItem> {"Individuals"->React.string} </NavItem>
        </Next.Link>
        <Next.Link href="/blog" passHref=true>
          <NavItem> {"Blog"->React.string} </NavItem>
        </Next.Link>
        <Next.Link href="/contact" passHref=true>
          <NavItem> {"Contact"->React.string} </NavItem>
        </Next.Link>
      </div>
    </nav>
    <main id="content"> children </main>
  </div>
</>
