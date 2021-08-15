type context = Error | Success

@react.component
let make = (~children, ~className, ~context, ~onDismiss=?) => {
  let (visible, setVisible) = React.useState(_ => true)

  // Hide toast after 10 seconds
  React.useEffect0(() => {
    let toastTO = Js.Global.setTimeout(() => {setVisible(_ => false)}, 10000)
    Some(() => Js.Global.clearTimeout(toastTO))
  })

  let dismiss = event => {
    setVisible(_ => false)
    switch onDismiss {
    | Some(callback) => callback(event)
    | None => ()
    }
  }

  {
    visible
      ? <div
          className={className ++
          switch context {
          | Success => " bg-green-600"
          | Error => " bg-red-500"
          } ++ " flex items-center text-white shadow-xl rounded"}>
          <button className="p-3 text-white" onClick=dismiss>
            <svg
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
              height="24">
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth="2"
                d="M6 18L18 6M6 6l12 12"
              />
            </svg>
          </button>
          children
        </div>
      : React.null
  }
}
