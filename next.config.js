const bsconfig = require("./bsconfig.json");

const withTM = require("next-transpile-modules")(
  ["rescript"].concat(bsconfig["bs-dependencies"])
);

module.exports = withTM({
  pageExtensions: ["js", "bs.js"],
  images: {
    domains: ["lifestewardshipllc.files.wordpress.com", "i0.wp.com"],
  },
});
