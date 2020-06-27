import Head from "next/head";
import Navigation from "../components/Navigation";

export default function Index() {
  return (
    <>
      <Head>
        <title>Individuals - Life Stewardship</title>
      </Head>
      <Navigation />
      <main>
        <h1>Individuals</h1>
        <p>
          Being a good steward of our personal finances is something we all
          recognize is important. But because we do not know where to get
          started or do not know who to talk to, we procrastinate.
        </p>

        <p>
          Stewardship is the lifelong process of managing everything God
          provides us in a manner that honors God. We can honor God by wisely
          using what He has given us to provide for ourselves, our families, and
          others.
        </p>

        <p>
          If you are ready to get started, let’s talk. We can assist you with:
        </p>

        <ul>
          <li>Clarifying Your Financial Goals</li>
          <li>Budgeting & Tracking</li>
          <li>Cash Management & Planning</li>
          <li>Debt Payoff & Management</li>
          <li>Education Funding</li>
          <li>Retirement Planning</li>
          <li>Social Security</li>
        </ul>
      </main>
    </>
  );
}
