import Head from "next/head";
import Navigation from "../components/Navigation";

export default function Index() {
  return (
    <>
      <Head>
        <title>Contact - Life Stewardship</title>
      </Head>
      <Navigation />
      <main>
        <h1>Contact</h1>
        <address>
          <dl>
            <dt>Mail</dt>
            <dd>
              1888 Main Street
              <br />
              Suite C-198
              <br />
              Madison, MS 39110
            </dd>
            <dt>Phone</dt>
            <dd>(601) 624-5135</dd>
            <dt>Email</dt>
            <dd>
              <a href="mailto:paul@pcalhoun.com">paul@pcalhoun.com</a>
            </dd>
          </dl>
        </address>
        <form action="">
          <div>
            <label htmlFor="name">Name (required)</label>
            <input type="text" name="name" id="name" required />
          </div>
          <div>
            <label htmlFor="email">Email (required)</label>
            <input type="email" name="email" id="email" required />
          </div>
          <div>
            <label htmlFor="phone">Phone</label>
            <input type="tel" name="phone" id="phone" />
          </div>
          <div>
            <label htmlFor="fax">Fax</label>
            <input type="tel" name="fax" id="fax" />
          </div>
          <div>
            <label htmlFor="address">Address</label>
            <input type="text" name="address" id="address" />
          </div>
          <div>
            <label htmlFor="message">Message (required)</label>
            <textarea
              name="message"
              id="message"
              cols={30}
              rows={10}
              required
            ></textarea>
          </div>
          <button type="submit">Send Message</button>
        </form>
      </main>
    </>
  );
}
