let email = "Paul@LifeStewardshipLLC.com"
let mailTo = "mailto:Paul%20Calhoun<" ++ email ++ "?subject=Life%20Stewardship%20LLC%20Inquiry"

@bs.val
external reCaptchaSiteKey: option<string> = "process.env.NEXT_PUBLIC_RECAPTCHA_SITE_KEY"

@bs.val
external formspreeEndpoint: option<string> = "process.env.NEXT_PUBLIC_FORMSPREE_ENDPOINT"

@bs.new external createFormData: 'form => Js.Array.array_like<'formData> = "FormData"

@react.component
let default = () => {
  let (toast, setToast) = React.useState(_ => "")
  let (errors, setErrors) = React.useState(_ => [])
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

  let formRef = React.useRef(Js.Nullable.null)

  let sendMessage = _ => {
    setErrors(_ => [])
    let form = formRef.current
    let entries = Js.Dict.empty()
    form->createFormData->Js.Array.from->Belt.Array.forEach(entry => {
      switch entry {
      | [Some("name"), Some(value)] => entries->Js.Dict.set("name", Js.Json.string(value))
      | [Some("_replyto"), Some(value)] => entries->Js.Dict.set("_replyto", Js.Json.string(value))
      | [Some("_subject"), Some(value)] => entries->Js.Dict.set("_subject", Js.Json.string(value))
      | [Some("phone"), Some(value)] => entries->Js.Dict.set("phone", Js.Json.string(value))
      | [Some("message"), Some(value)] => entries->Js.Dict.set("message", Js.Json.string(value))
      | [Some("g-recaptcha-response"), Some(value)] =>
        entries->Js.Dict.set("g-recaptcha-response", Js.Json.string(value))
      | _ => ()
      }
    })
    switch form->Js.Nullable.toOption {
    | None => ()
    | Some(form) =>
      let _ =
        Fetch.fetchWithInit(
          form["action"],
          Fetch.RequestInit.make(
            ~method_=Post,
            ~body=entries->Js.Json.object_->Js.Json.stringify->Fetch.BodyInit.make,
            ~headers=Fetch.HeadersInit.make({"Content-Type": "application/json"}),
            (),
          ),
        )
        |> Js.Promise.then_(Fetch.Response.json)
        |> Js.Promise.then_(json => {
          Js.log2(">>>", json) |> Js.Promise.resolve
        })
        |> Js.Promise.catch(error => {
          // TODO(David): Currently rejected due to failed reCAPTCHA. Why? FormData?
          Js.log2(">>>", error) |> Js.Promise.resolve
        })
    }
  }

  let (grecaptcha, reCaptchaLoadAttempts, loadReCaptcha) = ReCaptcha.useReCaptcha(
    ~callback=sendMessage,
    ~key=reCaptchaSiteKey,
  )

  let handleFormSubmit = event => {
    event->ReactEvent.Form.preventDefault
    formRef.current = event->ReactEvent.Form.currentTarget->Js.Nullable.return
    let form = formRef.current
    switch form->Js.Nullable.toOption {
    | None => ()
    | Some(form) => {
        let errors =
          form["elements"]
          ->Js.Array.from
          ->Belt.Array.keep(el => !el["checkValidity"]())
          ->Belt.Array.map(el => {
            {FormControl.subject: el["name"], message: el["dataset"]["errorMessage"]}
          })

        if errors->Belt.Array.length > 0 {
          setErrors(_ => errors)
        } else {
          grecaptcha()
        }
      }
    }
  }

  <Layout>
    <Next.Head> <title> {"Contact - Life Stewardship"->React.string} </title> </Next.Head>
    <h1 className={Heading.Styles.primary ++ " mb-5 lg:mb-10"}> {"Contact"->React.string} </h1>
    <Paragraph>
      {`If you’d like to receive more information or ask a question about my services, please fill out the form below.`->React.string}
    </Paragraph>
    {switch reCaptchaLoadAttempts {
    | 0 => React.null
    | 1 | 2 =>
      <Paragraph>
        {"Loading the contact form failed. "->React.string}
        <button type_="button" onClick={loadReCaptcha}>
          {"Please try again."->React.string}
        </button>
      </Paragraph>
    | _ =>
      <Paragraph>
        {"Multiple attempts to load the contact form failed. We recommend
          emailing us directly at"->React.string}
        <a href={mailTo}> {email->React.string} </a>
        {"."->React.string}
      </Paragraph>
    }}
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
        <TextButton href={mailTo}> {email->React.string} </TextButton>
      </ContactInfo>
    </address>
  </Layout>
}
