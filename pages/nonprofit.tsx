import Head from "next/head";
import Navigation from "../components/Navigation";

export default function Index() {
  return (
    <main>
      <Head>
        <title>Nonprofit - Life Stewardship</title>
      </Head>
      <Navigation />
      <h1>Nonprofit</h1>
      <p>
        Effective nonprofit organizations are mission driven. Their management
        and board of directors recognize the importance of having a sound
        accounting and financial reporting system to help them to fulfill their
        fiduciary responsibility to donors and make good business decisions. We
        have extensive experience working with nonprofit organizations and
        recognize the unique characteristics of nonprofit organizations and
        their board of directors.
      </p>

      <p>
        If you are looking for ways to strengthen your organization with
        professionals who have a comprehensive understanding of operational
        issues, tax compliance and fiduciary responsibilities unique to
        nonprofit organizations, let’s talk. We can assist you with:
      </p>

      <ul>
        <li>Accounting System Conversion and Implementation</li>
        <li>Training for accounting staff</li>
        <li>Internal Controls</li>
        <li>Audit Preparation</li>
        <li>Financial Statement Preparation</li>
        <li>Grant Compliance</li>
        <li>Training for Board of Director </li>
        <li>Assisting with Board Governance & Oversite</li>
        <li>Strategic Financial Planning</li>
      </ul>
    </main>
  );
}
