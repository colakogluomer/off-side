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
const ApiError = require("../errors/ApiError");

const getAll = async (req, res, next) => {
  try {
    const users = await Users.load();
    if (!users) throw new ApiError("no users", httpStatus.NOT_FOUND);
    res.status(httpStatus.CREATED).send(users);
  } catch (error) {
    next(error);
  }
};
const create = async (req, res, next) => {
  try {
    req.body.password = passwordToHash(req.body.password);
    const checkUser = await Users.getOne({ email: req.body.email });
    if (checkUser !== null)
      throw new ApiError("User already exist", httpStatus.NOT_FOUND);

    const response = await Users.insert(req.body);

    res.status(httpStatus.CREATED).send(response);
  } catch (error) {
    next(error);
  }
};
const login = async (req, res, next) => {
  try {
    req.body.password = passwordToHash(req.body.password);
    const user = await Users.getOne(req.body);
    if (!user)
      throw new ApiError("Wrong email or password", httpStatus.NOT_FOUND);
    currentUser = {
      ...user.toObject(),
      tokens: {
        access_token: generateAccessToken(user),
        refresh_token: generateRefreshToken(user),
      },
    };
    res.status(httpStatus.OK).send(currentUser);
  } catch (error) {
    next(error);
  }
};

const getPlayerTeam = async (req, res, next) => {
  try {
    const user = await Users.get(req.user?._id);
    if (!user) throw new ApiError("No user", httpStatus.NOT_FOUND);
    const team = await Teams.get(user.teamId);
    if (!team) throw new ApiError("No team", httpStatus.NOT_FOUND);
    res.status(httpStatus.OK).send(team);
  } catch (error) {
    next(error);
  }
};
const getUser = async (req, res, next) => {
  try {
    const user = await Users.get(req.params?.id);
    if (!user) throw new ApiError("no user", httpStatus.NOT_FOUND);
    res.status(httpStatus.OK).send(user);
  } catch (error) {
    next(error);
  }
};
const resetPassword = async (req, res, next) => {
  try {
    const newPassword =
      uuid.v4()?.split("-")[0] || `usr-${new Date().getTime()}`;
    const updatedUser = await Users.updateOne(
      { email: req.body.email },
      { password: passwordToHash(newPassword) }
    );
    if (!updatedUser) throw new ApiError("No user", httpStatus.NOT_FOUND);

    eventEmitter.emit("sendEmail", {
      to: updatedUser.email, // list of receivers
      subject: "Reset Password", // Subject line
      html: `Your reset password process is done <br/> New Password: <b> ${newPassword} </b>`, // html body
    });
    res.status(httpStatus.OK).send({
      message: "We have just sent all of details to your email.",
    });
  } catch (error) {
    next(error);
  }
};

const update = async (req, res, next) => {
  try {
    const updatedUser = await Users.update(req.user?._id, req.body);
    if (!updatedUser) throw new ApiError("No user", httpStatus.NOT_FOUND);

    res.status(httpStatus.OK).send(updatedUser);
  } catch (error) {
    next(error);
  }
};

const changePassword = async (req, res, next) => {
  try {
    req.body.password = passwordToHash(req.body.password);
    const updatedUser = await Users.update(req.user?._id, req.body);
    if (!updatedUser) throw new ApiError("No user", httpStatus.NOT_FOUND);

    res.status(httpStatus.OK).send(updatedUser);
  } catch (error) {
    next(error);
  }
};

const remove = async (req, res, next) => {
  try {
    if (!(req.user._id == req.params.id))
      throw new ApiError(
        "you have not access for this action",
        httpStatus.UNAUTHORIZED
      );
    const deletedUser = await Users.remove(req.params?.id);
    if (!deletedUser) throw new ApiError("No user", httpStatus.NOT_FOUND);

    res.status(httpStatus.OK).send(deletedUser);
  } catch (error) {
    next(error);
  }
};

const updateProfileImage = async (req, res, next) => {
  try {
    const extension = path.extname(req.files.profileImage.name);
    const fileName = `${req?.user._id}${extension}`;
    const folder = path.join(__dirname, "../", "uploads/users", fileName);

    req.files.profileImage.mv(folder);

    console.log(req.user._id);
    const updatedUser = await Users.update(req.user._id, {
      profileImage: fileName,
    });
    if (!updatedUser) throw new ApiError("No user", httpStatus.NOT_FOUND);

    res.status(httpStatus.OK).send(updatedUser);
  } catch (error) {
    next(error);
  }
};

const leaveTeam = async (req, res, next) => {
  try {
    const user = await Users.getUserPopulate(req.user?._id);

    if (!user) throw new ApiError("no user", httpStatus.NOT_FOUND);
    if (!user.teamId)
      throw new ApiError("no user's team", httpStatus.NOT_FOUND);
    const team = await Teams.get(user.teamId);
    if (!team) throw new ApiError("no team", httpStatus.NOT_FOUND);
    console.log(team);
    user.teamId = undefined;

    team.playersId = team.playersId.filter((id) => id.toString() != user._id);
    await user.save();
    await team.save();
    res.status(httpStatus.OK).send(team);
  } catch (error) {
    next(error);
  }
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
  getUser,
};
