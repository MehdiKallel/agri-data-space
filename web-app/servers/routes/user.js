const authRouter = require('express').Router();
const controller = require('../controllers/user.js');
const authMiddleware = require('../middlewares/auth.js');

authRouter.post('/signup/:role', controller.signup);
authRouter.get("/all", controller.getAllUser);

module.exports = authRouter;
