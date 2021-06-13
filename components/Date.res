let months = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December",
]

let stripZero = day => Js.String.replaceByRe(%re("/0(\d+)/g"), "$1", day)

let format = dateString => {
  let regexSansTime = switch Js.Re.exec_(%re("/(\d{4}-\d{2}-\d{2}).*/g"), dateString) {
  | Some(result) => result->Js.Re.captures
  | None => []
  }

  let dateStringSansTime = switch regexSansTime[1]->Js.Nullable.toOption {
  | Some(string) => string
  | None => ""
  }

  switch Js.String.splitByRe(%re("/-/g"), dateStringSansTime) {
  | [Some(year), Some(month), Some(day)] =>
    months[int_of_string(month) - 1] ++ " " ++ day->stripZero ++ ", " ++ year
  | _ => ""
  }
}

@react.component
let make = (~dateString, ~ariaHidden=?) => {
  <time dateTime=dateString ?ariaHidden> {dateString->format->React.string} </time>
}
