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
  remove,
} = require("../controllers/Teams");

router.route("/").get(/*authenticate,*/ getAll);
router.route("/search").get(/*authenticate,*/ getOne);
router
  .route("/")
  .post(authenticate, validate(schemas.createValidation), create);
router
  .route("/:id")
  .patch(authenticate, validate(schemas.updateValidation), update);

router.route("/:id").delete(/*authenticate,*/ remove);

module.exports = router;
