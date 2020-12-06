@react.component
let default = () =>
  <Layout>
    <Next.Head> <title> {"Nonprofit - Life Stewardship"->React.string} </title> </Next.Head>
    <h1 className={Heading.Styles.primary ++ " mb-5"}> {"Nonprofit"->React.string} </h1>
    <div
      className="h-40 lg:h-80 overflow-hidden rounded-lg mb-5 bg-contain lg:bg-cover bg-center bg-no-repeat bg-black"
      style={ReactDOM.Style.make(~backgroundImage="url(/header-nonprofit.jpg)", ())}
    />
    <Paragraph>
      <b> {"Do something great. "->React.string} </b>
      {"Serving others or making things better is
          the mission of all nonprofits. That is why they exist and why we give
          our time and money to nonprofits. When they accept our time and money,
          they assume a stewardship responsibility for them."->React.string}
    </Paragraph>
    <Paragraph>
      {"Board members and management have the primary responsibility for
          stewardship of the nonprofit’s assets. This is a critical
          responsibility because nonprofits are accountable to their
          clients/constituents, donors, the public, and government authorities."->React.string}
    </Paragraph>
    <Paragraph>
      {"For the board of directors and management to fulfill their fiduciary
          responsibilities, a nonprofit must develop a sound accounting and
          financial reporting system which includes appropriate internal
          controls based on the size and complexity of the organization.
          Internal controls designed to achieve effective and efficient
          operations, reliable financial reporting, and compliance with
          applicable laws and regulations."->React.string}
    </Paragraph>
    <Paragraph>
      {"Many nonprofits lack expertise and knowledge or time to develop their
          accounting and financial reporting system and have limited external
          support. I have extensive experience working with nonprofits and can
          help the board of directors and management fulfill their fiduciary
          responsibilities."->React.string}
    </Paragraph>
    <Paragraph>
      {`If you want more information or need help fulfilling your fiduciary
          responsibilities, let’s talk. I can assist you with:`->React.string}
    </Paragraph>
    <UnorderedList>
      <ListItem> {"Assisting with Board Governance & Oversight"->React.string} </ListItem>
      <ListItem> {"Board of Director Training"->React.string} </ListItem>
      <ListItem> {"Financial Statement Preparation"->React.string} </ListItem>
      <ListItem> {"Functional Expense Reporting"->React.string} </ListItem>
      <ListItem> {"Grant Compliance"->React.string} </ListItem>
      <ListItem> {"Internal Controls"->React.string} </ListItem>
      <ListItem> {"Tax Compliance"->React.string} </ListItem>
    </UnorderedList>
    <ContactCTA />
  </Layout>
