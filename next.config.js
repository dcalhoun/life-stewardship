const bsconfig = require("./bsconfig.json");

const withTM = require("next-transpile-modules")(
  ["bs-platform"].concat(bsconfig["bs-dependencies"])
);

module.exports = withTM({
  pageExtensions: ["jsx", "js", "ts", "tsx", "bs.js"],
});
