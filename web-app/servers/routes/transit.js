const transitRouter = require('express').Router();
const controller = require('../controllers/transit.js');
const authMiddleware = require('../middlewares/auth.js');
const roleMiddleware = require('../middlewares/checkRole.js');

transitRouter.use('/', authMiddleware);
transitRouter.use('/delivered', authMiddleware);
transitRouter.post('/', controller.createTransit);
transitRouter.get('/:role', controller.getAllTransit);

module.exports = transitRouter;
