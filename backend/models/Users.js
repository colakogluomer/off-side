const mongoose = require("mongoose");
const UserSchema = new mongoose.Schema(
  {
    name: String,
    password: String,
    email: String,
    profileImage: String,
  },
  { timestamps: true, versionKey: false }
);
module.exports = mongoose.model("user", UserSchema);
