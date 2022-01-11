const BaseService = require("./BaseService");
const User = require("../models/Users");
class Users extends BaseService {
  async getUserPopulate(id) {
    const user = await this.get(id);
    return this.model.populate(user, {
      path: "teamId",
      select: "name",
      populate: { path: "playersId", select: "name" },
    });
  }
}

module.exports = new Users(User);
