const mongoose = require("mongoose");
const logger = require("../scripts/logger/Teams");
const TeamSchema = new mongoose.Schema(
  {
    name: String,
    playersId: [
      {
        type: mongoose.Types.ObjectId,
        ref: "user",
        autopopulate: { maxDepth: 1 },
      },
    ],
    founder: {
      type: mongoose.Types.ObjectId,
      ref: "user",
      autopopulate: { maxDepth: 1 },
    },
    matches: [
      {
        type: mongoose.Types.ObjectId,
        ref: "match",
        autopopulate: { maxDepth: 1 },
      },
    ],
    userRequests: [
      {
        type: mongoose.Types.ObjectId,
        ref: "user",
        autopopulate: { maxDepth: 1 },
      },
    ],
    matchRequests: [
      {
        type: mongoose.Types.ObjectId,
        ref: "match",
        autopopulate: { maxDepth: 1 },
      },
    ],
    matchRequests: [
      {
        type: mongoose.Types.ObjectId,
        ref: "match",
        autopopulate: { maxDepth: 3 },
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
