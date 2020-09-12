import Head from "next/head";
import { make as Navigation } from "../components/Navigation.bs";
import {
  useState,
  useEffect,
  useRef,
  PropsWithChildren,
  ReactElement,
  FormEvent,
} from "react";

const EMAIL = "Paul@LifeStewardshipLLC.com";

interface FormError {
  subject: string;
  message: string;
}

interface FormControlProps {
  errors: FormError[];
  name: string;
  label: string;
}

function FormControl({
  children,
  errors,
  label,
  name,
}: PropsWithChildren<FormControlProps>): ReactElement {
  let error = errors.find(({ subject }) => subject === name);
  return (
    <div>
      <label htmlFor={name}>{label}</label>
      {children}
      {error ? <span>{error.message}</span> : null}
    </div>
  );
}

interface ToastProps {
  onDismiss(): void;
}

function Toast({
  children,
  onDismiss,
}: PropsWithChildren<ToastProps>): ReactElement {
  return (
    <div>
      <button onClick={onDismiss}>Dismiss</button>
      {children}
    </div>
  );
}

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
    <>
      <Head>
        <title>Contact - Life Stewardship</title>
      </Head>
      <Navigation />
      <main id="content">
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
              <a href={`mailto:${EMAIL}`}>{EMAIL}</a>
            </dd>
          </dl>
        </address>
        <p>
          If you’d like to receive more information or ask a question about our
          services, please fill out the form below.
        </p>

        {reCaptchaLoadAttempts > 2 ? (
          <p>
            Multiple attempts to load the contact form failed. We recommend
            emailing us directly at <a href={`mailto:${EMAIL}`}>{EMAIL}</a>.
          </p>
        ) : reCaptchaLoadAttempts > 0 ? (
          <p>
            Loading the contact form failed.{" "}
            <button type="button" onClick={loadReCaptcha}>
              Please try again.
            </button>
          </p>
        ) : null}

        <form
          action="https://formspree.io/xyynddoo"
          method="post"
          noValidate
          onSubmit={handleFormSubmit}
        >
          <FormControl label="Name (required)" name="name" errors={errors}>
            <input
              type="text"
              name="name"
              id="name"
              required
              data-error-message="Name is required."
            />
          </FormControl>
          <FormControl label="Email (required)" name="_replyto" errors={errors}>
            <input
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
            value="New Life Stewardship Inquiry"
          />
          <FormControl label="Phone" name="phone" errors={errors}>
            <input type="tel" name="phone" id="phone" />
          </FormControl>
          <FormControl label="Fax" name="fax" errors={errors}>
            <input type="tel" name="fax" id="fax" />
          </FormControl>
          <FormControl label="Address 1" name="address-1" errors={errors}>
            <input type="text" name="address-1" id="address-1" />
          </FormControl>
          <FormControl label="Address 2" name="address-2" errors={errors}>
            <input type="text" name="address-2" id="address-2" />
          </FormControl>
          <FormControl label="City" name="city" errors={errors}>
            <input type="text" name="city" id="city" />
          </FormControl>
          <FormControl label="State" name="state" errors={errors}>
            <input type="text" name="state" id="state" maxLength={2} />
          </FormControl>
          <FormControl label="ZIP Code" name="zip-code" errors={errors}>
            <input type="text" name="zip-code" id="zip-code" />
          </FormControl>
          <FormControl
            label="Message (required)"
            name="message"
            errors={errors}
          >
            <textarea
              name="message"
              id="message"
              cols={30}
              rows={10}
              required
              data-error-message="Messaged required."
            ></textarea>
          </FormControl>
          <div id="js-reCaptcha" />
          <button type="submit">Send Message</button>
        </form>

        {errors.length > 0 ? (
          <p>
            {errors
              .filter(({ subject }) => subject === "form")
              .map(({ message }, index) => (
                <span key={index}>
                  {message}
                  <br />
                </span>
              ))}
          </p>
        ) : null}

        {toast ? (
          <Toast
            onDismiss={() => {
              setToast(null);
            }}
          >
            {toast}
          </Toast>
        ) : null}
      </main>
    </>
  );
}
