export default (req, res) => {
  let data = JSON.parse(req.body);
  console.log(">", data);
  res.status(200).end();
};
