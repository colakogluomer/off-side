const joi = require("joi");

const createValidation = joi.object({
  name: joi.string().required().min(3),
  password: joi.string().required().min(8),
  email: joi.string().email().required().min(8),
});

const updateValidation = joi.object({
  name: joi.string().min(3),
  email: joi.string().email().min(8),
});

const loginValidation = joi.object({
  password: joi.string().required().min(8),
  email: joi.string().email().required().min(8),
});

const resetPassword = joi.object({
  email: joi.string().email().required().min(8),
});
const changePassword = joi.object({
  password: joi.string().required().min(8),
});

module.exports = {
  createValidation,
  changePassword,
  loginValidation,
  resetPassword,
  updateValidation,
};
