const Team = require("../models/Teams");

const insert = (teamData) => {
  const team = new Team({
    name: teamData.name,
  });
  return team.save();
};
module.exports = {
  insert,
};
