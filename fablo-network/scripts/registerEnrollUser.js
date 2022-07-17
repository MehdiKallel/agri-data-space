/*
 * Copyright IBM Corp. All Rights Reserved.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

"use strict";

const { Wallets } = require("fabric-network");
const FabricCAServices = require("fabric-ca-client");
const path = require("path");


const {
  buildCAClient,
  registerAndEnrollUser,
} = require("./test-application/javascript/CAUtil.js");
const {
  buildWallet,
  buildCCPAuditor,
  buildCCPTransporter,
  buildCCPFarmer,
} = require("./test-application/javascript/AppUtil.js");

const mspFarmer = "OrgFarmer";
const mspTransporter = "OrgTransporter";
const mspAuditor = "OrgAuditor";

function prettyJSONString(inputString) {
  if (inputString) {
    return JSON.stringify(JSON.parse(inputString), null, 2);
  } else {
    return inputString;
  }
}

async function connectToAuditorCA(UserID) {
  console.log("\n--> Register and enrolling new user");
  const ccpAuditor = buildCCPAuditor();
  const caAuditorClient = buildCAClient(
    FabricCAServices,
    ccpAuditor,
    "ca.auditor.example.com"
  );
  const walletPathAuditor = path.join(__dirname, "wallet/auditor");
  const walletAuditor = await buildWallet(Wallets, walletPathAuditor);
  await registerAndEnrollUser(
    caAuditorClient,
    walletAuditor,
    mspAuditor,
    UserID
  );
}

async function connectToTransporterCA(UserID) {
  console.log("\n--> Register and enrolling new user");
  const ccpTransporter = buildCCPTransporter();
  const caTransporterClient = buildCAClient(
    FabricCAServices,
    ccpTransporter,
    "ca.transporter.example.com"
  );
  const walletPathTransporter = path.join(__dirname, "wallet/transporter");
  const walletTransporter = await buildWallet(Wallets, walletPathTransporter);
  await registerAndEnrollUser(
    caTransporterClient,
    walletTransporter,
    mspTransporter,
    UserID
  );
}

async function connectToFarmerCA(UserID) {
  const ccpFarmer = buildCCPFarmer();
  const caFarmerClient = buildCAClient(
    FabricCAServices,
    ccpFarmer,
    "ca.farmer.example.com"
  );
  const walletPathFarmer = path.join(__dirname, "wallet/farmer");
  const walletFarmer = await buildWallet(Wallets, walletPathFarmer);
  await registerAndEnrollUser(caFarmerClient, walletFarmer, mspFarmer, UserID);
}

async function main() {
  if (process.argv[2] == undefined && process.argv[3] == undefined) {
    console.log("Usage: node registerEnrollUser.js org userID");
    process.exit(1);
  }

  const org = process.argv[2];
  const userId = process.argv[3];

  try {
    if (org == "Auditor" || org == "auditor") {
      await connectToAuditorCA(userId);
    } else if (org == "Farmer" || org == "farmer") {
      await connectToFarmerCA(userId);
    } else if (org == "Transporter" || org == "transporter") {
      await connectToTransporterCA(userId);
    } else {
      console.log("Usage: node registerUser.js org userID");
      console.log("Org must be Farmer or Auditor or Transporter");
    }
  } catch (error) {
    console.error(`Error in enrolling admin: ${error}`);
    process.exit(1);
  }
}

main();
