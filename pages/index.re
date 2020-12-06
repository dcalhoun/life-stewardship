open React;

[@react.component]
let default = () => {
  <Layout>
    <Next.Head>
      <title>
        "Life Stewardship, Financial Planning & Coaching"->string
      </title>
    </Next.Head>
    <div
      className="flex flex-col justify-center bg-white text-gray-700 rounded-lg mb-5 py-4 px-8 lg:px-24 lg:py-10 shadow-md"
      style={ReactDOM.Style.make(~minHeight="10rem", ())}>
      <h1
        className="text-2xl lg:text-4xl font-light leading-tight mb-5 text-center">
        "Financial planning and coaching for nonprofits and individuals."
        ->string
      </h1>
      <h2 className="text-sm lg:text-2xl text-gray-500 italic text-center">
        "Life Stewardship LLC is a financial service firm located in Madison,
          Mississippi."
        ->string
      </h2>
    </div>
    <div className="lg:grid lg:grid-cols-2">
      <img
        className="mx-auto rounded-2xl w-40 lg:w-80 mb-5"
        src="paul-calhoun.jpg"
      />
      <div className="max-w-xl mx-auto">
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
        <Paragraph className="mb-10">
          "My public accounting practice also included working with individuals
          regarding their financial planning and income taxes."
          ->string
        </Paragraph>
      </div>
    </div>
    <h3
      className="text-xl font-light tracking-wider text-center uppercase mb-5">
      "Professional & Community Affiliation"->string
    </h3>
    <div className="grid gap-4 grid-cols-1 lg:grid-cols-2">
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
    <ContactCTA />
  </Layout>;
};
