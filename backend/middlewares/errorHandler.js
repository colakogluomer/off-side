module.exports = (error, req, res, next) => {
  res
    .status(error.status || 500)
    .send(error.message || "Internal Server Error");
};
