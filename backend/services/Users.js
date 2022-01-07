const User = require("../models/Users");

const insert = (data) => {
  const user = new User(data);
  return user.save();
};

const findAll = () => {
  const users = User.find({}).populate({
    path: "teamId",
    select: "name",
    populate: { path: "playersId", select: "name" },
  });

  return users;
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
  console.log(data);
  return await User.findByIdAndUpdate(id, data, { new: true });
};

const modifyOne = async (condition, data) => {
  return await User.findOneAndUpdate(condition, data, { new: true });
};

const deleteUser = async (id) => {
  return await User.findByIdAndDelete(id);
};

module.exports = {
  insert,
  loginUser,
  getUserById,
  modify,
  modifyOne,
  deleteUser,
  findAll,
};
