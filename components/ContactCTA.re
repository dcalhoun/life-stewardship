[@react.component]
let make = () => {
  <div className="text-center py-16">
    <p className="text-2xl text-gray-800 font-light mb-6">
      {("Ready to get started? Let" ++ {j|’|j} ++ "s talk.")->React.string}
    </p>
    <Next.Link href="/contact" passHref=true>
      <Button> "Send Paul a message"->React.string </Button>
    </Next.Link>
  </div>;
};
