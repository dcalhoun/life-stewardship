@react.component
let default = () =>
  <Layout>
    <SEO />
    <div
      className="flex flex-col justify-center bg-white text-gray-700 rounded-lg mb-5 py-4 px-8 lg:px-24 lg:py-10 shadow-md"
      style={ReactDOM.Style.make(~minHeight="10rem", ())}>
      <h1 className="text-2xl lg:text-4xl font-light leading-tight mb-5 text-center">
        {"Financial planning and coaching for nonprofits and individuals."->React.string}
      </h1>
      <h2 className="text-sm lg:text-2xl text-gray-500 italic text-center">
        {"Life Stewardship LLC is a financial service firm located in Madison,
          Mississippi."->React.string}
      </h2>
    </div>
    <div className="lg:grid lg:grid-cols-2">
      <div className="mx-auto mb-5 lg:my-auto w-40 lg:w-80">
        <Next.Image
          className="rounded-2xl bg-gray-500" src="/paul-calhoun.jpg" height=400 width=320
        />
      </div>
      <div className="max-w-xl mx-auto">
        <Paragraph>
          {"My name is Paul Calhoun, the founder and managing member of Life
          Stewardship LLC. Until my retirement in December 2019, I was a partner
          with a sixty-person certified public accounting firm, serving 12 years
          as its managing partner."->React.string}
        </Paragraph>
        <Paragraph>
          {"During my 43-year career in public accounting, my practice included
          providing audit, consulting, and tax services to nonprofit
          organizations just starting up, to ones which have matured to serving
          thousands of people. I have had the privilege of working with several
          organizations serving as a volunteer and committee member. I have
          served as an officer and board member including finance chairman,
          treasurer, president, vice chairman and board chairman."->React.string}
        </Paragraph>
        <Paragraph>
          {"My public accounting practice also included working with individuals
          regarding their financial planning and income taxes."->React.string}
        </Paragraph>
      </div>
    </div>
    <h3 className="text-xl font-light tracking-wider text-center uppercase mb-5">
      {"Professional & Community Affiliation"->React.string}
    </h3>
    <div className="grid gap-5 grid-cols-1 lg:grid-cols-2">
      <Affiliation>
        {"American Institute of Certified Public Accountants"->React.string}
      </Affiliation>
      <Affiliation> {"AICPA Not-for-Profit Section"->React.string} </Affiliation>
      <Affiliation> {"AICPA Personal Financial Planning Section"->React.string} </Affiliation>
      <Affiliation>
        {"Vice-Chairman Baptist Hospital Board of Directors"->React.string}
      </Affiliation>
    </div>
    <ContactCTA />
  </Layout>
