open Document

type onReCaptchaLoad = unit => unit

@set external setOnReCaptchaLoad: (Dom.window, onReCaptchaLoad) => unit = "onReCaptchaLoad"

@val external onReCaptchaLoad: onReCaptchaLoad = "onReCaptchaLoad"

type renderProps = {
  callback: unit => unit,
  sitekey: string,
  size: string,
}

type grecaptcha = {
  execute: (. unit) => unit,
  render: (. string, renderProps) => Js.Nullable.t<string>,
  reset: string => unit,
}

@val external grecaptcha: grecaptcha = "grecaptcha"

let useReCaptcha = (~key, ~callback) => {
  let reCaptchaId = React.useRef(Js.Nullable.null)
  let (reCaptchaLoadAttempts, setReCaptchaLoadAttempts) = React.useState(_ => 0)

  let loadReCaptcha = _event =>
    switch (Js.Nullable.toOption(reCaptchaId.current), key, Js.typeof(grecaptcha)) {
    | (None, Some(key), "undefined") =>
      setOnReCaptchaLoad(window, () => {
        setReCaptchaLoadAttempts(_ => 0)
        reCaptchaId.current = grecaptcha.render(.
          "js-reCaptcha",
          {
            sitekey: key,
            callback: callback,
            size: "invisible",
          },
        )
      })

      let scriptTag = document->Document.createElement("script")
      scriptTag->Document.setAttribute("async", "")
      scriptTag->Document.addEventListener("error", _ => {
        setReCaptchaLoadAttempts(c => c + 1)
      })
      scriptTag->Document.setAttribute(
        "src",
        "//www.google.com/recaptcha/api.js?onload=onReCaptchaLoad&render=explicit",
      )
      document
      ->Document.getElementsByTagName("body")
      ->Belt.Array.get(0)
      ->Belt.Option.getExn
      ->Document.appendChild(scriptTag)
    | (None, Some(_), "object") => onReCaptchaLoad()
    | _ => ()
    }

  // Load reCAPTCHA on initial render
  React.useEffect0(() => {
    switch Js.typeof(window) {
    | "undefined" => None
    | _ => {
        loadReCaptcha()
        Some(
          () => {
            switch (Js.typeof(grecaptcha), Js.Nullable.toOption(reCaptchaId.current)) {
            | ("object", Some(id)) => grecaptcha.reset(id)
            | (_, _) => ()
            }
          },
        )
      }
    }
  })

  let guardedGrecaptcha = () => {
    if Js.typeof(grecaptcha) != "undefined" {
      grecaptcha.execute(.)
    }
  }

  (guardedGrecaptcha, reCaptchaLoadAttempts, loadReCaptcha)
}
