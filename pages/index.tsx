import Head from "next/head";
import Navigation from "../components/Navigation";

export default function Index() {
  return (
    <main>
      <Head>
        <title>Life Stewardship, Financial Planning &amp; Coaching</title>
      </Head>
      <Navigation />
      <h1>Life Stewardship</h1>
      <p>
        Life Stewardship LLC is a financial service firm located in Madison,
        Mississippi. We seek to provide financial advisory and consulting to
        nonprofit organizations management and board of directors. We also
        provide financial planning and coaching to individuals to find answers
        to their financial questions or goals.
      </p>
      <h2>Paul Calhoun, CPA</h2>
      <p>
        Paul is the founder and managing member of Life Stewardship LLC. Until
        his retirement in 2019, he was a partner with a sixty person certified
        public accounting firm, serving 12 years as its managing partner.
      </p>
      <p>
        During his 43-year career in public accounting his practice included
        providing audit, consulting and tax services to nonprofit organization
        just beginning their mission to ones which have matured to serving
        hundreds of people.
      </p>
      <p>
        He has also served as a finance chairman, officer, and board member for
        several nonprofit organizations. He has provided financial and tax
        planning for hundreds of individuals to accomplish their goals.
      </p>
      <p>Professional and Community Affiliation</p>
      <ul>
        <li>American Institute of Certified Public Accountants </li>
        <li>Mississippi Society of Certified Public Accountants</li>
        <li>Vice-Chairman Baptist Hospital Board of Directors</li>
      </ul>
    </main>
  );
}
