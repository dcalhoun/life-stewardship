module.exports = {
  purge: ["./pages/**/*.{ts,tsx,js,re}", "./components/**/*.{ts,tsx,js,re}"],
  variants: {
    accessibility: ({ after }) => after(["focus-within"]),
  },
};
