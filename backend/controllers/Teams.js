const Teams = require("../services/Teams");
const Users = require("../services/Users");

const httpStatus = require("http-status");
const ApiError = require("../errors/ApiError");
const getOne = async (req, res, next) => {
  try {
    const team = await Teams.getOne({ name: req.body.name });
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

const getTeam = async (req, res, next) => {
  try {
    const team = await Teams.get(req.params?.id);
    if (!team) throw new ApiError("no team", httpStatus.NOT_FOUND);
    res.status(httpStatus.OK).send(team);
  } catch (error) {
    next(error);
  }
};

const create = async (req, res, next) => {
  try {
    if (req.user.teamId)
      throw new ApiError("you have already team", httpStatus.BAD_REQUEST);
    req.body.founder = req.user;
    const user = await Users.get(req.user?._id);

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
const join = async (req, res, next) => {
  try {
    const team = await Teams.get(req.body?.teamId);
    if (!team) throw new ApiError("Team does not exist", httpStatus.NOT_FOUND);
    const user = await Users.get(req.user?._id);
    if (user.teamId)
      throw new ApiError(
        "You have already joined a team",
        httpStatus.BAD_REQUEST
      );

    team.userRequests.push(user);
    await team.save();
    console.log(user);

    res.status(httpStatus.OK).send(team);
  } catch (error) {
    next(error);
  }
};

const getUsersApplications = async (req, res, next) => {
  try {
    const user = await Users.get(req.user?._id);
    if (!user) throw new ApiError("no user", httpStatus.NOT_FOUND);
    const team = await Teams.get(user.teamId);
    if (!team) throw new ApiError("no team", httpStatus.NOT_FOUND);
    if ((req.user?._id).toString() !== team.founder._id.toString())
      throw new ApiError(
        "you have no acces to do this action.",
        httpStatus.UNAUTHORIZED
      );

    if (team.userRequests == [].toString())
      res.status(httpStatus.OK).send("there is no request from any user");
    else res.status(httpStatus.OK).send(team.userRequests);
  } catch (error) {
    next(error);
  }
};
const acceptUserToTeam = async (req, res, next) => {
  try {
    const founder = await Users.get(req.user?._id);
    if (!founder) throw new ApiError("no user", httpStatus.NOT_FOUND);
    const team = await Teams.get(founder.teamId);
    if (!team) throw new ApiError("no team", httpStatus.NOT_FOUND);
    if ((req.user?._id).toString() !== team.founder._id.toString())
      throw new ApiError(
        "you have no acces to do this action.",
        httpStatus.UNAUTHORIZED
      );

    const user = await Users.get(req.body.userId);
    if (!user) throw new ApiError("no user", httpStatus.NOT_FOUND);

    if (user.teamId)
      throw new ApiError("already joined a team", httpStatus.BAD_REQUEST);

    const acceptedUser = await Users.update(user._id, { teamId: team });

    await team.playersId.push(acceptedUser);
    console.log(`team.userRequests`, team.userRequests);
    team.userRequests = await team.userRequests.filter(
      (obj) => obj._id.toString() != acceptedUser._id.toString()
    );
    await team.save();
    res.status(httpStatus.OK).send(team);
  } catch (error) {
    next(error);
  }
};
const rejectRequestFromUser = async (req, res, next) => {
  try {
    const founder = await Users.get(req.user?._id);
    if (!founder) throw new ApiError("no user", httpStatus.NOT_FOUND);
    const team = await Teams.get(founder.teamId);
    if (!team) throw new ApiError("no team", httpStatus.NOT_FOUND);
    if ((req.user?._id).toString() !== team.founder._id.toString())
      throw new ApiError(
        "you have no acces to do this action.",
        httpStatus.UNAUTHORIZED
      );

    const user = await Users.get(req.body.userId);
    if (!user) throw new ApiError("no user", httpStatus.NOT_FOUND);

    team.userRequests = await team.userRequests.filter(
      (obj) => obj._id.toString() != acceptedUser._id.toString()
    );
    await team.save();
    res.status(httpStatus.OK).send(team);
  } catch (error) {
    next(error);
  }
};
const invitePlayer = async (req, res, next) => {
  try {
    const user = await Users.get(req.user?._id);
    if (!user) throw new ApiError("no user", httpStatus.NOT_FOUND);
    const team = await Teams.get(user.teamId);
    if (!team) throw new ApiError("Team does not exist", httpStatus.NOT_FOUND);

    if ((req.user?._id).toString() !== team.founder._id.toString())
      throw new ApiError(
        "you have no acces to do this action.",
        httpStatus.UNAUTHORIZED
      );

    const invitedUser = await Users.get(req.body?.userId);
    if (!invitedUser) throw new ApiError("no user", httpStatus.NOT_FOUND);

    invitedUser.teamRequests.push(team);
    await invitedUser.save();

    res.status(httpStatus.OK).send(invitedUser);
  } catch (error) {
    next(error);
  }
};

module.exports = {
  getOne,
  getAll,
  getTeam,
  create,
  update,
  remove,
  join,
  getUsersApplications,
  acceptUserToTeam,
  rejectRequestFromUser,
  invitePlayer,
};
