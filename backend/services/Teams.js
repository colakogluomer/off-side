const BaseService = require("./BaseService");
const Team = require("../models/Teams");
const mongoose = require("mongoose");
class Teams extends BaseService {
  async getOneTeamPopulate(condition) {
    const team = await this.getOne({ name: condition });
    return this.model.populate(team, {
      path: "founder",
      select: "name",
    });
  }
}

module.exports = new Teams(Team);
