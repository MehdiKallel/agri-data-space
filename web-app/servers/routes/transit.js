const transitRouter = require('express').Router();
const controller = require("../controllers/transit.js");

transitRouter.post("/create", controller.createTransit);

module.exports = transitRouter;
