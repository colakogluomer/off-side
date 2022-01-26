//const validate = require("../middlewares/validate");
//const schemas = require("../validations/Matchs");
const express = require("express");
const authenticate = require("../middlewares/authenticate");

const router = express.Router();

const {
  getAll,
  remove,
  getMatches,
  sendMatchInvitation,
  acceptMatchInvitation,
  rejectMatchInvitation,
  getMatchRequests,
} = require("../controllers/Matches");

router.route("/").get(authenticate, getAll);
router.route("/:id").delete(authenticate, remove);
router.route("/match/:id").get(authenticate, getMatches);
router.route("/send-match-invitation").post(authenticate, sendMatchInvitation);
router
  .route("/accept-match-invitation")
  .post(authenticate, acceptMatchInvitation);
router
  .route("/reject-match-invitation")
  .post(authenticate, rejectMatchInvitation);
router.route("/get-match-requests").get(authenticate, getMatchRequests);
module.exports = router;
