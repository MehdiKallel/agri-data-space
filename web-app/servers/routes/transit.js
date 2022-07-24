const transitRouter = require('express').Router();
const controller = require("../controllers/transit.js");

transitRouter.post("/create", controller.createTransit);
transitRouter.get("/all", controller.getAllTransit);



module.exports = transitRouter;
