import Head from "next/head";
import Navigation from "../components/Navigation";

export default function Index() {
  return (
    <>
      <Head>
        <title>Life Stewardship, Financial Planning &amp; Coaching</title>
      </Head>
      <Navigation />
      <main id="content">
        <h1>Life Stewardship</h1>
        <p>
          Life Stewardship LLC is a financial service firm located in Madison,
          Mississippi. Providing financial planning and coaching to nonprofits
          and individuals.
        </p>
        <p>
          My name is Paul Calhoun, the founder and managing member of Life
          Stewardship LLC. Until my retirement in December 2019, I was a partner
          with a sixty-person certified public accounting firm, serving 12 years
          as its managing partner.
        </p>
        <p>
          During my 43-year career in public accounting, my practice included
          providing audit, consulting, and tax services to nonprofit
          organizations just starting up, to ones which have matured to serving
          thousands of people. I have had the privilege of working with several
          organizations serving as a volunteer and committee member. I have
          served as an officer and board member including finance chairman,
          treasurer, president, vice chairman and board chairman.
        </p>
        <p>
          My public accounting practice also included working with individuals
          regarding their financial planning and income taxes.
        </p>
        <p>Professional and Community Affiliation</p>
        <ul>
          <li>American Institute of Certified Public Accountants </li>
          <li>AICPA Not-for-Profit Section</li>
          <li>AICPA Personal Financial Planning Section</li>
          <li>Vice-Chairman Baptist Hospital Board of Directors</li>
        </ul>
      </main>
    </>
  );
}
