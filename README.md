# Cross-party emission data tracking for agricultural process chains using Hyperledger Fabric
This project demonstrates the use of distributed ledger technologies for tracking data stemming from the production of meat products. In this application, we implement different functionalities for 3 organizations , namely auditors, farmers and transporters. Farmers are responsible for registering meat products on the network and providing a CO2 footprint data. Auditors only have read access to the ledger and can see all records related to registered products. Transporters are responsible for creating shipment packages and transporting meat products to retailers. 

# Problem statement: 
The goal for this project was to create a prototype system through which agribusinesses (farmers), regulators (auditors) and logistics providers (transporters) could interact and share data relevant to product specific CO2 or ghg emissions across a hypothetical meat-product process chain. 

# Life cycle of transactions 

=> After getting enrolled and registered, farmers will be able to register their meat products on the web app using their unique identity. In addition to that, farmers need to provide a CO2 footprint value which represents the total greenhouse gas emissions caused by product manufacture and processing.

=> Transporters are  able to create meat packages by providing the product id of the meat that is to be transported.

=> Meat product's CO2 footprint will be updated according to the distances traveled. 

=> Auditors will be able to see all the ledger data and can use this information for auditing purposes. 


# Prerequisites
TODO


# Architecture

<p align="center">
    <img src="./docs/architecture.png" width="400">
</p>

# Instructions

## Step 1: start the network using fablo tool, enroll/register admins and users for each organization

This project makes use of Fablo, a simple-to-generate Hyperledger Fabric blockchain network which is run on Docker. From a simple .yaml file specified under `/fablo-network/fablo-config.yaml`, the network is started with all the required peers. The number of peers, channel name, and ordering service type can be directly modified in the `fablo-config.yaml`. Please consult the official documentation of [fablo](https://github.com/hyperledger-labs/fablo) if you plan to change the network configuration file.

**1.1** Under `/fablo-network`, execute: 

```bash
    ./fablo recreate ./fablo-config.yaml
```

<p align="center">
    <img src="./docs/network_infrastructure.png" width="600">
</p>


**1.2** Under `/fablo-network/scripts`, execute: 

```bash
node enrollAdmin.js Farmer
node enrollAdmin.js Auditor
node enrollAdmin.js Transporter

node registerEnrollUser.js Farmer user1
node registerEnrollUser.js Auditor user2
node registerEnrollUser.js Transporter user3
```

after executing these commands, 3 users will have been registered to the network and tied to identities (user1, user2, user3).

## Step 2: start the express server

under `\web-app\servers` , execute:

```bash
npm install
node app.js
```

The Server will be listening on Port 8095 and all incoming requests will be forwarded to the network Gateway. The connection profile needed to connect to the Gateway will be loaded based on the invoked function on the client side. For example, if the client invokes "registerUser" with identity user1, we will use the connection profile for farmers (`web-app/servers/fabric/connection-profile-farmerorg.json`) with identity "user1" to connect to the gateway. 


## Step 3: start the client

under web-app/client, install the required dependencies and start the client by executing:

```bash
npm install
npm start
```






