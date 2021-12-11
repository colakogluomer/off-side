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
  console.log(data + "HEYYYYYYYY");
  return await User.findByIdAndUpdate(id, data, { new: true });
};
module.exports = {
  insert,
  loginUser,
  getUserById,
  modify,
};
