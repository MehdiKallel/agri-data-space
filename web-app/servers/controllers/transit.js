const productModel = require('../models/transit.js');
const apiResponse = require('../utils/apiResponse.js');

exports.createTransit = async (req, res) => {
  const {
    Identity,
    DepartureTime,
    ArrivalTime,
    TypeOfStorage,
    DepCoordinates,
    DestCoordinates,
    MeatMat,
    StorageTime,
    ShippingMethod,
    Footprint,
    TransporterMat,
    PackageReference,
  } = req.body;

  console.log("1");

  const modelRes = await productModel.createTransit({
    Identity,
    DepartureTime,
    ArrivalTime,
    TypeOfStorage,
    DepCoordinates,
    DestCoordinates,
    MeatMat,
    StorageTime,
    ShippingMethod,
    Footprint,
    TransporterMat,
    PackageReference,
  });
  return apiResponse.send(res, modelRes);
};

exports.getAllTransit = async (req, res) => {
    const { id } = req.body;
    const { role } = req.params;
    console.log('1');

    if (!id || !role) {
        return apiResponse.badRequest(res);
    }

    let modelRes;
    if (role === 'farmer') {
        modelRes = await productModel.getAllMeatFromFarmer(true, false, false, { id });
    } else if (role === 'auditor') {
        modelRes = await productModel.getAllMeatFromFarmer(false, true, false, { id });
    } else if (role === 'transporter') {
        modelRes = await productModel.getAllMeatFromFarmer(false, false, true, { id });
    } else {
        return apiResponse.badRequest(res);
    }
    return apiResponse.send(res, modelRes);
};
