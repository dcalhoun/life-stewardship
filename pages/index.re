open React;

[@react.component]
let default = () => {
  <Layout>
    <Next.Head>
      <title>
        "Life Stewardship, Financial Planning & Coaching"->string
      </title>
    </Next.Head>
    <h1 className={Heading.Styles.primary ++ " mb-4 lg:mb-8 text-center"}>
      "Financial planning and coaching for nonprofits and individuals."->string
    </h1>
    <h2 className={Heading.Styles.secondary ++ " mb-4 lg:mb-8 text-center"}>
      "Life Stewardship LLC is a financial service firm located in Madison,
          Mississippi."
      ->string
    </h2>
    <Paragraph>
      "My name is Paul Calhoun, the founder and managing member of Life
          Stewardship LLC. Until my retirement in December 2019, I was a partner
          with a sixty-person certified public accounting firm, serving 12 years
          as its managing partner."
      ->string
    </Paragraph>
    <Paragraph>
      "During my 43-year career in public accounting, my practice included
          providing audit, consulting, and tax services to nonprofit
          organizations just starting up, to ones which have matured to serving
          thousands of people. I have had the privilege of working with several
          organizations serving as a volunteer and committee member. I have
          served as an officer and board member including finance chairman,
          treasurer, president, vice chairman and board chairman."
      ->string
    </Paragraph>
    <Paragraph>
      "My public accounting practice also included working with individuals
          regarding their financial planning and income taxes."
      ->string
    </Paragraph>
    <Paragraph> "Professional and Community Affiliation:"->string </Paragraph>
    <UnorderedList>
      <ListItem>
        "American Institute of Certified Public Accountants"->string
      </ListItem>
      <ListItem> "AICPA Not-for-Profit Section"->string </ListItem>
      <ListItem>
        "AICPA Personal Financial Planning Section"->string
      </ListItem>
      <ListItem>
        "Vice-Chairman Baptist Hospital Board of Directors"->string
      </ListItem>
    </UnorderedList>
  </Layout>;
};
