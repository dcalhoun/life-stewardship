[@react.component]
let make = () => {
  <>
    <div className="sr-only focus-within:not-sr-only">
      <a
        className="inline-block bg-white border-solid absolute rounded-lg m-4 p-4 color-black z-10"
        href="#content">
        "Skip to content"->React.string
      </a>
    </div>
    <nav className="flex flex-col p-2">
      <Next.Link href="/">
        <a className="block w-64 self-center">
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
          <TextButton> "Nonprofit"->React.string </TextButton>
        </Next.Link>
        <Next.Link href="/individuals" passHref=true>
          <TextButton> "Individuals"->React.string </TextButton>
        </Next.Link>
        <Next.Link href="/contact" passHref=true>
          <TextButton> "Contact"->React.string </TextButton>
        </Next.Link>
      </div>
    </nav>
  </>;
};
