const network = require('../fabric/network.js');
const apiResponse = require('../utils/apiResponse.js');
const authenticateUtil = require('../utils/authenticate.js');


exports.signup = async (isFarmer, isAuditor, isTransporter, information) => {
  const { name, email, userType, address, password } = information;

  let networkObj;
  networkObj = await network.connect(
    isFarmer,
    isAuditor,
    isTransporter,
    password
  );

  let contractRes;
  contractRes = await network.invoke(
    networkObj,
    "createUser",
    name,
    email,
    userType,
    address,
    password
  );

  return apiResponse.createModelRes(200, "Success", contractRes);
};



exports.getAllUser = async () => {
  const networkObj = await network.connect(false, false, true, "admin");

  const contractRes = await network.invoke(networkObj, "queryUsers");

  const error = networkObj.error || contractRes.error;
  if (error) {
      const status = networkObj.status || contractRes.status;

      return apiResponse.createModelRes(status, error);
  }
  return apiResponse.createModelRes(200, "Success", contractRes);
};