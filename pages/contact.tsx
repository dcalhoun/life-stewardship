import Head from "next/head";
import { make as Layout } from "../components/Layout.bs";
import { make as Toast } from "../components/Toast.bs";
import { make as Paragraph } from "../components/Paragraph.bs";
import { make as TextButton } from "../components/TextButton.bs";
import { make as Button } from "../components/Button.bs";
import { make as FormControl } from "../components/FormControl.bs";
import { make as ContactInfo } from "../components/ContactInfo.bs";
import { className as inputClassName } from "../components/Input.bs";
import { Styles as HeadingStyles } from "../components/Heading.bs";
import { useState, useEffect, useRef, FormEvent } from "react";

const EMAIL = "Paul@LifeStewardshipLLC.com";

export default function Index() {
  let [toast, setToast] = useState(null);
  let [errors, setErrors] = useState([]);
  let [reCaptchaLoadAttempts, setReCaptchaLoadAttempts] = useState(0);
  let reCaptchaId = useRef(null);
  let formRef = useRef(null);

  function loadReCaptcha() {
    if (reCaptchaId.current !== null) {
      return;
    }

    window.onReCaptchaLoad = () => {
      setReCaptchaLoadAttempts(0);
      reCaptchaId.current = window.grecaptcha.render("js-reCaptcha", {
        sitekey: process.env.NEXT_PUBLIC_RECAPTCHA_SITE_KEY,
        callback: sendMessage,
        size: "invisible",
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
    formRef.current = event.currentTarget;
    const form = formRef.current;
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

    grecaptcha.execute();
  }

  function sendMessage() {
    setErrors([]);
    const form = formRef.current;
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
          json,
          ok: response.ok,
          status: response.status,
          statusText: response.statusText,
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
        grecaptcha.reset(reCaptchaId.current);
        setErrors([{ subject: "form", message: error.message }]);
      });
  }

  return (
    <Layout>
      <Head>
        <title>Contact - Life Stewardship</title>
      </Head>
      <h1 className={`${HeadingStyles.primary} mb-5 lg:mb-10`}>Contact</h1>
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
        action={process.env.NEXT_PUBLIC_FORMSPREE_ENDPOINT}
        method="post"
        noValidate
        onSubmit={handleFormSubmit}
      >
        <FormControl
          className="mb-5 lg:mb-10"
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
          className="mb-5 lg:mb-10"
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
        <input
          type="hidden"
          name="_subject"
          value="Life Stewardship LLC Inquiry"
        />
        <FormControl
          className="mb-5 lg:mb-10"
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
          className="mb-5 lg:mb-10"
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
        {/* @ts-ignore */}
        <Button className="block mx-auto mb-5 lg:mb-10" type_="submit">
          Send Message
        </Button>
        <div id="js-reCaptcha" className="g-recaptcha" />
      </form>

      {errors.filter(({ subject }) => subject === "form").length > 0 ? (
        <Toast
          className="fixed top-5 left-2/4 w-full lg:w-2/4 transform -translate-x-1/2 bg-red-500 border-red-700 text-white"
          onDismiss={() => setErrors([])}
        >
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

      <hr className="mb-5 border-gray-200" />

      <address className="pb-16 md:pb-0 md:flex justify-evenly">
        <ContactInfo icon="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z">
          1888 Main Street
          <br />
          Suite C-198
          <br />
          Madison, MS 39110
        </ContactInfo>
        <ContactInfo icon="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z">
          601-624-5135
        </ContactInfo>
        <ContactInfo icon="M16 12a4 4 0 10-8 0 4 4 0 008 0zm0 0v1.5a2.5 2.5 0 005 0V12a9 9 0 10-9 9m4.5-1.206a8.959 8.959 0 01-4.5 1.207">
          {/* @ts-ignore */}
          <TextButton
            href={`mailto:Paul%20Calhoun<${EMAIL}>?subject=Life%20Stewardship%20LLC%20Inquiry`}
          >
            {EMAIL}
          </TextButton>
        </ContactInfo>
      </address>
    </Layout>
  );
}
