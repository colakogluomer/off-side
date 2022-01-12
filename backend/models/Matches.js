const mongoose = require("mongoose");
const MatchSchema = new mongoose.Schema(
  {
    teamsId: [
      {
        type: mongoose.Types.ObjectId,
        ref: "team",
      },
    ],
    adress: String,
    date: Date,
  },
  { timestamps: true, versionKey: false }
);
module.exports = mongoose.model("match", MatchSchema);
