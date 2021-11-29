const { insert } = require("../services/Teams");
const httpStatus = require("http-status");
const index = (req, res) => {
  res.status(200).send("Team");
};
const create = (req, res) => {
  insert(req.body);
  res.status(httpStatus.CREATED).send("Team create");
};
module.exports = {
  index,
  create,
};
