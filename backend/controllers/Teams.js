const {
  insert,
  findAll,
  modify,
  findTeamByName,
  deleteTeam,
} = require("../services/Teams");
const userService = require("../services/Users");
const httpStatus = require("http-status");

const getOne = async (req, res) => {
  const team = await findTeamByName(req.body.name);
  res.status(httpStatus.OK).send(team);
};

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
  await userService.modify({ teamId: team._id }, req.user._id);

  res.status(httpStatus.CREATED).send(team);
};

const update = async (req, res) => {
  const updatedTeam = await modify(req.body, req.params?.id);
  res.status(httpStatus.OK).send(updatedTeam);
};

const remove = async (req, res) => {
  const deletedTeam = await deleteTeam(req.params?.id);
  res.status(httpStatus.OK).send(deletedTeam);
};

module.exports = {
  getOne,
  getAll,
  create,
  update,
  remove,
};
