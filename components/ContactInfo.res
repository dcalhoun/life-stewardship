@react.component
let make = (~children, ~icon) =>
  <div className="flex items-center py-3">
    <svg
      className="w-6 h-6 text-gray-400 mr-2"
      xmlns="http://www.w3.org/2000/svg"
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor">
      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d=icon />
    </svg>
    <p className="text-base lg:text-xl text-gray-900 font-serif"> children </p>
  </div>
