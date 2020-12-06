@react.component
let default = () =>
  <Layout>
    <Next.Head> <title> {"Individuals - Life Stewardship"->React.string} </title> </Next.Head>
    <h1 className={Heading.Styles.primary ++ " mb-5"}> {"Individuals"->React.string} </h1>
    <div
      className="h-40 lg:h-80 overflow-hidden rounded-lg mb-5 bg-cover bg-bottom bg-no-repeat"
      style={ReactDOM.Style.make(~backgroundImage="url(/header-individuals.jpg)", ())}
    />
    <Paragraph>
      <b> {"Begin."->React.string} </b>
      {" Beginning is often the hardest step. We do not know how
          to get started, so we procrastinate. We may know what needs to be done
          but life is busy, so we procrastinate. We may believe its complex and
          we do not know who to talk with, so we procrastinate. Seldom does
          procrastination solve our problems, it may limit our options; and it
          may not provide us the best solutions"->React.string}
    </Paragraph>
    <Paragraph>
      {"Being a good steward of our personal finances is something we all
          recognize is important. We want to reduce the financial stress in our
          lives, and we want to give, spend, and save our money wisely so that
          we can accomplish the goals which are important to us."->React.string}
    </Paragraph>
    <Paragraph>
      {"Stewardship is the lifelong process of managing everything God
          provides us in a manner that honors God. We can honor God by wisely
          using what He has given us to provide for ourselves, our families, and
          others."->React.string}
    </Paragraph>
    <Paragraph>
      {`If you are ready to get begin, let’s talk. I can assist you with:`->React.string}
    </Paragraph>
    <UnorderedList>
      <ListItem> {"Clarifying Your Financial Goals"->React.string} </ListItem>
      <ListItem> {"Budgeting & Tracking"->React.string} </ListItem>
      <ListItem> {"Cash Management & Planning"->React.string} </ListItem>
      <ListItem> {"Debt Payoff & Management"->React.string} </ListItem>
      <ListItem> {"Education Funding"->React.string} </ListItem>
      <ListItem> {"Retirement Planning"->React.string} </ListItem>
      <ListItem> {"Social Security"->React.string} </ListItem>
    </UnorderedList>
    <ContactCTA />
  </Layout>
