open React;

[@react.component]
let default = () => {
  <Layout>
    <Next.Head>
      <title> "Individuals - Life Stewardship"->string </title>
    </Next.Head>
    <main id="content">
      <h1 className=(Heading.Styles.primary ++ " mb-4 lg:mb-8")> "Individuals"->string </h1>
      <img
        className="mb-4 lg:mb-8"
        src="/header-individuals.jpg"
        alt="Full coffee mug with the word begin on it resting on a table"
      />
      <Paragraph>
        <b> "Begin."->string </b>
        " Beginning is often the hardest step. We do not know how
          to get started, so we procrastinate. We may know what needs to be done
          but life is busy, so we procrastinate. We may believe its complex and
          we do not know who to talk with, so we procrastinate. Seldom does
          procrastination solve our problems, it may limit our options; and it
          may not provide us the best solutions"
        ->string
      </Paragraph>
      <Paragraph>
        "Being a good steward of our personal finances is something we all
          recognize is important. We want to reduce the financial stress in our
          lives, and we want to give, spend, and save our money wisely so that
          we can accomplish the goals which are important to us."
        ->string
      </Paragraph>
      <Paragraph>
        "Stewardship is the lifelong process of managing everything God
          provides us in a manner that honors God. We can honor God by wisely
          using what He has given us to provide for ourselves, our families, and
          others."
        ->string
      </Paragraph>
      <Paragraph>
        <b> "Begin."->string </b>
        (" If you are ready to get begin, let" ++ {j|’|j} ++ "s talk. I can assist
          you with:")
        ->string
      </Paragraph>
      <UnorderedList>
        <ListItem> "Clarifying Your Financial Goals"->string </ListItem>
        <ListItem> "Budgeting & Tracking"->string </ListItem>
        <ListItem> "Cash Management & Planning"->string </ListItem>
        <ListItem> "Debt Payoff & Management"->string </ListItem>
        <ListItem> "Education Funding"->string </ListItem>
        <ListItem> "Retirement Planning"->string </ListItem>
        <ListItem> "Social Security"->string </ListItem>
      </UnorderedList>
    </main>
  </Layout>;
};
