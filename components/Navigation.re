[@react.component]
let make = () => {
  <>
    <a href="#content"> "Skip to content"->React.string </a>
    <nav>
      <Next.Link href="/"> <a> "About"->React.string </a> </Next.Link>
      <Next.Link href="/nonprofit">
        <a> "Nonprofit"->React.string </a>
      </Next.Link>
      <Next.Link href="/individuals">
        <a> "Individuals"->React.string </a>
      </Next.Link>
      <Next.Link href="/contact"> <a> "Contact"->React.string </a> </Next.Link>
    </nav>
  </>;
};
