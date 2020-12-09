const colors = require("tailwindcss/colors");

module.exports = {
  purge: ["./pages/**/*.{js,res,bs.js}", "./components/**/*.{js,res,bs.js}"],
  theme: {
    colors: {
      transparent: "transparent",
      current: "currentColor",
      black: colors.black,
      white: colors.white,
      gray: colors.warmGray,
      red: colors.red,
      yellow: colors.amber,
      green: colors.emerald,
      blue: colors.blue,
      indigo: colors.indigo,
      purple: colors.violet,
      pink: colors.pink,
    },
  },
  variants: {
    accessibility: ({ after }) => after(["focus-within"]),
  },
};
