const productRouter = require('express').Router();
const controller = require("../controllers/product.js");

productRouter.post("/register", controller.registerMeat);
productRouter.get('/:role', controller.getAllMeat);

module.exports = productRouter;
