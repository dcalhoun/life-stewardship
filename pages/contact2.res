let email = "Paul@LifeStewardshipLLC.com"

@bs.val
external reCaptchaSiteKey: option<string> = "process.env.NEXT_PUBLIC_RECAPTCHA_SITE_KEY"

@bs.val
external formspreeEndpoint: option<string> = "process.env.NEXT_PUBLIC_RECAPTCHA_SITE_KEY"

@react.component
let default = () => {
  let (toast, setToast) = React.useState(_ => "")
  let (errors, setErrors) = React.useState(_ => [])

  let handleFormSubmit = _ => ()
  let sendMessage = _ => ()
  let (_greptcha, reCaptchaLoadAttempts, loadReCaptcha) = ReCaptcha.useReCaptcha(
    ~callback=sendMessage,
    ~key=reCaptchaSiteKey,
  )

  let formErrors = Belt.Array.keep(errors, ({FormControl.subject: subject}) => subject === "form")

  // Clear toast message
  React.useEffect1(() => {
    switch toast->Js.String.length > 0 {
    | false => None
    | true =>
      let toastTO = Js.Global.setTimeout(() => {setToast(_ => "")}, 5000)
      Some(() => Js.Global.clearTimeout(toastTO))
    }
  }, [toast])

  <Layout>
    <Next.Head> <title> {"Contact - Life Stewardship"->React.string} </title> </Next.Head>
    <h1 className={Heading.Styles.primary ++ " mb-5 lg:mb-10"}> {"Contact"->React.string} </h1>
    <Paragraph>
      {`If you’d like to receive more information or ask a question about our services, please fill out the form below.`->React.string}
    </Paragraph>
    {reCaptchaLoadAttempts > 2
      ? <Paragraph>
          {"Multiple attempts to load the contact form failed. We recommend
          emailing us directly at"->React.string}
          <a href={"mailto:" ++ email}> {email->React.string} </a>
          {"."->React.string}
        </Paragraph>
      : reCaptchaLoadAttempts > 0
      ? <Paragraph>
        {"Loading the contact form failed. "->React.string}
        <button type_="button" onClick={loadReCaptcha}>
          {"Please try again."->React.string}
        </button>
      </Paragraph>
      : React.null}
    <form
      action={Belt.Option.getWithDefault(formspreeEndpoint, "POST")}
      method="post"
      noValidate=true
      onSubmit={handleFormSubmit}>
      <FormControl className="mb-5 lg:mb-10" errors={errors} label="Name (required)" name="name">
        <Spread props={"data-error-message": "Name is required."}>
          <input
            className={Input.className}
            placeholder="Jane Doe"
            type_="text"
            name="name"
            id="name"
            required=true
          />
        </Spread>
      </FormControl>
      <FormControl
        className="mb-5 lg:mb-10" errors={errors} label="Email (required)" name="_replyto">
        <Spread props={"data-error-message": "Valid email is required."}>
          <input
            className={Input.className}
            placeholder="jane.doe@example.com"
            type_="email"
            name="_replyto"
            id="_replyto"
            required=true
          />
        </Spread>
      </FormControl>
      <input type_="hidden" name="_subject" value="Life Stewardship LLC Inquiry" />
      <FormControl className="mb-5 lg:mb-10" errors={errors} label="Phone" name="phone">
        <input
          className={Input.className} placeholder="555-555-5555" type_="tel" name="phone" id="phone"
        />
      </FormControl>
      <FormControl
        className="mb-5 lg:mb-10" errors={errors} label="Message (required)" name="message">
        <Spread props={"data-error-message": "Message required."}>
          <textarea
            className={Input.className}
            cols={30}
            id="message"
            name="message"
            placeholder="Tell me more about your project, needs, or timeline."
            required=true
            rows={10}
          />
        </Spread>
      </FormControl>
      <Button className="block mx-auto mb-5 lg:mb-10" type_="submit">
        {"Send Message"->React.string}
      </Button>
      <div id="js-reCaptcha" className="g-recaptcha" />
    </form>
    {formErrors->Belt.Array.length > 0
      ? <Toast
          className="fixed top-5 left-2/4 w-full lg:w-2/4 transform -translate-x-1/2 bg-red-500 border-red-700 text-white"
          onDismiss={_ => setErrors(_ => [])}>
          {Belt.Array.mapWithIndex(formErrors, (index, {FormControl.message: message}) =>
            <span key={index->Belt.Int.toString}> {message->React.string} <br /> </span>
          )->React.array}
        </Toast>
      : React.null}
    {toast->Js.String.length > 0
      ? <Toast
          className="fixed top-5 left-2/4 w-full lg:w-2/4 transform -translate-x-1/2"
          onDismiss={_ => {
            setToast(_ => "")
          }}>
          {toast->React.string}
        </Toast>
      : React.null}
    <hr className="mb-5 border-gray-200" />
    <address className="pb-16 md:pb-0 md:flex justify-evenly">
      <ContactInfo
        icon="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z">
        {"1888 Main Street"->React.string}
        <br />
        {"Suite C-198"->React.string}
        <br />
        {"Madison, MS 39110"->React.string}
      </ContactInfo>
      <ContactInfo
        icon="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z">
        {"601-624-5135"->React.string}
      </ContactInfo>
      <ContactInfo
        icon="M16 12a4 4 0 10-8 0 4 4 0 008 0zm0 0v1.5a2.5 2.5 0 005 0V12a9 9 0 10-9 9m4.5-1.206a8.959 8.959 0 01-4.5 1.207">
        <TextButton
          href={"mailto:Paul%20Calhoun<" ++ email ++ "?subject=Life%20Stewardship%20LLC%20Inquiry"}>
          {email->React.string}
        </TextButton>
      </ContactInfo>
    </address>
  </Layout>
}
