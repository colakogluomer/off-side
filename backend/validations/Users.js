const joi = require("joi");

const createValidation = joi.object({
  name: joi.string().required().min(3),
  password: joi.string().required().min(8),
  email: joi.string().email().required().min(8),
});

const loginValidation = joi.object({
  password: joi.string().required().min(8),
  email: joi.string().email().required().min(8),
});

module.exports = {
  createValidation,
  loginValidation,
};
