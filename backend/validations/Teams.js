const joi = require("joi");

const createValidation = joi.object({
  name: joi.string().required().min(5),
});

module.exports = {
  createValidation,
};
