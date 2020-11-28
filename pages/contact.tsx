import Head from "next/head";
import { make as Layout } from "../components/Layout.bs";
import { make as Toast } from "../components/Toast.bs";
import { make as Paragraph } from "../components/Paragraph.bs";
import { make as TextButton } from "../components/TextButton.bs";
import { make as Button } from "../components/Button.bs";
import { make as FormControl } from "../components/FormControl.bs";
import { className as inputClassName } from "../components/Input.bs";
import { Styles as HeadingStyles } from "../components/Heading.bs";
import { useState, useEffect, useRef, FormEvent } from "react";

const EMAIL = "Paul@LifeStewardshipLLC.com";

export default function Index() {
  let [toast, setToast] = useState(null);
  let [errors, setErrors] = useState([]);
  let [reCaptchaLoadAttempts, setReCaptchaLoadAttempts] = useState(0);
  let reCaptchaId = useRef(null);

  function loadReCaptcha() {
    if (reCaptchaId.current !== null) {
      return;
    }

    window.onReCaptchaLoad = () => {
      setReCaptchaLoadAttempts(0);
      reCaptchaId.current = window.grecaptcha.render("js-reCaptcha", {
        sitekey: process.env.NEXT_PUBLIC_RECAPTCHA_SITE_KEY,
      });
    };

    if (window.grecaptcha) {
      window.onReCaptchaLoad();
    } else {
      let scriptTag = document.createElement("script");
      scriptTag.async = true;
      scriptTag.onerror = () => {
        setReCaptchaLoadAttempts((c) => c + 1);
      };
      scriptTag.src =
        "//www.google.com/recaptcha/api.js?onload=onReCaptchaLoad&render=explicit";
      document.getElementsByTagName("script");
      document.body.appendChild(scriptTag);
    }
  }

  // Load reCAPTCHA on initial render
  useEffect(() => {
    if (typeof window === "undefined") {
      return;
    }

    // TODO: Avoid recaptcha render after component is destroyed
    loadReCaptcha();

    return () => {
      if (window.grecaptcha && reCaptchaId.current !== null) {
        window.grecaptcha.reset(reCaptchaId.current);
      }
    };
  }, []);

  // Clear toast message
  useEffect(() => {
    if (!toast) {
      return;
    }

    let toastTO = setTimeout(() => {
      setToast(null);
    }, 5000);

    return () => {
      clearTimeout(toastTO);
    };
  }, [toast]);

  function handleFormSubmit(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();
    let form = event.currentTarget;
    let errors = Array.from(form.elements)
      .filter((el: HTMLInputElement) => !el.checkValidity())
      .map((el: HTMLInputElement) => ({
        subject: el.name,
        message: el.dataset.errorMessage,
      }));

    if (errors.length > 0) {
      setErrors(errors);
      return;
    }

    setErrors([]);
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
      .then((response) =>
        response.json().then((json) => ({
          ...response,
          json,
        }))
      )
      .then((response) => {
        if (response.ok) {
          setToast("Your message was sent successfully.");
        } else {
          throw new Error(
            (response.json && response.json.error) ||
              "Network response was not OK."
          );
        }
      })
      .catch((error) => {
        setErrors([{ subject: "form", message: error.message }]);
      });
  }

  return (
    <Layout>
      <Head>
        <title>Contact - Life Stewardship</title>
      </Head>
      <h1 className={`${HeadingStyles.primary} mb-4 lg:mb-8`}>Contact</h1>
      <address>
        <dl className="text-base lg:text-2xl mb-4 lg:mb-8">
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
            {/* @ts-ignore */}
            <TextButton href={`mailto:${EMAIL}`}>{EMAIL}</TextButton>
          </dd>
        </dl>
      </address>
      <Paragraph>
        If you’d like to receive more information or ask a question about our
        services, please fill out the form below.
      </Paragraph>

      {reCaptchaLoadAttempts > 2 ? (
        <Paragraph>
          Multiple attempts to load the contact form failed. We recommend
          emailing us directly at <a href={`mailto:${EMAIL}`}>{EMAIL}</a>.
        </Paragraph>
      ) : reCaptchaLoadAttempts > 0 ? (
        <Paragraph>
          Loading the contact form failed.{" "}
          <button type="button" onClick={loadReCaptcha}>
            Please try again.
          </button>
        </Paragraph>
      ) : null}

      <form
        action="https://formspree.io/xyynddoo"
        method="post"
        noValidate
        onSubmit={handleFormSubmit}
      >
        <FormControl
          className="mb-4 lg:mb-8"
          errors={errors}
          label="Name (required)"
          name="name"
        >
          <input
            className={inputClassName}
            placeholder="Jane Doe"
            type="text"
            name="name"
            id="name"
            required
            data-error-message="Name is required."
          />
        </FormControl>
        <FormControl
          className="mb-4 lg:mb-8"
          errors={errors}
          label="Email (required)"
          name="_replyto"
        >
          <input
            className={inputClassName}
            placeholder="jane.doe@example.com"
            type="email"
            name="_replyto"
            id="_replyto"
            required
            data-error-message="Valid email is required."
          />
        </FormControl>
        <input type="hidden" name="_subject" value="Life Stewardship Inquiry" />
        <FormControl
          className="mb-4 lg:mb-8"
          errors={errors}
          label="Phone"
          name="phone"
        >
          <input
            className={inputClassName}
            placeholder="555-555-5555"
            type="tel"
            name="phone"
            id="phone"
          />
        </FormControl>
        <FormControl
          className="mb-4 lg:mb-8"
          errors={errors}
          label="Message (required)"
          name="message"
        >
          <textarea
            className={inputClassName}
            cols={30}
            data-error-message="Messaged required."
            id="message"
            name="message"
            placeholder="Tell me more about your project, needs, or timeline."
            required
            rows={10}
          ></textarea>
        </FormControl>
        <div id="js-reCaptcha" className="mb-4 lg:mb-8" />
        {/* @ts-ignore */}
        <Button className="mb-4 lg:mb-8 block w-full" type_="submit">Send Message</Button>
      </form>

      {errors.filter(({subject}) => subject === "form").length > 0 ? (
        <Toast
          className="fixed top-5 left-2/4 w-full lg:w-2/4 transform -translate-x-1/2 bg-red-500 border-red-700 text-white">
          {errors
            .filter(({ subject }) => subject === "form")
            .map(({ message }, index) => (
              <span key={index}>
                {message}
                <br />
              </span>
            ))}
        </Toast>
      ) : null}

      {toast ? (
        <Toast
          className="fixed top-5 left-2/4 w-full lg:w-2/4 transform -translate-x-1/2"
          onDismiss={() => {
            setToast(null);
          }}
        >
          {toast}
        </Toast>
      ) : null}
    </Layout>
  );
}
