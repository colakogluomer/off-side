const validate = require("../middlewares/validate");
const schemas = require("../validations/Teams");
const express = require("express");
const router = express.Router();
const authenticate = require("../middlewares/authenticate");
const { getAll, create } = require("../controllers/Teams");

router.route("/").get(authenticate, getAll);
router
  .route("/")
  .post(authenticate, validate(schemas.createValidation), create);

module.exports = router;
