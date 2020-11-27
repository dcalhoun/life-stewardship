open React;

[@react.component]
let make = () => {
  <>
    <div className="sr-only focus-within:not-sr-only">
      <a
        className="inline-block bg-white border-solid rounded-lg m-4 p-4 color-black absolute z-10"
        href="#content">
        "Skip to content"->string
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
          <TextButton className="p-2"> "Nonprofit"->string </TextButton>
        </Next.Link>
        <Next.Link href="/individuals" passHref=true>
          <TextButton className="p-2"> "Individuals"->string </TextButton>
        </Next.Link>
        <Next.Link href="/contact" passHref=true>
          <TextButton className="p-2"> "Contact"->string </TextButton>
        </Next.Link>
      </div>
    </nav>
  </>;
};
