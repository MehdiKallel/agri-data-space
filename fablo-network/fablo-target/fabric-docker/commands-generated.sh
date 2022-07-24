#!/usr/bin/env bash

generateArtifacts() {
  printHeadline "Generating basic configs" "U1F913"

  printItalics "Generating crypto material for Orderer" "U1F512"
  certsGenerate "$FABLO_NETWORK_ROOT/fabric-config" "crypto-config-orderer.yaml" "peerOrganizations/root.com" "$FABLO_NETWORK_ROOT/fabric-config/crypto-config/"

  printItalics "Generating crypto material for Farmer" "U1F512"
  certsGenerate "$FABLO_NETWORK_ROOT/fabric-config" "crypto-config-farmer.yaml" "peerOrganizations/farmer.example.com" "$FABLO_NETWORK_ROOT/fabric-config/crypto-config/"

  printItalics "Generating crypto material for Auditor" "U1F512"
  certsGenerate "$FABLO_NETWORK_ROOT/fabric-config" "crypto-config-auditor.yaml" "peerOrganizations/auditor.example.com" "$FABLO_NETWORK_ROOT/fabric-config/crypto-config/"

  printItalics "Generating crypto material for Transporter" "U1F512"
  certsGenerate "$FABLO_NETWORK_ROOT/fabric-config" "crypto-config-transporter.yaml" "peerOrganizations/transporter.example.com" "$FABLO_NETWORK_ROOT/fabric-config/crypto-config/"

  printItalics "Generating genesis block for group group1" "U1F3E0"
  genesisBlockCreate "$FABLO_NETWORK_ROOT/fabric-config" "$FABLO_NETWORK_ROOT/fabric-config/config" "Group1Genesis"

  # Create directory for chaincode packages to avoid permission errors on linux
  mkdir -p "$FABLO_NETWORK_ROOT/fabric-config/chaincode-packages"
}

startNetwork() {
  printHeadline "Starting network" "U1F680"
  (cd "$FABLO_NETWORK_ROOT"/fabric-docker && docker-compose up -d)
  sleep 4
}

generateChannelsArtifacts() {
  printHeadline "Generating config for 'agridata'" "U1F913"
  createChannelTx "agridata" "$FABLO_NETWORK_ROOT/fabric-config" "Agridata" "$FABLO_NETWORK_ROOT/fabric-config/config"
}

installChannels() {
  printHeadline "Creating 'agridata' on Farmer/peer0" "U1F63B"
  docker exec -i cli.farmer.example.com bash -c "source scripts/channel_fns.sh; createChannelAndJoinTls 'agridata' 'FarmerMSP' 'peer0.farmer.example.com:7041' 'crypto/users/Admin@farmer.example.com/msp' 'crypto/users/Admin@farmer.example.com/tls' 'crypto-orderer/tlsca.root.com-cert.pem' 'orderer0.group1.root.com:7030';"

  printItalics "Joining 'agridata' on  Farmer/peer1" "U1F638"
  docker exec -i cli.farmer.example.com bash -c "source scripts/channel_fns.sh; fetchChannelAndJoinTls 'agridata' 'FarmerMSP' 'peer1.farmer.example.com:7042' 'crypto/users/Admin@farmer.example.com/msp' 'crypto/users/Admin@farmer.example.com/tls' 'crypto-orderer/tlsca.root.com-cert.pem' 'orderer0.group1.root.com:7030';"
  printItalics "Joining 'agridata' on  Auditor/peer0" "U1F638"
  docker exec -i cli.auditor.example.com bash -c "source scripts/channel_fns.sh; fetchChannelAndJoinTls 'agridata' 'AuditorMSP' 'peer0.auditor.example.com:7061' 'crypto/users/Admin@auditor.example.com/msp' 'crypto/users/Admin@auditor.example.com/tls' 'crypto-orderer/tlsca.root.com-cert.pem' 'orderer0.group1.root.com:7030';"
  printItalics "Joining 'agridata' on  Auditor/peer1" "U1F638"
  docker exec -i cli.auditor.example.com bash -c "source scripts/channel_fns.sh; fetchChannelAndJoinTls 'agridata' 'AuditorMSP' 'peer1.auditor.example.com:7062' 'crypto/users/Admin@auditor.example.com/msp' 'crypto/users/Admin@auditor.example.com/tls' 'crypto-orderer/tlsca.root.com-cert.pem' 'orderer0.group1.root.com:7030';"
  printItalics "Joining 'agridata' on  Transporter/peer0" "U1F638"
  docker exec -i cli.transporter.example.com bash -c "source scripts/channel_fns.sh; fetchChannelAndJoinTls 'agridata' 'TransporterMSP' 'peer0.transporter.example.com:7081' 'crypto/users/Admin@transporter.example.com/msp' 'crypto/users/Admin@transporter.example.com/tls' 'crypto-orderer/tlsca.root.com-cert.pem' 'orderer0.group1.root.com:7030';"
  printItalics "Joining 'agridata' on  Transporter/peer1" "U1F638"
  docker exec -i cli.transporter.example.com bash -c "source scripts/channel_fns.sh; fetchChannelAndJoinTls 'agridata' 'TransporterMSP' 'peer1.transporter.example.com:7082' 'crypto/users/Admin@transporter.example.com/msp' 'crypto/users/Admin@transporter.example.com/tls' 'crypto-orderer/tlsca.root.com-cert.pem' 'orderer0.group1.root.com:7030';"
}

