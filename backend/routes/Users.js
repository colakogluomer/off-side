const validate = require("../middlewares/validate");
const schemas = require("../validations/Users");
const express = require("express");
const authenticate = require("../middlewares/authenticate");

const router = express.Router();
const {
  index,
  create,
  login,
  getPlayerTeam,
  resetPassword,
  update,
} = require("../controllers/Users");

router.get("/", index);
router.route("/").post(validate(schemas.createValidation), create);
router
  .route("/")
  .patch(authenticate, validate(schemas.updateValidation), update);
router.route("/login").post(validate(schemas.loginValidation), login);
router.route("/team").get(authenticate, getPlayerTeam);
router
  .route("/reset-password")
  .post(validate(schemas.resetPassword), resetPassword);

module.exports = router;
