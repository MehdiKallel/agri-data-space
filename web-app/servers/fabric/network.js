const fs = require('fs');
const path = require('path');
const FabricCAServices = require('fabric-ca-client');
const { FileSystemWallet, Gateway, X509WalletMixin } = require('fabric-network');
const myChannel = "mychannel";
const myChaincodeName = "auction";

function getConnectionMaterial(isFarmer, isAuditor, isTransporter) {
    const connectionMaterial = {};
    if (isFarmer) {
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
        connectionMaterial.ccp = ccp;
        connectionMaterial.orgMSPID = 'FarmerOrgMSP';
        const walletPath = path.join(
            __dirname,
            "fablo-network/scripts/wallet/farmer"
        );
        const wallet = await buildWallet(Wallets, walletPath);
        connectionMaterial.wallet = wallet;
    }
    if (isAuditor) {
        const ccpPath = path.resolve(
            __dirname,
            "fablo-network",
            "fablo-target",
            "fabric-config",
            "connection-profiles",
            "connection-profile-auditororg.json"
        );
        const fileExists = fs.existsSync(ccpPath);
        if (!fileExists) {
            throw new Error(`no such file or directory: ${ccpPath}`);
        }
        
        const contents = fs.readFileSync(ccpPath, "utf8");
        const ccp = JSON.parse(contents);
        connectionMaterial.ccp = ccp;
        connectionMaterial.orgMSPID = 'AuditorOrgMSP';
        const walletPath = path.join(
            __dirname,
            "fablo-network/scripts/wallet/auditor"
        );
        const wallet = await buildWallet(Wallets, walletPath);
        connectionMaterial.wallet = wallet;
    }

    if (isTransporter) {
        const ccpPath = path.resolve(
            __dirname,
            "fablo-network",
            "fablo-target",
            "fabric-config",
            "connection-profiles",
            "connection-profile-transporterorg.json"
        );
        const fileExists = fs.existsSync(ccpPath);
        if (!fileExists) {
            throw new Error(`no such file or directory: ${ccpPath}`);
        }
        
        const contents = fs.readFileSync(ccpPath, "utf8");
        const ccp = JSON.parse(contents);
        connectionMaterial.ccp = ccp;
        connectionMaterial.orgMSPID = 'TransporterOrgMSP';
        const walletPath = path.join(
            __dirname,
            "fablo-network/scripts/wallet/transporter"
        );
        const wallet = await buildWallet(Wallets, walletPath);
        connectionMaterial.wallet = wallet;
    }
    return connectionMaterial;
}

exports.connect = async (isAuditor, isTransporter, isFarmer, userID) => {
    const gateway = new Gateway();

    try {
        const { ccp, wallet } = getConnectionMaterial(isFarmer, isAuditor, isTransporter);
        
        const userExists = await wallet.exists(userID);
        if (!userExists) {
            console.error(`An identity for the user ${userID} does not exist in the wallet. Register ${userID} first`);
            return { status: 401, error: 'User identity does not exist in the wallet.' };
        }
        await gateway.connect(ccp, {
            wallet: wallet,
            identity: "admin",
            discovery: { enabled: false, asLocalhost: true },
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
        const funcAndArgsStrings = funcAndArgs.map(elem => String(elem));
        const response = await networkObj.contract.evaluateTransaction(...funcAndArgsStrings);
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
        const funcAndArgsStrings = funcAndArgs.map(elem => String(elem));
        console.log(funcAndArgsStrings);
        const response = await networkObj.contract.submitTransaction(...funcAndArgsStrings);
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