installChaincodes() {
  if [ -n "$(ls "$CHAINCODES_BASE_DIR/../trackmeat")" ]; then
    local version="0.0.1"
    printHeadline "Packaging chaincode 'trackmeat'" "U1F60E"
    chaincodeBuild "trackmeat" "golang" "$CHAINCODES_BASE_DIR/../trackmeat"
    chaincodePackage "cli.farmer.example.com" "peer0.farmer.example.com:7041" "trackmeat" "$version" "golang" printHeadline "Installing 'trackmeat' for Farmer" "U1F60E"
    chaincodeInstall "cli.farmer.example.com" "peer0.farmer.example.com:7041" "trackmeat" "$version" "crypto-orderer/tlsca.root.com-cert.pem"
    chaincodeInstall "cli.farmer.example.com" "peer1.farmer.example.com:7042" "trackmeat" "$version" "crypto-orderer/tlsca.root.com-cert.pem"
    chaincodeApprove "cli.farmer.example.com" "peer0.farmer.example.com:7041" "agridata" "trackmeat" "$version" "orderer0.group1.root.com:7030" "AND('FarmerMSP.member', 'AuditorMSP.member', 'TransporterMSP.member')" "false" "crypto-orderer/tlsca.root.com-cert.pem" ""
    printHeadline "Installing 'trackmeat' for Auditor" "U1F60E"
    chaincodeInstall "cli.auditor.example.com" "peer0.auditor.example.com:7061" "trackmeat" "$version" "crypto-orderer/tlsca.root.com-cert.pem"
    chaincodeInstall "cli.auditor.example.com" "peer1.auditor.example.com:7062" "trackmeat" "$version" "crypto-orderer/tlsca.root.com-cert.pem"
    chaincodeApprove "cli.auditor.example.com" "peer0.auditor.example.com:7061" "agridata" "trackmeat" "$version" "orderer0.group1.root.com:7030" "AND('FarmerMSP.member', 'AuditorMSP.member', 'TransporterMSP.member')" "false" "crypto-orderer/tlsca.root.com-cert.pem" ""
    printHeadline "Installing 'trackmeat' for Transporter" "U1F60E"
    chaincodeInstall "cli.transporter.example.com" "peer0.transporter.example.com:7081" "trackmeat" "$version" "crypto-orderer/tlsca.root.com-cert.pem"
    chaincodeInstall "cli.transporter.example.com" "peer1.transporter.example.com:7082" "trackmeat" "$version" "crypto-orderer/tlsca.root.com-cert.pem"
    chaincodeApprove "cli.transporter.example.com" "peer0.transporter.example.com:7081" "agridata" "trackmeat" "$version" "orderer0.group1.root.com:7030" "AND('FarmerMSP.member', 'AuditorMSP.member', 'TransporterMSP.member')" "false" "crypto-orderer/tlsca.root.com-cert.pem" ""
    printItalics "Committing chaincode 'trackmeat' on channel 'agridata' as 'Farmer'" "U1F618"
    chaincodeCommit "cli.farmer.example.com" "peer0.farmer.example.com:7041" "agridata" "trackmeat" "$version" "orderer0.group1.root.com:7030" "AND('FarmerMSP.member', 'AuditorMSP.member', 'TransporterMSP.member')" "false" "crypto-orderer/tlsca.root.com-cert.pem" "peer0.farmer.example.com:7041,peer0.auditor.example.com:7061,peer0.transporter.example.com:7081" "crypto-peer/peer0.farmer.example.com/tls/ca.crt,crypto-peer/peer0.auditor.example.com/tls/ca.crt,crypto-peer/peer0.transporter.example.com/tls/ca.crt" ""
  else
    echo "Warning! Skipping chaincode 'trackmeat' installation. Chaincode directory is empty."
    echo "Looked in dir: '$CHAINCODES_BASE_DIR/../trackmeat'"
  fi

}

