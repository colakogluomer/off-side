const mongoose = require("mongoose");
const logger = require("../scripts/logger/Teams");
const TeamSchema = new mongoose.Schema(
  {
    name: String,
    playersId: [
      {
        type: mongoose.Types.ObjectId,
        ref: "user",
      },
    ],
    founder: {
      type: mongoose.Types.ObjectId,
      ref: "user",
    },
    matches: [
      {
        type: mongoose.Types.ObjectId,
        ref: "match",
      },
    ],
  },
  { timestamps: true, versionKey: false }
);

TeamSchema.post("save", (doc) => {
  console.log("after", doc);
  logger.log({
    level: "info",
    message: doc,
  });
});

module.exports = mongoose.model("team", TeamSchema);
