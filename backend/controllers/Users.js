const {
  insert,
  loginUser,
  getUserById,
  modifyOne,
  modify,
} = require("../services/Users");
const teamService = require("../services/Teams");
const httpStatus = require("http-status");
const uuid = require("uuid");
const eventEmitter = require("../scripts/events/eventEmitter");
const {
  passwordToHash,
  generateAccessToken,
  generateRefreshToken,
} = require("../scripts/utils/helper");

const index = (req, res) => {
  res.status(200).send("User");
};
const create = async (req, res) => {
  req.body.password = passwordToHash(req.body.password);
  const response = await insert(req.body);
  res.status(httpStatus.CREATED).send(response);
};
const login = async (req, res) => {
  try {
    req.body.password = passwordToHash(req.body.password);
    const user = await loginUser(req.body);
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
  const user = await getUserById(req.user?._id);
  const team = await teamService.findTeamById(user.teamId);
  res.status(httpStatus.OK).send(team);
};

const resetPassword = async (req, res) => {
  const newPassword = uuid.v4()?.split("-")[0] || `usr-${new Date().getTime()}`;
  const updatedUser = await modifyOne(
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
  const updatedUser = await modify(req.body, req.user?._id);
  res.status(httpStatus.OK).send(updatedUser);
};

module.exports = {
  index,
  create,
  login,
  getPlayerTeam,
  resetPassword,
  update,
};
