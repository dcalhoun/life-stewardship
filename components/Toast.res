type context = Error | Success

@react.component
let make = (~children, ~className, ~context, ~onDismiss) =>
  <div
    className={className ++
    switch context {
    | Success => " bg-green-600"
    | Error => " bg-red-500"
    } ++ " flex items-center text-white shadow-xl rounded"}>
    <button className="p-3 text-white" onClick=onDismiss>
      <svg
        xmlns="http://www.w3.org/2000/svg"
        fill="none"
        viewBox="0 0 24 24"
        stroke="currentColor"
        height="24">
        <path
          strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M6 18L18 6M6 6l12 12"
        />
      </svg>
    </button>
    children
  </div>
