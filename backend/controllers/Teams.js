const { insert, findAll, modify } = require("../services/Teams");
const userService = require("../services/Users");
const httpStatus = require("http-status");
const getAll = async (req, res) => {
  const teams = await findAll();
  res.status(httpStatus.CREATED).send(teams);
};
const create = async (req, res) => {
  req.body.founder = req.user;
  if (!Array.isArray(req.body.playersId)) {
    req.body.playersId = [];
  }
  req.body.playersId.push(req.user);

  const team = await insert(req.body);

  const user = await userService.modify({ teamId: team._id }, req.user._id);

  res.status(httpStatus.CREATED).send(team);
};

const update = async (req, res) => {
  const updatedTeam = await modify(req.body, req.params?.id);
  res.status(httpStatus.OK).send(updatedTeam);
};

module.exports = {
  getAll,
  create,
  update,
};
