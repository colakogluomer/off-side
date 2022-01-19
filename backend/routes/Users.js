const validate = require("../middlewares/validate");
const schemas = require("../validations/Users");
const express = require("express");
const authenticate = require("../middlewares/authenticate");

const router = express.Router();
const {
  getAll,
  create,
  login,
  getPlayerTeam,
  resetPassword,
  changePassword,
  update,
  remove,
  updateProfileImage,
  leaveTeam,
  getUser,
  getTeamsRequests,
  acceptRequestFromTeam,
  rejectRequestFromTeam,
} = require("../controllers/Users");

router.get("/", getAll);
router.route("/").post(validate(schemas.createValidation), create);
router
  .route("/")
  .patch(authenticate, validate(schemas.updateValidation), update);
router.route("/login").post(validate(schemas.loginValidation), login);
router.route("/team").get(authenticate, getPlayerTeam);
router
  .route("/reset-password")
  .post(validate(schemas.resetPassword), resetPassword);
router.route("/reject-team").delete(authenticate, rejectRequestFromTeam);

router.route("/:id").delete(authenticate, remove);
router
  .route("/change-password")
  .post(authenticate, validate(schemas.changePassword), changePassword);

router.route("/check-team-requests").get(authenticate, getTeamsRequests);
router.route("/:id").get(authenticate, getUser);
router.route("/update-profile-image").post(authenticate, updateProfileImage);
router.route("/leave-team").patch(authenticate, leaveTeam);
router.route("/accept-team").post(authenticate, acceptRequestFromTeam);
router.route("/reject-team").delete(authenticate, rejectRequestFromTeam);
module.exports = router;
