const User = require("../models/Users");

const insert = (data) => {
  const user = new User(data);
  return user.save();
};
const loginUser = (data) => {
  return User.findOne(data);
};
const getUserById = (id) => {
  return User.findById(id).populate({
    path: "teamId",
    select: "name",
  });
};
const modify = async (data, id) => {
  console.log(data, id);
  return await User.findByIdAndUpdate(id, data, { new: true });
};

const modifyOne = async (condition, data) => {
  return await User.findOneAndUpdate(condition, data, { new: true });
};

module.exports = {
  insert,
  loginUser,
  getUserById,
  modify,
  modifyOne,
};
