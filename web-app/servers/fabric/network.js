"use strict";

const path = require("path");
const fs = require("fs");

const { Wallets, Gateway, X509WalletMixin } = require("fabric-network");
const myChannel = "agridata";
const myChaincodeName = "trackmeat";
const identity = "admin";

async function getConnectionMaterial(isFarmer, isAuditor, isTransporter) {
  const connectionMaterial = {};
  if (isFarmer) {
    const ccpPath = path.resolve(
      __dirname,
      "..",
      "..",
      "..",
      "fablo-network",
      "fablo-target",
      "fabric-config",
      "connection-profiles",
      "connection-profile-farmer.json"
    );
    const fileExists = fs.existsSync(ccpPath);
    if (!fileExists) {
      throw new Error(`no such file or directory: ${ccpPath}`);
    }

    const contents = fs.readFileSync(ccpPath, "utf8");
    const ccp = JSON.parse(contents);
    connectionMaterial.ccp = ccp;
    connectionMaterial.orgMSPID = "FarmerMSP";
    const walletPath = path.join(
      __dirname,
      "../../../fablo-network/scripts/wallet/farmer"
    );
    const wallet = await buildWallet(Wallets, walletPath);
    connectionMaterial.wallet = wallet;
  }
  if (isAuditor) {
    const ccpPath = path.resolve(
      __dirname,
      "..",
      "..",
      "..",
      "fablo-network",
      "fablo-target",
      "fabric-config",
      "connection-profiles",
      "connection-profile-auditor.json"
    );

    const contents = fs.readFileSync(ccpPath, "utf8");
    const ccp = JSON.parse(contents);
    connectionMaterial.ccp = ccp;
    connectionMaterial.orgMSPID = "AuditorMSP";
    const walletPath = path.join(
      __dirname,
      "../../../fablo-network/scripts/wallet/auditor"
    );
    const wallet = await buildWallet(Wallets, walletPath);
    connectionMaterial.wallet = wallet;
  }

  if (isTransporter) {
    const ccpPath = path.resolve(
      __dirname,
      "..",
      "..",
      "..",
      "fablo-network",
      "fablo-target",
      "fabric-config",
      "connection-profiles",
      "connection-profile-transporter.json"
    );
    const fileExists = fs.existsSync(ccpPath);
    if (!fileExists) {
      throw new Error(`no such file or directory: ${ccpPath}`);
    }

    const contents = fs.readFileSync(ccpPath, "utf8");
    const ccp = JSON.parse(contents);
    connectionMaterial.ccp = ccp;
    const walletPath = path.join(
      __dirname,
      "../../../fablo-network/scripts/wallet/transporter"
    );
    const wallet = await buildWallet(Wallets, walletPath);
    connectionMaterial.wallet = wallet;
  }
  return connectionMaterial;
}

exports.connect = async (isFarmer, isAuditor, isTransporter, userID) => {
  const gateway = new Gateway();

  try {
    const material = await getConnectionMaterial(
      isFarmer,
      isAuditor,
      isTransporter
    );

    await gateway.connect(material.ccp, {
      wallet: material.wallet,
      identity: userID,
      discovery: { enabled: true, asLocalhost: true },
    });

    const network = await gateway.getNetwork(myChannel);
    const contract = network.getContract(myChaincodeName);
    const networkObj = { gateway, network, contract };
    return networkObj;
  } catch (err) {
    console.error(`Fail to connect network: ${err}`);
    await gateway.disconnect();
    return { status: 500, error: err.toString() };
  }
};

exports.query = async (networkObj, ...funcAndArgs) => {
  try {
    console.log(`Query parameter: ${funcAndArgs}`);
    const funcAndArgsStrings = funcAndArgs.map((elem) => String(elem));
    const response = await networkObj.contract.evaluateTransaction(
      ...funcAndArgsStrings
    );
    console.log(`Transaction ${funcAndArgs} has been evaluated: ${response}`);

    return JSON.parse(response);
  } catch (err) {
    console.error(`Failed to evaluate transaction: ${err}`);
    return { status: 500, error: err.toString() };
  } finally {
    if (networkObj.gatway) {
      await networkObj.gateway.disconnect();
    }
  }
};

exports.invoke = async (networkObj, ...funcAndArgs) => {
  try {
    console.log(`Invoke parameter: ${funcAndArgs}`);
    const funcAndArgsStrings = funcAndArgs.map((elem) => String(elem));
    console.log(funcAndArgsStrings);
    const response = await networkObj.contract.submitTransaction(
      ...funcAndArgsStrings
    );
    console.log(response);
    console.log(`Transaction ${funcAndArgs} has been submitted: ${response}`);

    return JSON.parse(response);
  } catch (err) {
    console.error(`Failed to submit transaction: ${err}`);
    return { status: 500, error: err.toString() };
  } finally {
    if (networkObj.gatway) {
      await networkObj.gateway.disconnect();
    }
  }
};

async function buildWallet(Wallets, walletPath) {
  // Create a new  wallet : Note that wallet is for managing identities.
  let wallet;
  if (walletPath) {
    wallet = await Wallets.newFileSystemWallet(walletPath);
    console.log(`Built a file system wallet at ${walletPath}`);
  } else {
    wallet = await Wallets.newInMemoryWallet();
    console.log("Built an in memory wallet");
  }

  return wallet;
}
