const mongoose = require("mongoose");
const MatchSchema = new mongoose.Schema(
  {
    teamsId: [
      {
        type: mongoose.Types.ObjectId,
        ref: "team",
        autopopulate: { maxDepth: 2 },
      },
    ],
    adress: String,
    date: Date,
  },
  { timestamps: true, versionKey: false }
);

MatchSchema.plugin(require("mongoose-autopopulate"));

module.exports = mongoose.model("match", MatchSchema);
