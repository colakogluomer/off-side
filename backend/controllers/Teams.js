const { insert, findAll } = require("../services/Teams");
const httpStatus = require("http-status");
const getAll = async (req, res) => {
  const teams = await findAll();
  res.status(httpStatus.CREATED).send(teams);
};
const create = async (req, res) => {
  const team = await insert(req.body);
  res.status(httpStatus.CREATED).send(team);
};
module.exports = {
  getAll,
  create,
};
