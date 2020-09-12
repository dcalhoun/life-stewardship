[@react.component]
let default = () => {
  <>
    <Next.Head>
      <title> "Nonprofit - Life Stewardship"->React.string </title>
    </Next.Head>
    <Navigation />
    <main id="content">
      <h1> "Nonprofit"->React.string </h1>
      <img
        src="/header-nonprofit.jpg"
        alt="Neon light sign displaying the phrase do something great"
      />
      <p>
        <b> "Do something great."->React.string </b>
        " Serving others or making things better is
          the mission of all nonprofits. That is why they exist and why we give
          our time and money to nonprofits. When they accept our time and money,
          they assume a stewardship responsibility for them."
        ->React.string
      </p>
      <p>
        "Board members and management have the primary responsibility for
          stewardship of the nonprofit’s assets. This is a critical
          responsibility because nonprofits are accountable to their
          clients/constituents, donors, the public, and government authorities."
        ->React.string
      </p>
      <p>
        "For the board of directors and management to fulfill their fiduciary
          responsibilities, a nonprofit must develop a sound accounting and
          financial reporting system which includes appropriate internal
          controls based on the size and complexity of the organization.
          Internal controls designed to achieve effective and efficient
          operations, reliable financial reporting, and compliance with
          applicable laws and regulations."
        ->React.string
      </p>
      <p>
        "Many nonprofits lack expertise and knowledge or time to develop their
          accounting and financial reporting system and have limited external
          support. I have extensive experience working with nonprofits and can
          help the board of directors and management fulfill their fiduciary
          responsibilities."
        ->React.string
      </p>
      <p>
        "If you want more information or need help fulfilling your fiduciary
          responsibilities, let’s talk. I can assist you with:"
        ->React.string
      </p>
      <ul>
        <li> "Assisting with Board Governance & Oversight"->React.string </li>
        <li> "Board of Director Training"->React.string </li>
        <li> "Financial Statement Preparation"->React.string </li>
        <li> "Functional Expense Reporting"->React.string </li>
        <li> "Grant Compliance"->React.string </li>
        <li> "Internal Controls"->React.string </li>
        <li> "Tax Compliance"->React.string </li>
      </ul>
    </main>
  </>;
};
