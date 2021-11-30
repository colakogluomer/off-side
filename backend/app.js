const express = require("express");
const helmet = require("helmet");
const config = require("./config");
const loaders = require("./loaders");
const { TeamRoutes, UserRoutes } = require("./routes");

config();
loaders();

const app = express();
app.use(express.json());
app.use(helmet());

app.listen(process.env.APP_PORT, () => {
  console.log("server up");
  app.use("/teams", TeamRoutes);
  app.use("/users", UserRoutes);
});
