const BaseService = require("./BaseService");
const Team = require("../models/Teams");
const mongoose = require("mongoose");
const ApiError = require("../errors/ApiError");
const httpStatus = require("http-status");
class Teams extends BaseService {}

module.exports = new Teams(Team);
