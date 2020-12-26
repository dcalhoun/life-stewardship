type icon = Email | Mail | Phone

@react.component
let make = (~children) =>
  <div className="flex items-center mb-5">
    <svg
      className="w-6 h-6 text-gray-400 mr-2"
      xmlns="http://www.w3.org/2000/svg"
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor">
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        strokeWidth="2"
        d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"
      />
    </svg>
    <p className="text-base lg:text-xl text-gray-900 font-serif"> children </p>
  </div>
