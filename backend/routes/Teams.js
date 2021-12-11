const validate = require("../middlewares/validate");
const schemas = require("../validations/Teams");
const express = require("express");
const router = express.Router();
const authenticate = require("../middlewares/authenticate");
const { getAll, create, update } = require("../controllers/Teams");

router.route("/").get(authenticate, getAll);
router
  .route("/")
  .post(authenticate, validate(schemas.createValidation), create);
router
  .route("/:id")
  .patch(authenticate, validate(schemas.updateValidation), update);
module.exports = router;
