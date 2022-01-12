const BaseService = require("./BaseService");
const Team = require("../models/Teams");
const mongoose = require("mongoose");
const ApiError = require("../errors/ApiError");
const httpStatus = require("http-status");
class Teams extends BaseService {
  async getOneTeamPopulate(condition) {
    const team = await this.getOne({ name: condition });
    if (!team) throw new ApiError("no team", httpStatus.NOT_FOUND);
    return this.model.populate(team, {
      path: "founder",
      select: "name",
    });
  }
}

module.exports = new Teams(Team);
