const express = require("express");
const helmet = require("helmet");
const fileUpload = require("express-fileupload");
const config = require("./config");
const loaders = require("./loaders");
const events = require("./scripts/events");
const { TeamRoutes, UserRoutes } = require("./routes");
const path = require("path");

config();
loaders();
events();

const app = express();
app.use("/uploads", express.static(path.join(__dirname, "./", "uploads")));
app.use(express.json());
app.use(helmet());
app.use(fileUpload());

app.listen(process.env.APP_PORT, () => {
  console.log("server up");
  app.use("/teams", TeamRoutes);
  app.use("/users", UserRoutes);
});
