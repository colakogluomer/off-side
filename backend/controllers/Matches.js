const Matches = require("../services/Matches");
const Users = require("../services/Users");
const httpStatus = require("http-status");
const Teams = require("../services/Teams");
const ApiError = require("../errors/ApiError");

const getAll = async (req, res, next) => {
  try {
    const matches = await Matches.load();
    if (!matches) throw new ApiError("no matches", httpStatus.NOT_FOUND);
    res.status(httpStatus.OK).send(matches);
  } catch (error) {
    next(error);
  }
};

const getMatches = async (req, res, next) => {
  try {
    const team = await Teams.get(req.params?.id);
    if (!team) throw new ApiError("no team", httpStatus.NOT_FOUND);

    const matches = await Matches.getCon({ teamsId: team._id });
    if (!matches) throw new ApiError("no matches", httpStatus.NOT_FOUND);

    res.status(httpStatus.OK).send(matches);
  } catch (error) {
    next(error);
  }
};

const remove = async (req, res, next) => {
  try {
    const team = await Teams.get(req.body.teamId[0]);
    const team2 = await Teams.get(req.body.teamId[1]);

    console.log(team);
    console.log(team2);
    if (!team && !team2) throw new ApiError("no team", httpStatus.NOT_FOUND);

    const deletedMatch = await Matches.remove(req.params?.id);
    console.log(deletedMatch);
    if (!deletedMatch) throw new ApiError("no match", httpStatus.NOT_FOUND);
    team.matches = team.matches.filter(
      (id) => id.toString() != deletedMatch._id
    );
    if (!deletedMatch) throw new ApiError("no match", httpStatus.NOT_FOUND);
    team2.matches = team2.matches.filter(
      (id) => id.toString() != deletedMatch._id
    );
    await team.save();
    await team2.save();
    res.status(httpStatus.OK).send(deletedMatch);
  } catch (error) {
    next(error);
  }
};
const sendMatchInvitation = async (req, res, next) => {
  try {
    const opposingTeam = await Teams.get(req.body?.teamId);
    if (!opposingTeam)
      throw new ApiError("Team does not exist", httpStatus.NOT_FOUND);

    const user = await Users.get(req.user?._id);
    if (!user) throw new ApiError("no user", httpStatus.NOT_FOUND);
    const ownTeam = await Teams.get(user.teamId);
    if (!ownTeam)
      throw new ApiError("Team does not exist", httpStatus.NOT_FOUND);
    if ((req.user?._id).toString() !== ownTeam.founder._id.toString())
      throw new ApiError(
        "you have no acces to do this action.",
        httpStatus.UNAUTHORIZED
      );

    await opposingTeam.matchRequests.push(ownTeam);
    await opposingTeam.save();

    res.status(httpStatus.OK).send(opposingTeam);
  } catch (error) {
    next(error);
  }
};
const acceptMatchInvitation = async (req, res, next) => {
  try {
    const user = await Users.get(req.user?._id);
    if (!user) throw new ApiError("no user", httpStatus.NOT_FOUND);

    const ownTeam = await Teams.get(req.user?.teamId);
    if (!ownTeam) throw new ApiError("no team", httpStatus.NOT_FOUND);

    if ((req.user?._id).toString() !== ownTeam.founder._id.toString())
      throw new ApiError(
        "you have no acces to do this action.",
        httpStatus.UNAUTHORIZED
      );

    const opposingTeam = await Teams.get(req.body?.teamId);
    if (!opposingTeam)
      throw new ApiError("no opposing team", httpStatus.NOT_FOUND);

    const match = {
      teamsId: [ownTeam, opposingTeam],
      adress: req.body.adress,
      date: req.body.date,
    };
    const insertedMatch = await Matches.insert(match);
    await ownTeam.matches.push(insertedMatch);
    await ownTeam.save();
    await opposingTeam.matches.push(insertedMatch);
    await opposingTeam.save();

    ownTeam.matchRequests = await ownTeam.matchRequests.filter(
      (obj) => obj._id.toString() != opposingTeam._id.toString()
    );
    await ownTeam.save();

    res.status(httpStatus.OK).send(ownTeam);
  } catch (error) {
    next(error);
  }
};
const rejectMatchInvitation = async (req, res, next) => {
  try {
    const user = await Users.get(req.user?._id);
    if (!user) throw new ApiError("no user", httpStatus.NOT_FOUND);

    const ownTeam = await Teams.get(user.teamId);
    if (!ownTeam) throw new ApiError("no team", httpStatus.NOT_FOUND);

    if ((req.user?._id).toString() !== ownTeam.founder._id.toString())
      throw new ApiError(
        "you have no acces to do this action.",
        httpStatus.UNAUTHORIZED
      );

    const opposingTeam = await Users.get(req.body.teamId);
    if (!opposingTeam)
      throw new ApiError("no opposing team", httpStatus.NOT_FOUND);

    ownTeam.matchRequests = await ownTeam.matchRequests.filter(
      (obj) => obj._id.toString() != opposingTeam._id.toString()
    );
    await ownTeam.save();

    res.status(httpStatus.OK).send(ownTeam);
  } catch (error) {
    next(error);
  }
};
const getMatchRequests = async (req, res, next) => {
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

    if (team.matchRequests == [].toString())
      res.status(httpStatus.OK).send("there is no request from any team");
    else res.status(httpStatus.OK).send(team.matchRequests);
  } catch (error) {
    next(error);
  }
};
module.exports = {
  getAll,
  remove,
  getMatches,
  sendMatchInvitation,
  acceptMatchInvitation,
  rejectMatchInvitation,
  getMatchRequests,
};
