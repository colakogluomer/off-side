const User = require("../models/Users");

const insert = (data) => {
  const user = new User(data);
  return user.save();
};
const loginUser = (data) => {
  return User.findOne(data);
};
module.exports = {
  insert,
  loginUser,
};
