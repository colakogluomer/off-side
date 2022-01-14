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
<<<<<<< HEAD
      path: "matches founder playersId",
      select: "adress name name",
=======
      path: "founder matches playersId",
      select: "name adress name",
>>>>>>> e9fd054ee4d5b92c106d0b03d44b2ed45e92e21c
    });
  }
}

module.exports = new Teams(Team);
