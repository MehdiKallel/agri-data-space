const authModel = require('../models/transit.js');
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
    let modelRes;
    modelRes = await authModel.getAllTransit(true, false, false);
    return apiResponse.send(res, modelRes);
};
