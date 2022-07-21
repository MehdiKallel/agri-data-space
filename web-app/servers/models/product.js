const network = require('../fabric/network.js');
const apiResponse = require('../utils/apiResponse.js');
const identity = "admin";

exports.registerMeat = async (information) => {
  const {
    MeatType,
    ProcDate,
    ShellLife,
    CountryOfOrigin,
    Footprint,
    meatMat,
    FarmerMat,
  } = information;

  const networkObj = await network.connect(true, false, false, identity);
  const contractRes = await network.invoke(
    networkObj,
    "registerMeat",
    MeatType,
    ProcDate,
    ShellLife,
    meatMat,
    CountryOfOrigin,
    Footprint,
    FarmerMat
  );
  console.log(contractRes);
  const error = networkObj.error || contractRes.error;
  if (error) {
    const status = networkObj.status || contractRes.status;
    return apiResponse.createModelRes(status, error);
  }

  return apiResponse.createModelRes(200, "Success", contractRes);
};

exports.getMeatById = async (
  isFarmer,
  isTransporter,
  isAuditor,
  information
) => {
  const { meatId, id } = information;

  const networkObj = await network.connect(
    isFarmer,
    isTransporter,
    isAuditor,
    id
  );
  const contractRes = await network.invoke(networkObj, "queryMeat", meatId);

  const error = networkObj.error || contractRes.error;
  if (error) {
    const status = networkObj.status || contractRes.status;
    return apiResponse.createModelRes(status, error);
  }
  return apiResponse.createModelRes(200, "Success", contractRes);
};

exports.getAllMeatFromFarmer  = async (isFarmer, isAuditor, isTransporter, information)=> {
    const { farmerMat } = information;

    const networkObj = await network.connect( isFarmer, isAuditor, isTransporter , farmerMat);
    const contractRes = await network.invoke(networkObj, 'queryAllMeat', farmerMat);

    const error = networkObj.error || contractRes.error;
    if (error) {
        const status = networkObj.status || contractRes.status;
        return apiResponse.createModelRes(status, error);
    }

    return apiResponse.createModelRes(200, 'Success', contractRes);
};