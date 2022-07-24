const productModel = require('../models/product.js');
const apiResponse = require('../utils/apiResponse.js');
//   0       		1      		2      			3					4					5					6
// "Type", "Processing date", "Shell life" 	"Farmer mat"	Country of origin	"CO2 Footprint"			"MeatMat"
exports.registerMeat = async (req, res) => {
    const {
        MeatType,
        ShellLife,
        ProcDate,
        FarmerMat,
        CountryOfOrigin,
        Footprint,
        MeatMat,
    } = req.body;
    console.log("1");

    if (
      !MeatType ||
      !ShellLife ||
      !ProcDate ||
      !CountryOfOrigin ||
      !Footprint ||
      !MeatMat ||
      !FarmerMat
    ) {
      return apiResponse.badRequest(res);
    }
    const modelRes = await productModel.registerMeat({
      MeatType,
        ShellLife,
        FarmerMat,
        CountryOfOrigin,
        Footprint,
        MeatMat,
    });
    return apiResponse.send(res, modelRes);
};

exports.getMeatById = async (req, res) => {
    const { id } = req.body;
    const { productId, role } = req.params;

    console.log('1');

    if (!productId || !id || !role) {
        return apiResponse.badRequest(res);
    }
    console.log('2');
    console.log('3');
    let modelRes;
    if (role === 'farmer') {
        modelRes = await productModel.getMeatById(true, false, false, { productId, id });
    } else if (role === 'auditor') {
        modelRes = await productModel.getMeatById(false, true, false, { productId, id });
    } else if (role === 'transporter') {
        modelRes = await productModel.getMeatById(false, false, true, { productId, id });
    } else {
        return apiResponse.badRequest(res);
    }
    return apiResponse.send(res, modelRes);
};

exports.getAllMeat = async (req, res) => {
  let modelRes;
  modelRes = await productModel.getAllMeatFromFarmer(true, false, false);

  return apiResponse.send(res, modelRes);
};
