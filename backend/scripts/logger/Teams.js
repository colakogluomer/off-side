const winston = require("winston");

const logger = winston.createLogger({
  level: "info",
  format: winston.format.json(),
  defaultMeta: { service: "team-service" },
  transports: [
    //
    // - Write all logs with level `error` and below to `error.log`
    // - Write all logs with level `info` and below to `combined.log`
    //
    new winston.transports.File({
      filename: "logs/teams/error.log",
      level: "error",
    }),
    new winston.transports.File({
      filename: "logs/teams/info.log",
      level: "info",
    }),
    new winston.transports.File({
      filename: "logs/teams/combined.log",
    }),
  ],
});
module.exports = logger;
