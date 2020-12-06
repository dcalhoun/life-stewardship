@react.component
let make = (~children, ~className, ~onDismiss) =>
  <div
    className={className ++ " flex items-center bg-white border border-gray-300 shadow-xl rounded"}>
    <TextButton className="p-3" onClick=onDismiss>
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
    </TextButton>
    children
  </div>
