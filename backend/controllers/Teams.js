const Teams = require("../services/Teams");
const Users = require("../services/Users");

const httpStatus = require("http-status");
const ApiError = require("../errors/ApiError");
const getOne = async (req, res, next) => {
  try {
    const team = await Teams.getOneTeamPopulate(req.body.name);
    if (!team) throw new ApiError("no team", httpStatus.NOT_FOUND);
    res.status(httpStatus.OK).send(team);
  } catch (error) {
    next(error);
  }
};

const getAll = async (req, res, next) => {
  try {
    const teams = await Teams.load();
    if (!teams) throw new ApiError("no teams", httpStatus.NOT_FOUND);
    res.status(httpStatus.OK).send(teams);
  } catch (error) {
    next(error);
  }
};
const create = async (req, res, next) => {
  try {
    if (req.user.teamId)
      throw new ApiError("you have already team", httpStatus.BAD_REQUEST);
    req.body.founder = req.user;
    const user = await Users.getUserPopulate(req.user?._id);

    if (!user) throw new ApiError("no user", httpStatus.NOT_FOUND);
    const team = await Teams.insert(req.body);
    if (!team) throw new ApiError("no team", httpStatus.NOT_FOUND);
    team.playersId.push(user);
    await team.save();
    await Users.update(req.user._id, { teamId: team });

    res.status(httpStatus.CREATED).send(team);
  } catch (error) {
    next(error);
  }
};

const update = async (req, res) => {
  try {
    const updatedTeam = await Teams.update(req.params?.id, req.body);
    if (!updatedTeam) throw new ApiError("no team", httpStatus.NOT_FOUND);

    res.status(httpStatus.OK).send(updatedTeam);
  } catch (error) {
    next(error);
  }
};

const remove = async (req, res, next) => {
  try {
    const user = await Users.get(req.user?._id);

    if (!user) throw new ApiError("no user", httpStatus.NOT_FOUND);
    const team = await Teams.get(req.params.id);
    if (!team) throw new ApiError("no team", httpStatus.BAD_REQUEST);
    if (user._id.toString() != team.founder.toString())
      throw new ApiError(
        "you have no acces to do this action.",
        httpStatus.UNAUTHORIZED
      );

    await Users.updateAll(
      { teamId: team._id },
      { $unset: { teamId: 1 } } //to make the selected field undefined
    );

    const deletedTeam = await Teams.remove(team._id);
    res.status(httpStatus.OK).send(deletedTeam);
  } catch (error) {
    next(error);
  }
};

<<<<<<< HEAD
=======
const getMatches = async (req, res, next) => {
  console.log(req.body.teamId);
  const team = await Teams.get(req.body.teamId);
  console.log(team._id);
  const match = await Matches.getCon({ teamsId: team._id });
  console.log(match);
  res.status(httpStatus.OK).send(match);
};

>>>>>>> e9fd054ee4d5b92c106d0b03d44b2ed45e92e21c
const join = async (req, res, next) => {
  try {
    const team = await Teams.get(req.body?.teamId);
    if (!team) throw new ApiError("Team does not exist", httpStatus.NOT_FOUND);
    const user = await Users.get(req.user?._id);
    console.log(user);
    if (user.teamId)
      throw new ApiError(
        "You have already joined a team",
        httpStatus.BAD_REQUEST
      );
    const joinedUser = await Users.update(user._id, { teamId: team });
    team.playersId.push(joinedUser);
    await team.save();

    res.status(httpStatus.OK).send(team);
  } catch (error) {
    next(error);
  }
};

module.exports = {
  getOne,
  getAll,
  create,
  update,
  remove,
  join,
};
