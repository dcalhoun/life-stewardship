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
    <div className="max-w-4xl mx-auto p-4">
      <Navigation />
      <main id="content"> children </main>
    </div>
  </>;
};
