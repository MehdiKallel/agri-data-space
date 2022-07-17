const productModel = require('../models/product.js');
const apiResponse = require('../utils/apiResponse.js');


//   0       		1      		2      			3					4					5					6
// "Type", "Processing date", "Shell life" 	"Farmer mat"	Country of origin	"CO2 Footprint"			"MeatMat"
exports.registerMeat = async (req, res) => {
    const { Type, ProcDate, ShellLife, Farmer, CountryOrigin, Footprint, MeatMat, loggedUserType } = req.body;
    console.log('1');

    if (!Type || !ProcDate || !ShellLife || !Farmer || !CountryOrigin || !Footprint || MeatMat) {
        return apiResponse.badRequest(res);
    }
    console.log('2');

    if (loggedUserType !== 'Farmer') {
        return apiResponse.badRequest(res);
    }
    console.log('3');

    const modelRes = await productModel.registerMeat({ type, procDate, shellLife, countryOfOrigin, co2FootPrint, meatMat });
    return apiResponse.send(res, modelRes);
};

exports.getMeatById = async (req, res) => {
    const { id } = req.body;
    const { productId, role } = req.params

    console.log('1');

    if (!productId || !id || !role ) {
        return apiResponse.badRequest(res);
    }
    console.log('2');
    console.log('3');
    let modelRes;
    if( role === 'farmer' ) {
        modelRes = await productModel.getMeatById(true, false, false, { productId, id });
    } else if( role === 'auditor' ) {
        modelRes = await productModel.getMeatById(false, true, false,{ productId, id });
    } else if( role === 'transporter' ) {
        modelRes = await productModel.getMeatById(false, false, true, { productId, id });
    } else {
        return apiResponse.badRequest(res);
    }
    return apiResponse.send(res, modelRes);
};

exports.getAllMeat = async (req, res) => {
    const { id } = req.body;
    const { role } = req.params
    console.log('1');

    if (!id || !role ) {
        return apiResponse.badRequest(res);
    }
    console.log('2');
    console.log('3');
    let modelRes;
    if( role === 'farmer' ) {
        modelRes = await productModel.getAllMeatFromFarmer(true, false, false, { id });
    } else if( role === 'auditor' ) {
        modelRes = await productModel.getAllMeatFromFarmer(false, true, false,{ id });
    } else if( role === 'transporter' ) {
        modelRes = await productModel.getAllMeatFromFarmer(false, false, true, { id });
    } else {
        return apiResponse.badRequest(res);
    }
    return apiResponse.send(res, modelRes);
};

