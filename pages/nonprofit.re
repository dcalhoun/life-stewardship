open React;

[@react.component]
let default = () => {
  <Layout>
    <Next.Head>
      <title> "Nonprofit - Life Stewardship"->string </title>
    </Next.Head>
    <h1 className={Heading.Styles.primary ++ " mb-5"}>
      "Nonprofit"->string
    </h1>
    <div
      className="h-40 lg:h-80 overflow-hidden rounded-lg mb-5 bg-contain lg:bg-cover bg-center bg-no-repeat bg-black"
      style={ReactDOM.Style.make(
        ~backgroundImage="url(/header-nonprofit.jpg)",
        ()
      )}
    />
    <Paragraph>
      <b> "Do something great."->string </b>
      " Serving others or making things better is
          the mission of all nonprofits. That is why they exist and why we give
          our time and money to nonprofits. When they accept our time and money,
          they assume a stewardship responsibility for them."
      ->string
    </Paragraph>
    <Paragraph>
      {(
         "Board members and management have the primary responsibility for
          stewardship of the nonprofit"
         ++ {j|’|j}
         ++ "s assets. This is a critical
          responsibility because nonprofits are accountable to their
          clients/constituents, donors, the public, and government authorities."
       )
       ->string}
    </Paragraph>
    <Paragraph>
      "For the board of directors and management to fulfill their fiduciary
          responsibilities, a nonprofit must develop a sound accounting and
          financial reporting system which includes appropriate internal
          controls based on the size and complexity of the organization.
          Internal controls designed to achieve effective and efficient
          operations, reliable financial reporting, and compliance with
          applicable laws and regulations."
      ->string
    </Paragraph>
    <Paragraph>
      "Many nonprofits lack expertise and knowledge or time to develop their
          accounting and financial reporting system and have limited external
          support. I have extensive experience working with nonprofits and can
          help the board of directors and management fulfill their fiduciary
          responsibilities."
      ->string
    </Paragraph>
    <Paragraph>
      {(
         "If you want more information or need help fulfilling your fiduciary
          responsibilities, let"
         ++ {j|’|j}
         ++ "s talk. I can assist you with:"
       )
       ->string}
    </Paragraph>
    <UnorderedList>
      <ListItem>
        "Assisting with Board Governance & Oversight"->string
      </ListItem>
      <ListItem> "Board of Director Training"->string </ListItem>
      <ListItem> "Financial Statement Preparation"->string </ListItem>
      <ListItem> "Functional Expense Reporting"->string </ListItem>
      <ListItem> "Grant Compliance"->string </ListItem>
      <ListItem> "Internal Controls"->string </ListItem>
      <ListItem> "Tax Compliance"->string </ListItem>
    </UnorderedList>
    <ContactCTA />
  </Layout>;
};
