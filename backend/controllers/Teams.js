const Teams = require("../services/Teams");
const userService = require("../services/Users");
const httpStatus = require("http-status");

const getOne = async (req, res) => {
  const team = await Teams.getOneTeamPopulate(req.body.name);
  res.status(httpStatus.OK).send(team);
};

const getAll = async (req, res) => {
  const teams = await Teams.load();
  res.status(httpStatus.OK).send(teams);
};
const create = async (req, res) => {
  req.body.founder = req.user;
  const user = await userService.getUserById(req.user?._id);
  const team = await insert(req.body);
  team.playersId.push(user);
  await team.save();
  await userService.modify({ teamId: team }, req.user._id);

  res.status(httpStatus.CREATED).send(team);
};

const update = async (req, res) => {
  const updatedTeam = await Teams.update(req.params?.id, req.body);
  res.status(httpStatus.OK).send(updatedTeam);
};

const remove = async (req, res) => {
  const deletedTeam = await Teams.remove(req.params?.id);
  res.status(httpStatus.OK).send(deletedTeam);
};

module.exports = {
  getOne,
  getAll,
  create,
  update,
  remove,
};
