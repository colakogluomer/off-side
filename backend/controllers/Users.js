const { insert, loginUser, getUserById } = require("../services/Users");
const teamService = require("../services/Teams");
const httpStatus = require("http-status");

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
  console.log(user.teamId);
  const team = await teamService.findTeamById(user.teamId);
  res.status(httpStatus.OK).send(team);
};

module.exports = {
  index,
  create,
  login,
  getPlayerTeam,
};