notifyOrgsAboutChannels() {
  printHeadline "Creating new channel config blocks" "U1F537"
  createNewChannelUpdateTx "agridata" "FarmerMSP" "Agridata" "$FABLO_NETWORK_ROOT/fabric-config" "$FABLO_NETWORK_ROOT/fabric-config/config"
  createNewChannelUpdateTx "agridata" "AuditorMSP" "Agridata" "$FABLO_NETWORK_ROOT/fabric-config" "$FABLO_NETWORK_ROOT/fabric-config/config"
  createNewChannelUpdateTx "agridata" "TransporterMSP" "Agridata" "$FABLO_NETWORK_ROOT/fabric-config" "$FABLO_NETWORK_ROOT/fabric-config/config"

  printHeadline "Notyfing orgs about channels" "U1F4E2"
  notifyOrgAboutNewChannelTls "agridata" "FarmerMSP" "cli.farmer.example.com" "peer0.farmer.example.com" "orderer0.group1.root.com:7030" "crypto-orderer/tlsca.root.com-cert.pem"
  notifyOrgAboutNewChannelTls "agridata" "AuditorMSP" "cli.auditor.example.com" "peer0.auditor.example.com" "orderer0.group1.root.com:7030" "crypto-orderer/tlsca.root.com-cert.pem"
  notifyOrgAboutNewChannelTls "agridata" "TransporterMSP" "cli.transporter.example.com" "peer0.transporter.example.com" "orderer0.group1.root.com:7030" "crypto-orderer/tlsca.root.com-cert.pem"

  printHeadline "Deleting new channel config blocks" "U1F52A"
  deleteNewChannelUpdateTx "agridata" "FarmerMSP" "cli.farmer.example.com"
  deleteNewChannelUpdateTx "agridata" "AuditorMSP" "cli.auditor.example.com"
  deleteNewChannelUpdateTx "agridata" "TransporterMSP" "cli.transporter.example.com"
}

upgradeChaincode() {
  local chaincodeName="$1"
  if [ -z "$chaincodeName" ]; then
    echo "Error: chaincode name is not provided"
    exit 1
  fi

  local version="$2"
  if [ -z "$version" ]; then
    echo "Error: chaincode version is not provided"
    exit 1
  fi

  if [ "$chaincodeName" = "trackmeat" ]; then
    if [ -n "$(ls "$CHAINCODES_BASE_DIR/../trackmeat")" ]; then
      printHeadline "Packaging chaincode 'trackmeat'" "U1F60E"
      chaincodeBuild "trackmeat" "golang" "$CHAINCODES_BASE_DIR/../trackmeat"
      chaincodePackage "cli.farmer.example.com" "peer0.farmer.example.com:7041" "trackmeat" "$version" "golang" printHeadline "Installing 'trackmeat' for Farmer" "U1F60E"
      chaincodeInstall "cli.farmer.example.com" "peer0.farmer.example.com:7041" "trackmeat" "$version" "crypto-orderer/tlsca.root.com-cert.pem"
      chaincodeInstall "cli.farmer.example.com" "peer1.farmer.example.com:7042" "trackmeat" "$version" "crypto-orderer/tlsca.root.com-cert.pem"
      chaincodeApprove "cli.farmer.example.com" "peer0.farmer.example.com:7041" "agridata" "trackmeat" "$version" "orderer0.group1.root.com:7030" "AND('FarmerMSP.member', 'AuditorMSP.member', 'TransporterMSP.member')" "false" "crypto-orderer/tlsca.root.com-cert.pem" ""
      printHeadline "Installing 'trackmeat' for Auditor" "U1F60E"
      chaincodeInstall "cli.auditor.example.com" "peer0.auditor.example.com:7061" "trackmeat" "$version" "crypto-orderer/tlsca.root.com-cert.pem"
      chaincodeInstall "cli.auditor.example.com" "peer1.auditor.example.com:7062" "trackmeat" "$version" "crypto-orderer/tlsca.root.com-cert.pem"
      chaincodeApprove "cli.auditor.example.com" "peer0.auditor.example.com:7061" "agridata" "trackmeat" "$version" "orderer0.group1.root.com:7030" "AND('FarmerMSP.member', 'AuditorMSP.member', 'TransporterMSP.member')" "false" "crypto-orderer/tlsca.root.com-cert.pem" ""
      printHeadline "Installing 'trackmeat' for Transporter" "U1F60E"
      chaincodeInstall "cli.transporter.example.com" "peer0.transporter.example.com:7081" "trackmeat" "$version" "crypto-orderer/tlsca.root.com-cert.pem"
      chaincodeInstall "cli.transporter.example.com" "peer1.transporter.example.com:7082" "trackmeat" "$version" "crypto-orderer/tlsca.root.com-cert.pem"
      chaincodeApprove "cli.transporter.example.com" "peer0.transporter.example.com:7081" "agridata" "trackmeat" "$version" "orderer0.group1.root.com:7030" "AND('FarmerMSP.member', 'AuditorMSP.member', 'TransporterMSP.member')" "false" "crypto-orderer/tlsca.root.com-cert.pem" ""
      printItalics "Committing chaincode 'trackmeat' on channel 'agridata' as 'Farmer'" "U1F618"
      chaincodeCommit "cli.farmer.example.com" "peer0.farmer.example.com:7041" "agridata" "trackmeat" "$version" "orderer0.group1.root.com:7030" "AND('FarmerMSP.member', 'AuditorMSP.member', 'TransporterMSP.member')" "false" "crypto-orderer/tlsca.root.com-cert.pem" "peer0.farmer.example.com:7041,peer0.auditor.example.com:7061,peer0.transporter.example.com:7081" "crypto-peer/peer0.farmer.example.com/tls/ca.crt,crypto-peer/peer0.auditor.example.com/tls/ca.crt,crypto-peer/peer0.transporter.example.com/tls/ca.crt" ""

    else
      echo "Warning! Skipping chaincode 'trackmeat' upgrade. Chaincode directory is empty."
      echo "Looked in dir: '$CHAINCODES_BASE_DIR/../trackmeat'"
    fi
  fi
}

