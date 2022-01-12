const BaseService = require("./BaseService");
const Match = require("../models/Matches");
const mongoose = require("mongoose");
class Matches extends BaseService {}

module.exports = new Matches(Match);
