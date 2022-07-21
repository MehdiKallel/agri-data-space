require('dotenv').config();
const bodyParser = require('body-parser');
const cors = require('cors');
const express = require('express');
const morgan = require('morgan');
const router = require('./routes/index.js');

async function main() {
    const app = express();
    app.use(morgan('dev'));
    app.use(bodyParser.json());
    app.use(cors());
    app.use('/', router);
    console.log('server is up and running: listening on port 8090');
    app.listen('8090');
}
main();
