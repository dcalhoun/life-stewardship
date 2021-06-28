const bsconfig = require("./bsconfig.json");

const withTM = require("next-transpile-modules")(
  ["bs-platform"].concat(bsconfig["bs-dependencies"])
);

module.exports = withTM({
  pageExtensions: ["js", "bs.js"],
  images: {
    domains: ["lifestewardshipllc.files.wordpress.com"],
  },
});
