const Team = require("../models/Teams");

const insert = async (data) => {
  const team = await new Team(data);
  return team.save();
};
const findAll = () => {
  const teams = Team.find({})
    .populate({
      path: "founder",
      select: "name",
    })
    .populate({
      path: "playersId",
      select: "name",
    });
  return teams;
};

const findTeamByName = async (name) => {
  const team = await Team.findOne({ name })
    .populate({
      path: "founder",
      select: "name",
    })
    .populate({
      path: "playersId",
      select: "name",
    });
  return team;
};

const findTeamById = async (id) => {
  const team = await Team.findById(id).populate({
    path: "founder",
    select: "name",
  });
  return team;
};

const modify = async (data, id) => {
  return await Team.findByIdAndUpdate(id, data, { new: true });
};

const deleteTeam = async (id) => {
  return await Team.findByIdAndDelete(id);
};

module.exports = {
  insert,
  findAll,
  modify,
  findTeamById,
  findTeamByName,
  deleteTeam,
};
