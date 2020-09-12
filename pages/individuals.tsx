import Head from "next/head";
import { make as Navigation } from "../components/Navigation.bs";

export default function Index() {
  return (
    <>
      <Head>
        <title>Individuals - Life Stewardship</title>
      </Head>
      <Navigation />
      <main id="content">
        <h1>Individuals</h1>

        <img
          src="/header-individuals.jpg"
          alt="Full coffee mug with the word begin on it resting on a table"
        />

        <p>
          <b>Begin.</b> Beginning is often the hardest step. We do not know how
          to get started, so we procrastinate. We may know what needs to be done
          but life is busy, so we procrastinate. We may believe its complex and
          we do not know who to talk with, so we procrastinate. Seldom does
          procrastination solve our problems, it may limit our options; and it
          may not provide us the best solutions
        </p>

        <p>
          Being a good steward of our personal finances is something we all
          recognize is important. We want to reduce the financial stress in our
          lives, and we want to give, spend, and save our money wisely so that
          we can accomplish the goals which are important to us.
        </p>

        <p>
          Stewardship is the lifelong process of managing everything God
          provides us in a manner that honors God. We can honor God by wisely
          using what He has given us to provide for ourselves, our families, and
          others.
        </p>

        <p>
          <b>Begin.</b> If you are ready to get begin, let’s talk. I can assist
          you with:
        </p>

        <ul>
          <li>Clarifying Your Financial Goals</li>
          <li>Budgeting & Tracking</li>
          <li>Cash Management & Planning</li>
          <li>Debt Payoff & Management</li>
          <li>Education Funding</li>
          <li>Retirement Planning</li>
          <li>Social Security </li>
        </ul>
      </main>
    </>
  );
}
