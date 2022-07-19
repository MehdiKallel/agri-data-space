const productRouter = require('express').Router();
const controller = require('../controllers/product.js');
const authMiddleware = require('../middlewares/auth.js');
const roleMiddleware = require('../middlewares/checkRole.js');

productRouter.use('/', authMiddleware);
productRouter.use('/order', authMiddleware);
productRouter.use('/delivered', authMiddleware);

productRouter.post('/', controller.registerMeat);
productRouter.get('/:role', controller.getAllMeat);

module.exports = productRouter;
