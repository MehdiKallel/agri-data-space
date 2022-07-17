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
  enrollAdmin,
} = require("./test-application/javascript/CAUtil.js");
const {
  buildWallet,
  buildCCPFarmer,
  buildCCPAuditor,
  buildCCPTransporter,
} = require("./test-application/javascript/AppUtil.js");

const mspFarmer = "FarmerOrg";
const mspAuditor = "AuditorOrg";
const mspTransporter = "TransporterOrg";

function prettyJSONString(inputString) {
  if (inputString) {
    return JSON.stringify(JSON.parse(inputString), null, 2);
  } else {
    return inputString;
  }
}

async function connectToFarmerCA() {
  console.log("\n--> Enrolling the Farmer CA admin");
  const ccpFarmer = buildCCPFarmer();
  const caFarmerClient = buildCAClient(
    FabricCAServices,
    ccpFarmer,
    "ca.farmer.example.com"
  );
  const walletPathFarmer = path.join(__dirname, "wallet/farmer");
  const walletFarmer = await buildWallet(Wallets, walletPathFarmer);

  await enrollAdmin(caFarmerClient, walletFarmer, mspFarmer);
}

async function connectToAuditorCA() {
  console.log("\n--> Enrolling the Auditor CA admin");
  const ccpAuditor = buildCCPAuditor();
  const caAuditorClient = buildCAClient(
    FabricCAServices,
    ccpAuditor,
    "ca.auditor.example.com"
  );
  const walletPathAuditor = path.join(__dirname, "wallet/auditor");
  const walletAuditor = await buildWallet(Wallets, walletPathAuditor);

  await enrollAdmin(caAuditorClient, walletAuditor, mspAuditor);
}

async function connectToTransporterCA() {
  console.log("\n--> Enrolling the Transporter CA admin");
  const ccpTransporter = buildCCPTransporter();
  const caTransporterClient = buildCAClient(
    FabricCAServices,
    ccpTransporter,
    "ca.transporter.example.com"
  );
  const walletPathTransporter = path.join(__dirname, "wallet/transporter");
  const walletTransporter = await buildWallet(Wallets, walletPathTransporter);

  await enrollAdmin(caTransporterClient, walletTransporter, mspTransporter);
}

async function main() {
  if (process.argv[2] == undefined) {
    console.log("Usage: node enrollAdmin.js Org");
    process.exit(1);
  }

  const org = process.argv[2];

  try {
    if (org == "Auditor" || org == "auditor") {
      await connectToAuditorCA();
    } else if (org == "Farmer" || org == "farmer") {
      await connectToFarmerCA();
    } else if (org == "Transporter" || org == "transporter") {
      await connectToTransporterCA();
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
