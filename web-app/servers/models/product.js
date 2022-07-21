const network = require('../fabric/network.js');
const apiResponse = require('../utils/apiResponse.js');


exports.registerMeat = async (information) => {
  const {
    MeatType,
    ShellLife,
    ProcDate,
    CountryOfOrigin,
    Footprint,
    meatMat,
    FarmerMat,
  } = information;

  const networkObj = await network.connect(true, false, false, "admin");
  const contractRes = await network.invoke(
    networkObj,
    "registerMeat",
    MeatType,
    ShellLife,
    ProcDate,
    CountryOfOrigin,
    Footprint,
    meatMat,
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