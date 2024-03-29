const network = require("../fabric/network.js");
const apiResponse = require("../utils/apiResponse.js");
const identity = "admin";

exports.createTransit = async (information) => {
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
  } = information;

  const networkObj = await network.connect(false, false, true, "admin");
  const contractRes = await network.invoke(
    networkObj,
    "transitMeat",
    DepartureTime,
    ArrivalTime,
    TypeOfStorage,
    DepCoordinates,
    DestCoordinates,
    MeatMat,
    StorageTime,
    ShippingMethod,
    Footprint,
    PackageReference
  );
  console.log(contractRes);
  const error = networkObj.error || contractRes.error;
  if (error) {
    const status = networkObj.status || contractRes.status;
    return apiResponse.createModelRes(status, error);
  }
  return apiResponse.createModelRes(200, "Success", contractRes);
};

exports.getAllTransit = async () => {

  const networkObj = await network.connect(
    "false",
    "false",
    "true",
    "admin"
  );
  const contractRes = await network.invoke(
    networkObj,
    "queryTransit"
  );

  const error = networkObj.error || contractRes.error;
  if (error) {
    const status = networkObj.status || contractRes.status;
    return apiResponse.createModelRes(status, error);
  }

  return apiResponse.createModelRes(200, "Success", contractRes);
};


exports.updateTransit = async (information) => {
  const {
    PackageReference,
    DepLat,
    DepLong,
    DestLat,
    DestLong} = information 
  const networkObj = await network.connect(
    "false",
    "false",
    "true",
    "admin"
  );
  const contractRes = await network.invoke(
    networkObj,
    "updateTransit",
     PackageReference,
      DepLat,
      DepLong,
      DestLat,
      DestLong,
  );

  const error = networkObj.error || contractRes.error;
  if (error) {
    const status = networkObj.status || contractRes.status;
    return apiResponse.createModelRes(status, error);
  }

  return apiResponse.createModelRes(200, "Success", contractRes);

}

exports.deliverTransit = async (information) => {
  const {transitId} = information
  const networkObj = await network.connect(
    "false",
    "false",
    "true",
    "admin"
  );
  const contractRes = await network.invoke(
    networkObj,
    "deliverTransit",
    transitId,
  );

  const error = networkObj.error || contractRes.error;
  if (error) {
    const status = networkObj.status || contractRes.status;
    return apiResponse.createModelRes(status, error);
  }

  return apiResponse.createModelRes(200, "Success", contractRes);

}