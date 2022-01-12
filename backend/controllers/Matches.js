const Matches = require("../services/Matches");
const httpStatus = require("http-status");
const Teams = require("../services/Teams");

const create = async (req, res) => {
  const teams = req.body;
  const response = await Matches.insert(teams);
  const team1 = response.teamsId[0];
  const team2 = response.teamsId[1];
  const findTeam1 = await Teams.get(team1);
  console.log(findTeam1);
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

module.exports = { create, getAll };
