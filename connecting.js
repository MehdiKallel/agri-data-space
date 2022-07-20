const path = require("path");
const { Wallets, Gateway, X509WalletMixin } = require("fabric-network");
const fs = require("fs");

const myChannel = "mychannel";
const myChaincodeName = "auction";
const identity = "user1";

async function main() {
  const ccpPath = path.resolve(
    __dirname,
    "fablo-network",
    "fablo-target",
    "fabric-config",
    "connection-profiles",
    "connection-profile-farmerorg.json"
  );
  const fileExists = fs.existsSync(ccpPath);
  if (!fileExists) {
    throw new Error(`no such file or directory: ${ccpPath}`);
  }

  const contents = fs.readFileSync(ccpPath, "utf8");
  const ccp = JSON.parse(contents);

  const walletPath = path.join(
    __dirname,
    "fablo-network/scripts/wallet/farmer"
  );
  const wallet = await buildWallet(Wallets, walletPath);

  const gateway = new Gateway();
  // connect using Discovery enabled

  await gateway.connect(ccp, {
    wallet: wallet,
    identity: identity,
    discovery: { enabled: false, asLocalhost: true },
  });

  const network = await gateway.getNetwork(myChannel);
  const contract = network.getContract(myChaincodeName);

  const statefulTxn = await contract.createTransaction("CreateAuction");
  await statefulTxn.submit("auctionID, item, parseInt(quantity), auditor");

  console.log(statefulTxn);
}

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

main();
