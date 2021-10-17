'use strict';

const { Wallets, Gateway } = require("fabric-network");
const path = require('path');
const fs = require('fs');

exports.getCCP = async () => {
  try {
    const ccpPath = path.resolve(__dirname, '..', '..', '..', '..', '..',
      'test-network', 'organizations', 'peerOrganizations',
      'org3.example.com', 'connection-org3.json');    
    const ccpJSON = fs.readFileSync(ccpPath, 'utf8');
    let ccp = JSON.parse(ccpJSON);

    return ccp;
  } catch (err) {
    console.log(err);
    return err;
  }
};

exports.checkAuthorization = async (req, res, next) => {
  try {
    const enrollmentID = req.headers["enrollment-id"];

    // Create a new file system based wallet for managing identities.
    const walletPath = path.join(process.cwd(), "wallet");
    const wallet = await Wallets.newFileSystemWallet(walletPath);
    this.logger.info(`Wallet path: ${walletPath}`);

    // Check to see if we've already enrolled the user.
    const userExists = await wallet.get(enrollmentID);
    if (!userExists) {
      return res.status(401).send({
        message: `An identity for the user ${enrollmentID} does not exist in the wallet`,
      });
    }
  } catch (err) {
    this.logger.log({ level: "error", message: err });
    next(err);
  }
};

exports.setupGateway = async (user) => {
  try {
    // Create a new file system based wallet for managing identities.
    const walletPath = path.join(process.cwd(), "wallet");
    const wallet = await Wallets.newFileSystemWallet(walletPath);
    this.logger.info(`Wallet path: ${walletPath}`);

    const ccp = await this.getCCP();
    const gateway = new Gateway();
    const connectionOptions = {
      identity: user,
      wallet: wallet,
      discovery: {
        enabled: true,
        asLocalhost: process.env.AS_LOCAL_HOST == "false" ? false : true, // note: true when on docker, false when on kube
      },
    };
    // Create a new gateway for connecting to our peer node
    await gateway.connect(ccp, connectionOptions);
    return gateway;
  } catch (error) {
    throw error;
  }
};

exports.getContract = async (gateway) => {
  try {
    const network = await gateway.getNetwork("mychannel");
/**
    const listener = async (event) => {
      // Handle block event
  
      console.log("block added", event)
      // Listener may remove itself if desired
     // if (event.blockNumber.equals(endBlock)) {
      //    network.removeBlockListener(listener);
      //}
  }
  const options = {
      startBlock: 1
  };
  await network.addBlockListener(listener, options);
*/
    // Get the contract from the network.
    return await network.getContract("vehicle-network");
  } catch (err) {
    throw new Error("Error connecting to channel . ERROR:" + err.message);
  }
};

