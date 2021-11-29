const mongoose = require("mongoose");

const TeamSchema = new mongoose.Schema(
  {
    name: String,
  },
  { timestamps: true, versionKey: false }
);

module.exports = mongoose.model("team", TeamSchema);
