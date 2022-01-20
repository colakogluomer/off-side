const mongoose = require("mongoose");
const logger = require("../scripts/logger/Teams");
const TeamSchema = new mongoose.Schema(
  {
    name: String,
    playersId: [
      {
        type: mongoose.Types.ObjectId,
        ref: "user",
        autopopulate: false,
      },
    ],
    founder: {
      type: mongoose.Types.ObjectId,
      ref: "user",
      autopopulate: false,
    },
    matches: [
      {
        type: mongoose.Types.ObjectId,
        ref: "match",
        autopopulate: false,
      },
    ],
    userRequests: [
      {
        type: mongoose.Types.ObjectId,
        ref: "user",
        autopopulate: false,
      },
    ],
    matchRequests: [
      {
        type: mongoose.Types.ObjectId,
        ref: "team",
        autopopulate: false,
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

TeamSchema.plugin(require("mongoose-autopopulate"));

module.exports = mongoose.model("team", TeamSchema);
