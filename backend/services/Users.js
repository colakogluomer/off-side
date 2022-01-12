const BaseService = require("./BaseService");
const User = require("../models/Users");
const ApiError = require("../errors/ApiError");
const httpStatus = require("http-status");
class Users extends BaseService {
  async getUserPopulate(id) {
    const user = await this.get(id);
    if (!user) throw new ApiError("no user", httpStatus.NOT_FOUND);
    return this.model.populate(user, {
      path: "teamId",
      select: "name",
      populate: { path: "playersId", select: "name" },
    });
  }
}

module.exports = new Users(User);
