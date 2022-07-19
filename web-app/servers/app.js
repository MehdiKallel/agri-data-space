require('dotenv').config();
const authRouter = require('express').Router();
const bodyParser = require('body-parser');
const cors = require('cors');
const express = require('express');
const morgan = require('morgan');
const apiResponse = require('./utils/apiResponse.js');
const network = require('./fabric/network.js');
const router = require('./routes/index.js');

async function main() {
    const app = express();
    app.use(morgan('combined'));
    app.use(bodyParser.json());
    app.use(cors());
    app.use('/', router);
    console.log('server is up and running');
    app.listen('8090');
}
main();