stopNetwork() {
  printHeadline "Stopping network" "U1F68F"
  (cd "$FABLO_NETWORK_ROOT"/fabric-docker && docker-compose stop)
  sleep 4
}

networkDown() {
  printHeadline "Destroying network" "U1F916"
  (cd "$FABLO_NETWORK_ROOT"/fabric-docker && docker-compose down)

  printf "\nRemoving chaincode containers & images... \U1F5D1 \n"
  docker rm -f $(docker ps -a | grep dev-peer0.farmer.example.com-trackmeat-0.0.1-* | awk '{print $1}') || echo "docker rm failed, Check if all fabric dockers properly was deleted"
  docker rmi $(docker images dev-peer0.farmer.example.com-trackmeat-0.0.1-* -q) || echo "docker rm failed, Check if all fabric dockers properly was deleted"
  docker rm -f $(docker ps -a | grep dev-peer1.farmer.example.com-trackmeat-0.0.1-* | awk '{print $1}') || echo "docker rm failed, Check if all fabric dockers properly was deleted"
  docker rmi $(docker images dev-peer1.farmer.example.com-trackmeat-0.0.1-* -q) || echo "docker rm failed, Check if all fabric dockers properly was deleted"
  docker rm -f $(docker ps -a | grep dev-peer0.auditor.example.com-trackmeat-0.0.1-* | awk '{print $1}') || echo "docker rm failed, Check if all fabric dockers properly was deleted"
  docker rmi $(docker images dev-peer0.auditor.example.com-trackmeat-0.0.1-* -q) || echo "docker rm failed, Check if all fabric dockers properly was deleted"
  docker rm -f $(docker ps -a | grep dev-peer1.auditor.example.com-trackmeat-0.0.1-* | awk '{print $1}') || echo "docker rm failed, Check if all fabric dockers properly was deleted"
  docker rmi $(docker images dev-peer1.auditor.example.com-trackmeat-0.0.1-* -q) || echo "docker rm failed, Check if all fabric dockers properly was deleted"
  docker rm -f $(docker ps -a | grep dev-peer0.transporter.example.com-trackmeat-0.0.1-* | awk '{print $1}') || echo "docker rm failed, Check if all fabric dockers properly was deleted"
  docker rmi $(docker images dev-peer0.transporter.example.com-trackmeat-0.0.1-* -q) || echo "docker rm failed, Check if all fabric dockers properly was deleted"
  docker rm -f $(docker ps -a | grep dev-peer1.transporter.example.com-trackmeat-0.0.1-* | awk '{print $1}') || echo "docker rm failed, Check if all fabric dockers properly was deleted"
  docker rmi $(docker images dev-peer1.transporter.example.com-trackmeat-0.0.1-* -q) || echo "docker rm failed, Check if all fabric dockers properly was deleted"

  printf "\nRemoving generated configs... \U1F5D1 \n"
  rm -rf "$FABLO_NETWORK_ROOT/fabric-config/config"
  rm -rf "$FABLO_NETWORK_ROOT/fabric-config/crypto-config"
  rm -rf "$FABLO_NETWORK_ROOT/fabric-config/chaincode-packages"

  printHeadline "Done! Network was purged" "U1F5D1"
}
