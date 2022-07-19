const fs = require('fs');
const path = require('path');
const FabricCAServices = require('fabric-ca-client');
const { FileSystemWallet, Gateway, X509WalletMixin } = require('fabric-network');

const farmerCcpPath = path.join('/home/mehdi/agri-data-space/web-app/servers/fabric/connection-profile-farmerorg.json');
const farmerCcpFile = fs.readFileSync(farmerCcpPath, 'utf8');
const farmerCcp = JSON.parse(farmerCcpFile);

const auditorCcpPath = path.join(
    '/home/mehdi/agri-data-space/web-app/servers/fabric/connection-profile-auditororg.json',
);
const auditorCcpFile = fs.readFileSync(auditorCcpPath, 'utf8');
const auditorCcp = JSON.parse(auditorCcpFile);

const transporterCcpPath = path.join(
    '/home/mehdi/agri-data-space/web-app/servers/fabric/connection-profile-transporterorg.json',
);
const transporterCcpFile = fs.readFileSync(transporterCcpPath, 'utf8');
const transporterCcp = JSON.parse(transporterCcpFile);

function getConnectionMaterial(isFarmer, isAuditor, isTransporter) {
    const connectionMaterial = {};
    if (isFarmer) {
        connectionMaterial.walletPath = path.join(
            '/',
            'home/mehdi/agriculture-space/fablo-network/scripts/wallet/farmer',
        );
        connectionMaterial.connection = farmerCcp;
        connectionMaterial.orgMSPID = 'FarmerOrgMSP';
        connectionMaterial.caURL = 'http://localhost:7040';
    }
    if (isAuditor) {
        connectionMaterial.walletPath = path.join(
            '/',
            'home/mehdi/agriculture-space/fablo-network/scripts/wallet/auditor',
        );
        connectionMaterial.connection = auditorCcp;
        connectionMaterial.orgMSPID = 'AuditorOrgMSP';
        connectionMaterial.caURL = 'http://localhost:7060';
    }

    if (isTransporter) {
                           connectionMaterial.walletPath = path.join(
                               '/',
                               'home/mehdi/agriculture-space/fablo-network/scripts/wallet/transporter',
                           );
                           connectionMaterial.connection = transporterCcp;
                           connectionMaterial.orgMSPID = 'TransporterOrgMSP';
                           connectionMaterial.caURL = 'http://localhost:7080';
                       }
    return connectionMaterial;
}

exports.connect = async (isAuditor, isTransporter, isFarmer, userID) => {
    const gateway = new Gateway();

    try {
        const { walletPath, connection } = getConnectionMaterial(isFarmer, isAuditor, isTransporter);

        const wallet = new FileSystemWallet(walletPath);
        const userExists = await wallet.exists(userID);
        if (!userExists) {
            console.error(`An identity for the user ${userID} does not exist in the wallet. Register ${userID} first`);
            return { status: 401, error: 'User identity does not exist in the wallet.' };
        }

        await gateway.connect(connection, {
            wallet,
            identity: userID,
            discovery: { enabled: true, asLocalhost: Boolean(true) },
        });
        const network = await gateway.getNetwork('mychannel');
        const contract = await network.getContract('trackmeat-contract');
        console.log('Connected to fabric network successly.');

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

exports.registerUser = async (isFarmer, isAuditor, isTransporter, userID) => {
    const gateway = new Gateway();

    try {
        const { walletPath, connection, orgMSPID } = getConnectionMaterial(isFarmer, isAuditor, isTransporter);

        console.log(walletPath);
        console.log(orgMSPID);

        const wallet = new FileSystemWallet(walletPath);
        const userExists = await wallet.exists(userID);
        if (userExists) {
            console.error(`An identity for the user ${userID} already exists in the wallet`);
            return { status: 400, error: 'User identity already exists in the wallet.' };
        }

        await gateway.connect(connection, {
            wallet,
            identity: 'admin',
            discovery: { enabled: true, asLocalhost: Boolean(true) },
        });
        const ca = gateway.getClient().getCertificateAuthority();
        const adminIdentity = gateway.getCurrentIdentity();

        const secret = await ca.register({ enrollmentID: userID, role: 'client' }, adminIdentity);
        const enrollment = await ca.enroll({ enrollmentID: userID, enrollmentSecret: secret });
        const userIdentity = X509WalletMixin.createIdentity(orgMSPID, enrollment.certificate, enrollment.key.toBytes());
        await wallet.import(userID, userIdentity);
        console.log(`Successfully registered user. Use userID ${userID} to login`);
        return userIdentity;
    } catch (err) {
        console.error(`Failed to register user ${userID}: ${err}`);
        return { status: 500, error: err.toString() };
    } finally {
        await gateway.disconnect();
    }
};

exports.checkUserExists = async (isFarmer, isAuditor, isTransporter, userID) => {
    try {
        const { walletPath } = getConnectionMaterial(isFarmer, isAuditor, isTransporter);
        const wallet = new FileSystemWallet(walletPath);
        const userExists = await wallet.exists(userID);
        return userExists;
    } catch (err) {
        console.error(`Failed to check user exists ${userID}: ${err}`);
        return { status: 500, error: err.toString() };
    }
};
