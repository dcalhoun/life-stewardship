@react.component
let make = () =>
  <div className="text-center py-16">
    <hr className="mb-16 border-gray-200" />
    <p className="text-2xl text-gray-800 font-light mb-6">
      {(j`${"Ready to get started? Let"}’${"s talk."}`)->React.string}
    </p>
    <Next.Link href="/contact" passHref=true>
      <Button> {"Send Paul a message"->React.string} </Button>
    </Next.Link>
  </div>
