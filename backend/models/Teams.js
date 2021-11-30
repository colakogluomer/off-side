const mongoose = require("mongoose");
const logger = require("../scripts/logger/Teams");
const TeamSchema = new mongoose.Schema(
  {
    name: String,
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
