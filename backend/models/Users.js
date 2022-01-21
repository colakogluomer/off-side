const mongoose = require("mongoose");
const UserSchema = new mongoose.Schema(
  {
    name: String,
    password: String,
    email: String,
    profileImage: String,
    teamId: {
      type: mongoose.Types.ObjectId,
      ref: "team",
      autopopulate: { maxDepth: 1 },
    },
    position: String,
    level: String,
    teamRequests: [
      {
        type: mongoose.Types.ObjectId,
        ref: "team",
        autopopulate: { maxDepth: 1 },
      },
    ],
  },
  { timestamps: true, versionKey: false }
);
UserSchema.plugin(require("mongoose-autopopulate"));

module.exports = mongoose.model("user", UserSchema);
