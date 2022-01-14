const Matches = require("../services/Matches");
const httpStatus = require("http-status");
const Teams = require("../services/Teams");
const ApiError = require("../errors/ApiError");

const create = async (req, res) => {
  const teams = req.body;
  const response = await Matches.insert(teams);
  const team1 = response.teamsId[0];
  const team2 = response.teamsId[1];
  const findTeam1 = await Teams.get(team1);
  const findTeam2 = await Teams.get(team2);

  findTeam1.matches.push(response);
  findTeam2.matches.push(response);
  await findTeam1.save();
  await findTeam2.save();
  res.status(httpStatus.CREATED).send(findTeam1);
};

const getAll = async (req, res) => {
  const matches = await Matches.load();
  res.status(httpStatus.OK).send(matches);
};

const getMatches = async (req, res, next) => {
  const team = await Teams.get(req.body.teamId);
  const match = await Matches.getCon({ teamsId: team._id });
  res.status(httpStatus.OK).send(match);
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

module.exports = {
  create,
  getAll,
  remove,
  getMatches,
};
