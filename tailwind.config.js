module.exports = {
  future: {
    removeDeprecatedGapUtilities: true,
    purgeLayersByDefault: true,
  },
  purge: ["./pages/**/*.{ts,tsx,js,re}", "./components/**/*.{ts,tsx,js,re}"],
  theme: {},
  variants: {
    accessibility: ({ after }) => after(["focus-within"]),
  },
  plugins: [],
};
