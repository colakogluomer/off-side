const BaseService = require("./BaseService");
const User = require("../models/Users");
const ApiError = require("../errors/ApiError");
const httpStatus = require("http-status");
class Users extends BaseService {}

module.exports = new Users(User);
