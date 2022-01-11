const Users = require("../services/Users");
const Teams = require("../services/Teams");
const httpStatus = require("http-status");
const uuid = require("uuid");
const eventEmitter = require("../scripts/events/eventEmitter");
const {
  passwordToHash,
  generateAccessToken,
  generateRefreshToken,
} = require("../scripts/utils/helper");
const path = require("path");

const getAll = async (req, res) => {
  const users = await Users.load();
  res.status(httpStatus.CREATED).send(users);
};
const create = async (req, res) => {
  req.body.password = passwordToHash(req.body.password);
  const response = await Users.insert(req.body);
  res.status(httpStatus.CREATED).send(response);
};
const login = async (req, res) => {
  try {
    req.body.password = passwordToHash(req.body.password);
    const user = await Users.getOne(req.body);
    if (!user) throw Error("wrong email or password");
    currentUser = {
      ...user.toObject(),
      tokens: {
        access_token: generateAccessToken(user),
        refresh_token: generateRefreshToken(user),
      },
    };
    res.status(httpStatus.OK).send(currentUser);
  } catch (error) {
    return res.status(httpStatus.NOT_FOUND).send(error.message);
  }
};

const getPlayerTeam = async (req, res) => {
  const user = await Users.get(req.user?._id);
  const team = await Teams.get(user.teamId);
  res.status(httpStatus.OK).send(team);
};

const resetPassword = async (req, res) => {
  const newPassword = uuid.v4()?.split("-")[0] || `usr-${new Date().getTime()}`;
  const updatedUser = await Users.updateOne(
    { email: req.body.email },
    { password: passwordToHash(newPassword) }
  );
  if (!updatedUser)
    return res.status(httpStatus.NOT_FOUND).send({ error: "no user" });
  eventEmitter.emit("sendEmail", {
    to: updatedUser.email, // list of receivers
    subject: "Reset Password", // Subject line
    html: `Your reset password process is done <br/> New Password: <b> ${newPassword} </b>`, // html body
  });
  res.status(httpStatus.OK).send({
    message: "We have just sent all of details to your email.",
  });
};

const update = async (req, res) => {
  const updatedUser = await Users.update(req.user?._id, req.body);
  res.status(httpStatus.OK).send(updatedUser);
};

const changePassword = async (req, res) => {
  req.body.password = passwordToHash(req.body.password);
  const updatedUser = await Users.update(req.user?._id, req.body);
  res.status(httpStatus.OK).send(updatedUser);
};

const remove = async (req, res) => {
  const deletedUser = await Users.remove(req.params?.id);
  res.status(httpStatus.OK).send(deletedUser);
};

const updateProfileImage = async (req, res) => {
  const extension = path.extname(req.files.profileImage.name);
  const fileName = `${req?.user._id}${extension}`;
  const folder = path.join(__dirname, "../", "uploads/users", fileName);

  req.files.profileImage.mv(folder);

  console.log(req.user._id);
  const updatedUser = await Users.update(req.user._id, {
    profileImage: fileName,
  });
  res.status(httpStatus.OK).send(updatedUser);
};

const leaveTeam = async (req, res) => {
  const user = await Users.getUserPopulate(req.user?._id);

  const team = await Teams.get(user.teamId);
  console.log(team);
  user.teamId = undefined;

  team.playersId = team.playersId.filter((id) => id.toString() != user._id);
  await user.save();
  await team.save();
  res.status(httpStatus.OK).send(team);
};

module.exports = {
  changePassword,
  getAll,
  create,
  login,
  getPlayerTeam,
  resetPassword,
  update,
  remove,
  updateProfileImage,
  leaveTeam,
};
