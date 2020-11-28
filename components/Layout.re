open React;

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
    <div className="max-w-4xl mx-auto p-4 lg:p-8">
      <nav className="flex flex-col lg:flex-row mb-4 lg:mb-8">
        <Next.Link href="/">
          <a className="block w-64 self-center mb-4 lg:mb-0 flex-shrink">
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
        <div
          className="flex flex-1 lg:items-center justify-between lg:justify-end">
          <Next.Link href="/nonprofit" passHref=true>
            <TextButton className="lg:ml-4"> "Nonprofit"->string </TextButton>
          </Next.Link>
          <Next.Link href="/individuals" passHref=true>
            <TextButton className="lg:ml-4">
              "Individuals"->string
            </TextButton>
          </Next.Link>
          <Next.Link href="/contact" passHref=true>
            <TextButton className="lg:ml-4"> "Contact"->string </TextButton>
          </Next.Link>
        </div>
      </nav>
      <main id="content"> children </main>
    </div>
  </>;
};
