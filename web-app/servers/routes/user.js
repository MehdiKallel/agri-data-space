const authRouter = require('express').Router();
const controller = require('../controllers/user.js');
const authMiddleware = require('../middlewares/auth.js');

authRouter.use('/signup/:role', authMiddleware);

authRouter.post('/signup/:role', controller.signup);
authRouter.get('/all/:role', controller.getAllUser);
authRouter.post('/signin/:role', controller.signin);

module.exports = authRouter;
