const authModel = require('../models/user.js');
const apiResponse = require('../utils/apiResponse.js');

exports.signup = async (req, res) => {
  const { userType, address, name, email, password } = req.body;
  const { role } = req.params;

  console.log(req.body);
  console.log(role);

  if (!userType || !address || !name || !email || !password) {
    console.log("1");
    return apiResponse.badRequest(res);
  }

  let modelRes;

  if (role === "farmer") {
    modelRes = await authModel.signup(true, false, false, {
      userType,
      address,
      name,
      email,
      password,
    });
  } else if (role === "auditor") {
    modelRes = await authModel.signup(false, true, false, {
      userType,
      address,
      name,
      email,
      password,
    });
  } else if (role === "transporter") {
    modelRes = await authModel.signup(false, false, true, {
      userType,
      address,
      name,
      email,
      password,
    });
  } else {
    return apiResponse.badRequest(res);
  }

  return apiResponse.send(res, modelRes);
};


exports.getAllUser = async (req, res) => {
  let modelRes;
  modelRes = await authModel.getAllUser(true, false, false);

  return apiResponse.send(res, modelRes);
};