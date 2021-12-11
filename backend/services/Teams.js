const Team = require("../models/Teams");

const insert = async (data) => {
  const team = await new Team(data);
  return team.save();
};
const findAll = () => {
  const teams = Team.find({}).populate({
    path: "founder",
    select: "name",
  });
  return teams;
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
module.exports = {
  insert,
  findAll,
  modify,
  findTeamById,
};
