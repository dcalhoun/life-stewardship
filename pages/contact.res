let email = "Paul@LifeStewardshipLLC.com"
let mailTo = "mailto:Paul%20Calhoun<" ++ email ++ "?subject=Life%20Stewardship%20LLC%20Inquiry"

@bs.val
external reCaptchaSiteKey: option<string> = "process.env.NEXT_PUBLIC_RECAPTCHA_SITE_KEY"

@bs.val
external formspreeEndpoint: option<string> = "process.env.NEXT_PUBLIC_FORMSPREE_ENDPOINT"

@bs.new external createFormData: 'form => 'formData = "FormData"

@decco type formError = {error: string}

type fetchError = {message: string}

external toJsError: Js.Promise.error => fetchError = "%identity"

@react.component
let default = () => {
  let (toast, setToast) = React.useState(_ => "")
  let (errors, setErrors) = React.useState(_ => [])
  let (sending, setSending) = React.useState(_ => false)
  let formErrors = Belt.Array.keep(errors, ({TextInput.subject: subject}) => subject === "form")

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
    switch form->Js.Nullable.toOption {
    | None => ()
    | Some(form) =>
      setSending(_ => true)
      let _ =
        Fetch.fetchWithInit(
          form["action"],
          Fetch.RequestInit.make(
            ~method_=Post,
            ~body=form->createFormData->Fetch.BodyInit.makeWithFormData,
            ~headers=Fetch.HeadersInit.make({"Accept": "application/json"}),
            (),
          ),
        )
        ->Js.Promise.then_(response => {
          let _ = response->Fetch.Response.json->Js.Promise.then_(json => {
            setSending(_ => false)
            if response->Fetch.Response.ok {
              setToast(_ => "Your message was sent successfully.")
            } else {
              let {error} =
                json
                ->formError_decode
                ->Belt.Result.getWithDefault({error: "Network request failed."})
              setErrors(_ => [{TextInput.subject: "form", message: error}])
            }
            ()->Js.Promise.resolve
          }, _)
          ()->Js.Promise.resolve
        }, _)
        ->Js.Promise.catch(error => {
          setSending(_ => false)
          let {message} = error->toJsError
          setErrors(_ => [{TextInput.subject: "form", message: message}])
          ()->Js.Promise.resolve
        }, _)
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
    switch (form->Js.Nullable.toOption, sending) {
    | (None, _) | (_, true) => ()
    | (Some(form), false) => {
        let errors =
          form["elements"]
          ->Js.Array.from
          ->Belt.Array.keep(el => !el["checkValidity"]())
          ->Belt.Array.map(el => {
            {TextInput.subject: el["name"], message: el["dataset"]["errorMessage"]}
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
    <SEO
      title="Contact"
      description="Contact Paul Calhoun, managing partner and founder of Life Stewardship LLC."
    />
    <h1 className={Heading.Styles.primary ++ " mb-5"}> {"Contact"->React.string} </h1>
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
      action={formspreeEndpoint->Belt.Option.getUnsafe}
      method="POST"
      noValidate=true
      onSubmit={handleFormSubmit}>
      <TextInput
        className="mb-5 lg:mb-10"
        errorMessage="Name is required."
        errors={errors}
        id="name"
        label="Name (required)"
        name="name"
        placeholder="Jane Doe"
        readOnly=sending
        required=true
        type_="text"
      />
      <TextInput
        className="mb-5 lg:mb-10"
        errorMessage="Valid email is required."
        errors={errors}
        id="_replyto"
        label="Email (required)"
        name="_replyto"
        placeholder="jane.doe@example.com"
        readOnly=sending
        required=true
        type_="email"
      />
      <TextInput id="subject" name="_subject" type_="hidden" value="Life Stewardship LLC Inquiry" />
      <TextInput
        className="mb-5 lg:mb-10"
        errors={errors}
        id="phone"
        label="Phone"
        name="phone"
        placeholder="555-555-5555"
        readOnly=sending
        type_="tel"
      />
      <TextInput
        className="mb-5 lg:mb-10"
        cols={30}
        errorMessage="Message is required."
        errors={errors}
        id="message"
        label="Message (required)"
        multiline=true
        name="message"
        placeholder="Tell me more about your project, needs, or timeline."
        readOnly=sending
        required=true
        rows={10}
      />
      <Button className="block mx-auto mb-5 lg:mb-10" loading=sending type_="submit">
        {"Send Message"->React.string}
      </Button>
      <div id="js-reCaptcha" className="g-recaptcha" />
    </form>
    {formErrors->Belt.Array.length > 0
      ? <Toast
          className="fixed top-10 left-2/4 w-11/12 lg:w-2/4 transform -translate-x-1/2"
          context=Toast.Error
          onDismiss={_ => setErrors(_ => [])}>
          {Belt.Array.mapWithIndex(formErrors, (index, {TextInput.message: message}) =>
            <span key={index->Belt.Int.toString}> {message->React.string} <br /> </span>
          )->React.array}
        </Toast>
      : React.null}
    {toast->Js.String.length > 0
      ? <Toast
          className="fixed top-10 left-2/4 w-11/12 lg:w-2/4 transform -translate-x-1/2"
          context=Toast.Success
          onDismiss={_ => {
            setToast(_ => "")
          }}>
          {toast->React.string}
        </Toast>
      : React.null}
    <hr className="mb-5 border-gray-200" />
    <address className="pb-16 md:pb-0 md:flex justify-evenly">
      <ContactInfo icon=ContactInfo.Mail>
        {"1888 Main Street"->React.string}
        <br />
        {"Suite C-198"->React.string}
        <br />
        {"Madison, MS 39110"->React.string}
      </ContactInfo>
      <ContactInfo icon=ContactInfo.Phone> {"601-624-5135"->React.string} </ContactInfo>
      <ContactInfo icon=ContactInfo.Email>
        <TextButton href={mailTo}> {email->React.string} </TextButton>
      </ContactInfo>
    </address>
  </Layout>
}
