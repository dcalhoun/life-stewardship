import Head from "next/head";
import Navigation from "../components/Navigation";
import { useState, useEffect } from "react";

export default function Index() {
  let [toast, setToast] = useState(null);
  let [error, setError] = useState(null);

  useEffect(() => {
    let toastTO = setTimeout(() => {
      setToast(null);
    }, 3000);

    return () => {
      clearTimeout(toastTO);
    };
  }, [toast]);

  function handleFormSubmit(event) {
    event.preventDefault();
    let form = event.currentTarget;
    if (!form.checkValidity()) {
      setError("Please fill all required fields.");
      return;
    }
    setError(null);
    let formData = new FormData(form);
    let formEntries = Array.from(formData.entries()).reduce(
      (acc, [key, value]) => (value ? { ...acc, [key]: value } : acc),
      {}
    );

    fetch(form.action, {
      method: form.method,
      body: JSON.stringify(formEntries),
      headers: { "Content-Type": "application/json" },
    })
      .then((response) => {
        if (response.ok) {
          setToast("Your message was sent successfully.");
        } else {
          throw new Error("Network response was not OK.");
        }
      })
      .catch((error) => {
        setError(
          `Your message failed to send. Please try again or email us directly. Error details: ${error.message}`
        );
      });
  }

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
        <p>
          If you’d like to receive more information or ask a question about our
          services, please fill out the form below.
        </p>
        {toast ? <p>{toast}</p> : null}
        {error ? <p>{error}</p> : null}
        <form
          action="https://formspree.io/xyynddoo"
          method="post"
          noValidate
          onSubmit={handleFormSubmit}
        >
          <div>
            <label htmlFor="name">Name (required)</label>
            <input type="text" name="name" id="name" required />
          </div>
          <div>
            <label htmlFor="_replyto">Email (required)</label>
            <input type="email" name="_replyto" id="_replyto" required />
          </div>
          <input
            type="hidden"
            name="_subject"
            value="New Life Stewardship Inquiry"
          />
          <div>
            <label htmlFor="phone">Phone</label>
            <input type="tel" name="phone" id="phone" />
          </div>
          <div>
            <label htmlFor="fax">Fax</label>
            <input type="tel" name="fax" id="fax" />
          </div>
          <div>
            <label htmlFor="address">Address 1</label>
            <input type="text" name="address" id="address" />
          </div>
          <div>
            <label htmlFor="address">Address 2</label>
            <input type="text" name="address" id="address" />
          </div>
          <div>
            <label htmlFor="city">City</label>
            <input type="text" name="city" id="city" />
          </div>
          <div>
            <label htmlFor="state">State</label>
            <input type="text" name="state" id="state" maxLength={2} />
          </div>
          <div>
            <label htmlFor="zip-code">ZIP Code</label>
            <input type="text" name="zip-code" id="zip-code" />
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
