module.exports = {
  future: {
    removeDeprecatedGapUtilities: true,
    purgeLayersByDefault: true,
  },
  purge: [],
  theme: {},
  variants: {
    accessibility: ({ after }) => after(["focus-within"]),
  },
  plugins: [],
};
