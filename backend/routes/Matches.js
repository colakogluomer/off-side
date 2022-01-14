//const validate = require("../middlewares/validate");
//const schemas = require("../validations/Matchs");
const express = require("express");
//const authenticate = require("../middlewares/authenticate");

const router = express.Router();

const {
  create,
  getAll,
  remove,
  getMatches,
} = require("../controllers/Matches");

router.route("/").post(/*validate(schemas.createValidation),*/ create);
router.route("/").get(/*authenticate,*/ getAll);
router.route("/:id").delete(/*authenticate,*/ remove);
router.route("/match").get(getMatches);
module.exports = router;
