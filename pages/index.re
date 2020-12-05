open React;

[@react.component]
let default = () => {
  <Layout>
    <Next.Head>
      <title>
        "Life Stewardship, Financial Planning & Coaching"->string
      </title>
    </Next.Head>
    <div className="bg-white text-gray-700 rounded mb-5 p-4 shadow-md">
      <h1
        className="text-2xl lg:text-4xl font-light leading-tight mb-5 text-center">
        "Financial planning and coaching for nonprofits and individuals."
        ->string
      </h1>
      <h2 className="text-sm lg:text-3xl text-gray-500 italic text-center">
        "Life Stewardship LLC is a financial service firm located in Madison,
          Mississippi."
        ->string
      </h2>
    </div>
    <img className="mx-auto rounded-2xl w-40 mb-5" src="paul-calhoun.jpg" />
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
    <div className="my-10">
      <h3
        className="text-xl font-normal tracking-wider text-center uppercase mb-5">
        "Professional & Community Affiliation"->string
      </h3>
      <div className="grid gap-4 grid-cols-1">
        <Affiliation>
          "American Institute of Certified Public Accountants"->string
        </Affiliation>
        <Affiliation> "AICPA Not-for-Profit Section"->string </Affiliation>
        <Affiliation>
          "AICPA Personal Financial Planning Section"->string
        </Affiliation>
        <Affiliation>
          "Vice-Chairman Baptist Hospital Board of Directors"->string
        </Affiliation>
      </div>
    </div>
  </Layout>;
};
