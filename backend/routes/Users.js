const validate = require("../middlewares/validate");
const schemas = require("../validations/Users");
const express = require("express");
const router = express.Router();
const { index, create, login } = require("../controllers/Users");

router.get("/", index);
router.route("/").post(validate(schemas.createValidation), create);
router.route("/login").post(validate(schemas.loginValidation), login);

module.exports = router;
