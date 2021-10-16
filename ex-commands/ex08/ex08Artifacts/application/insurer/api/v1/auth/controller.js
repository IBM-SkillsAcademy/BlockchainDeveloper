'use strict';

const FabricCAServices = require("fabric-ca-client");
const { Wallets } = require("fabric-network");
const path = require('path');
const utils = require('../utils');

exports.enrollAdmin = async (req, res, next) => {
  try {
    // Create a new file system based wallet for managing identities.
    const walletPath = path.join(process.cwd(), "wallet");
    const wallet = await Wallets.newFileSystemWallet(walletPath);
    
    // get connection profile
    const ccp = await utils.getCCP();

    // Create a new CA client for interacting with the CA.
    const caInfo = ccp.certificateAuthorities["ca.org3.example.com"];
    const caTLSCACerts = caInfo.tlsCACerts.pem;
    const ca = new FabricCAServices(
      caInfo.url,
      { trustedRoots: caTLSCACerts, verify: false },
      caInfo.caName
    );

    // Check to see if we've already enrolled the admin user.
    const adminExists = await wallet.get("admin");
    if (adminExists) {
      return res.status(409).send({
        message:
          'An identity for the admin user "admin" already exists in the wallet',
      });
    }

    // Enroll the admin user, and import the new identity into the wallet.
    const enrollment = await ca.enroll({
      enrollmentID: 'admin',
      enrollmentSecret: 'adminpw',
    });
    const x509Identity = {
      credentials: {
        certificate: enrollment.certificate,
        privateKey: enrollment.key.toBytes(),
      },
      mspId: "Org3MSP",
      type: "X.509",
    };
    await wallet.put("admin", x509Identity);
    return res.send({
      message:
        'Successfully enrolled admin user "admin" and imported it into the wallet',
    });
  } catch (err) {
    console.log(err);
    res.send(err);
  }
};

exports.registerUser = async (req, res, next) => {
  try {
    // Create a new file system based wallet for managing identities.
    const walletPath = path.join(process.cwd(), "wallet");
    const wallet = await Wallets.newFileSystemWallet(walletPath);
    
    const enrollmentID = req.body.enrollmentID;

    // Check to see if we've already enrolled the user.
    const userExists = await wallet.get(enrollmentID);
    if (userExists) {
      return res.status(409).send({
        message: `An identity for the user ${enrollmentID} already exists in the wallet`,
      });
    }

    // Check to see if we've already enrolled the admin user.
    const adminIdentity = await wallet.get("admin");
    if (!adminIdentity) {
      return res.status(401).send({
        message: `An identity for the admin user "admin" does not exist in the wallet. Please run admin enrollment before retrying`,
      });
    }

    // get connection profile
    const ccp = await utils.getCCP();

    // Create a new CA client for interacting with the CA.
    const caInfo = ccp.certificateAuthorities["ca.org3.example.com"];
    const caTLSCACerts = caInfo.tlsCACerts.pem;
    const caClient = new FabricCAServices(
      caInfo.url,
      { trustedRoots: caTLSCACerts, verify: false },
      caInfo.caName
    );

    // build a user object for authenticating with the CA
    const provider = wallet
      .getProviderRegistry()
      .getProvider(adminIdentity.type);
    const adminUser = await provider.getUserContext(adminIdentity, "admin");

    // Register the user, enroll the user, and import the new identity into the wallet.
    // if affiliation is specified by client, the affiliation value must be configured in CA
    const secret = await caClient.register(
      {
        affiliation: "org3.department1",
        enrollmentID: enrollmentID,
        role: "client",
        attrs: [
          {
            name: "role",
            value: "Insurer",
            ecert: true,
          },
        ],
      },
      adminUser
    );
    const enrollment = await caClient.enroll({
      enrollmentID: enrollmentID,
      enrollmentSecret: secret,
    });
    const x509Identity = {
      credentials: {
        certificate: enrollment.certificate,
        privateKey: enrollment.key.toBytes(),
      },
      mspId: "Org3MSP",
      type: "X.509",
    };
    await wallet.put(enrollmentID, x509Identity);
    return res.send({
      message: `Successfully registered and enrolled user ${enrollmentID} and imported it into the wallet`,
    });
  } catch (err) {
    console.log(err);
    res.send(err);
  }
};


exports.createAffiliation = async (req, res, next) => {
  try {
    // get connection profile
    const ccp = await utils.getCCP();
    const walletPath = path.join(process.cwd(), "wallet");
    const wallet = await Wallets.newFileSystemWallet(walletPath);


    // Check to see if we've already enrolled the admin user.
    const adminIdentity = await wallet.get('admin');
    if (!adminIdentity) {
      return res.status(401).send({
        message: `An identity for the admin user "admin" does not exist in the wallet. Please run admin enrollment before retrying`
      });
    }

    // Create a new CA client for interacting with the CA.
    const caInfo = ccp.certificateAuthorities["ca.org3.example.com"];
    const caTLSCACerts = caInfo.tlsCACerts.pem;
    const caClient = new FabricCAServices(
      caInfo.url,
      { trustedRoots: caTLSCACerts, verify: false },
      caInfo.caName
    );


    const provider = wallet
    .getProviderRegistry()
    .getProvider(adminIdentity.type);
  const adminUser = await provider.getUserContext(adminIdentity, "admin");

    await caClient.newAffiliationService().create({
      name: 'org3.department1',
      force: true
    }, adminUser);


    return res.send({
      message: `Successfully created affiliation 'org3.department1'`
    });
  } catch (err) {
    console.log(err);
    res.send(err);
  }
};

