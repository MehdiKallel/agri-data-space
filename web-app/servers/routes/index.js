const router = require('express').Router();
const userRouter = require('./user.js');
const productRouter = require('./product.js');
const transitRouter = require('./transit.js');

router.use('/user', userRouter);
router.use('/meat', productRouter);
router.use('/transit', transitRouter);

module.exports = router;
