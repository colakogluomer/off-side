const validate = require("../middlewares/validate");
const schemas = require("../validations/Teams");
const express = require("express");
const router = express.Router();
const authenticate = require("../middlewares/authenticate");
const {
  getAll,
  create,
  update,
  getOne,
  getTeam,
  remove,
  join,
  getUsersApplications,
  acceptUserToTeam,
  rejectRequestFromUser,
  invitePlayer,
} = require("../controllers/Teams");

router.route("/").get(authenticate, getAll);
router.route("/search").get(authenticate, getOne);
router.route("/:id").get(authenticate, getTeam);
router
  .route("/")
  .post(authenticate, validate(schemas.createValidation), create);
router
  .route("/:id")
  .patch(authenticate, validate(schemas.updateValidation), update);

router.route("/:id").delete(authenticate, remove);
router.route("/join").post(authenticate, join);
router.route("/invite-player").post(authenticate, invitePlayer);
router.route("/check-applications").get(authenticate, getUsersApplications);
router.route("/accept-player").post(authenticate, acceptUserToTeam);
router.route("/reject-player").delete(authenticate, rejectRequestFromUser);

module.exports = router;
