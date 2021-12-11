const validate = require("../middlewares/validate");
const schemas = require("../validations/Users");
const express = require("express");
const authenticate = require("../middlewares/authenticate");

const router = express.Router();
const { index, create, login, getPlayerTeam } = require("../controllers/Users");

router.get("/", index);
router.route("/").post(validate(schemas.createValidation), create);
router.route("/login").post(validate(schemas.loginValidation), login);
router.route("/team").get(authenticate, getPlayerTeam);

module.exports = router;
