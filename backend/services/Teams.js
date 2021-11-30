const Team = require("../models/Teams");

const insert = (data) => {
  const team = new Team(data);
  return team.save();
};
const findAll = () => {
  const teams = Team.find({});
  return teams;
};
module.exports = {
  insert,
  findAll,
};
