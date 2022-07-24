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

exports.signin = async (isFarmer, isAuditor, isTransporter, information) => {
  const { id, password } = information;

  const networkObj = await network.connect(
    isFarmer,
    isAuditor,
    isTransporter,
    id
  );
  let contractRes;
  contractRes = await network.invoke(networkObj, "signIn", id, password);
  const error = networkObj.error || contractRes.error;
  if (error) {
    const status = networkObj.status || contractRes.status;
    return apiResponse.createModelRes(status, error);
  }
  console.log(contractRes);
  const { Name, UserType } = contractRes;
  const accessToken = authenticateUtil.generateAccessToken({
    id,
    UserType,
    Name,
  });
  return apiResponse.createModelRes(200, "Success", {
    id,
    UserType,
    Name,
    accessToken,
  });
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