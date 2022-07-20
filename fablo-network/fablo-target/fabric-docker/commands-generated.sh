#!/usr/bin/env bash

generateArtifacts() {
  printHeadline "Generating basic configs" "U1F913"

  printItalics "Generating crypto material for Orderer" "U1F512"
  certsGenerate "$FABLO_NETWORK_ROOT/fabric-config" "crypto-config-orderer.yaml" "peerOrganizations/root.com" "$FABLO_NETWORK_ROOT/fabric-config/crypto-config/"

  printItalics "Generating crypto material for FarmerOrg" "U1F512"
  certsGenerate "$FABLO_NETWORK_ROOT/fabric-config" "crypto-config-farmerorg.yaml" "peerOrganizations/farmer.example.com" "$FABLO_NETWORK_ROOT/fabric-config/crypto-config/"

  printItalics "Generating crypto material for AuditorOrg" "U1F512"
  certsGenerate "$FABLO_NETWORK_ROOT/fabric-config" "crypto-config-auditororg.yaml" "peerOrganizations/auditor.example.com" "$FABLO_NETWORK_ROOT/fabric-config/crypto-config/"

  printItalics "Generating crypto material for TransporterOrg" "U1F512"
  certsGenerate "$FABLO_NETWORK_ROOT/fabric-config" "crypto-config-transporterorg.yaml" "peerOrganizations/transporter.example.com" "$FABLO_NETWORK_ROOT/fabric-config/crypto-config/"

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
  printHeadline "Generating config for 'mychannel'" "U1F913"
  createChannelTx "mychannel" "$FABLO_NETWORK_ROOT/fabric-config" "Mychannel" "$FABLO_NETWORK_ROOT/fabric-config/config"
}

installChannels() {
  printHeadline "Creating 'mychannel' on FarmerOrg/peer0" "U1F63B"
  docker exec -i cli.farmer.example.com bash -c "source scripts/channel_fns.sh; createChannelAndJoin 'mychannel' 'FarmerOrgMSP' 'peer0.farmer.example.com:7041' 'crypto/users/Admin@farmer.example.com/msp' 'orderer0.group1.root.com:7030';"

  printItalics "Joining 'mychannel' on  FarmerOrg/peer1" "U1F638"
  docker exec -i cli.farmer.example.com bash -c "source scripts/channel_fns.sh; fetchChannelAndJoin 'mychannel' 'FarmerOrgMSP' 'peer1.farmer.example.com:7042' 'crypto/users/Admin@farmer.example.com/msp' 'orderer0.group1.root.com:7030';"
  printItalics "Joining 'mychannel' on  AuditorOrg/peer0" "U1F638"
  docker exec -i cli.auditor.example.com bash -c "source scripts/channel_fns.sh; fetchChannelAndJoin 'mychannel' 'AuditorOrgMSP' 'peer0.auditor.example.com:7061' 'crypto/users/Admin@auditor.example.com/msp' 'orderer0.group1.root.com:7030';"
  printItalics "Joining 'mychannel' on  AuditorOrg/peer1" "U1F638"
  docker exec -i cli.auditor.example.com bash -c "source scripts/channel_fns.sh; fetchChannelAndJoin 'mychannel' 'AuditorOrgMSP' 'peer1.auditor.example.com:7062' 'crypto/users/Admin@auditor.example.com/msp' 'orderer0.group1.root.com:7030';"
  printItalics "Joining 'mychannel' on  TransporterOrg/peer0" "U1F638"
  docker exec -i cli.transporter.example.com bash -c "source scripts/channel_fns.sh; fetchChannelAndJoin 'mychannel' 'TransporterOrgMSP' 'peer0.transporter.example.com:7081' 'crypto/users/Admin@transporter.example.com/msp' 'orderer0.group1.root.com:7030';"
  printItalics "Joining 'mychannel' on  TransporterOrg/peer1" "U1F638"
  docker exec -i cli.transporter.example.com bash -c "source scripts/channel_fns.sh; fetchChannelAndJoin 'mychannel' 'TransporterOrgMSP' 'peer1.transporter.example.com:7082' 'crypto/users/Admin@transporter.example.com/msp' 'orderer0.group1.root.com:7030';"
}

installChaincodes() {
  if [ -n "$(ls "$CHAINCODES_BASE_DIR/../trackmeat")" ]; then
    local version="0.0.1"
    printHeadline "Packaging chaincode 'and-policy-chaincode'" "U1F60E"
    chaincodeBuild "and-policy-chaincode" "golang" "$CHAINCODES_BASE_DIR/../trackmeat"
    chaincodePackage "cli.farmer.example.com" "peer0.farmer.example.com:7041" "and-policy-chaincode" "$version" "golang" printHeadline "Installing 'and-policy-chaincode' for FarmerOrg" "U1F60E"
    chaincodeInstall "cli.farmer.example.com" "peer0.farmer.example.com:7041" "and-policy-chaincode" "$version" ""
    chaincodeInstall "cli.farmer.example.com" "peer1.farmer.example.com:7042" "and-policy-chaincode" "$version" ""
    chaincodeApprove "cli.farmer.example.com" "peer0.farmer.example.com:7041" "mychannel" "and-policy-chaincode" "$version" "orderer0.group1.root.com:7030" "" "false" "" ""
    printHeadline "Installing 'and-policy-chaincode' for AuditorOrg" "U1F60E"
    chaincodeInstall "cli.auditor.example.com" "peer0.auditor.example.com:7061" "and-policy-chaincode" "$version" ""
    chaincodeInstall "cli.auditor.example.com" "peer1.auditor.example.com:7062" "and-policy-chaincode" "$version" ""
    chaincodeApprove "cli.auditor.example.com" "peer0.auditor.example.com:7061" "mychannel" "and-policy-chaincode" "$version" "orderer0.group1.root.com:7030" "" "false" "" ""
    printHeadline "Installing 'and-policy-chaincode' for TransporterOrg" "U1F60E"
    chaincodeInstall "cli.transporter.example.com" "peer0.transporter.example.com:7081" "and-policy-chaincode" "$version" ""
    chaincodeInstall "cli.transporter.example.com" "peer1.transporter.example.com:7082" "and-policy-chaincode" "$version" ""
    chaincodeApprove "cli.transporter.example.com" "peer0.transporter.example.com:7081" "mychannel" "and-policy-chaincode" "$version" "orderer0.group1.root.com:7030" "" "false" "" ""
    printItalics "Committing chaincode 'and-policy-chaincode' on channel 'mychannel' as 'FarmerOrg'" "U1F618"
    chaincodeCommit "cli.farmer.example.com" "peer0.farmer.example.com:7041" "mychannel" "and-policy-chaincode" "$version" "orderer0.group1.root.com:7030" "" "false" "" "peer0.farmer.example.com:7041,peer0.auditor.example.com:7061,peer0.transporter.example.com:7081" "" ""
  else
    echo "Warning! Skipping chaincode 'and-policy-chaincode' installation. Chaincode directory is empty."
    echo "Looked in dir: '$CHAINCODES_BASE_DIR/../trackmeat'"
  fi

}

notifyOrgsAboutChannels() {
  printHeadline "Creating new channel config blocks" "U1F537"
  createNewChannelUpdateTx "mychannel" "FarmerOrgMSP" "Mychannel" "$FABLO_NETWORK_ROOT/fabric-config" "$FABLO_NETWORK_ROOT/fabric-config/config"
  createNewChannelUpdateTx "mychannel" "AuditorOrgMSP" "Mychannel" "$FABLO_NETWORK_ROOT/fabric-config" "$FABLO_NETWORK_ROOT/fabric-config/config"
  createNewChannelUpdateTx "mychannel" "TransporterOrgMSP" "Mychannel" "$FABLO_NETWORK_ROOT/fabric-config" "$FABLO_NETWORK_ROOT/fabric-config/config"

  printHeadline "Notyfing orgs about channels" "U1F4E2"
  notifyOrgAboutNewChannel "mychannel" "FarmerOrgMSP" "cli.farmer.example.com" "peer0.farmer.example.com" "orderer0.group1.root.com:7030"
  notifyOrgAboutNewChannel "mychannel" "AuditorOrgMSP" "cli.auditor.example.com" "peer0.auditor.example.com" "orderer0.group1.root.com:7030"
  notifyOrgAboutNewChannel "mychannel" "TransporterOrgMSP" "cli.transporter.example.com" "peer0.transporter.example.com" "orderer0.group1.root.com:7030"

  printHeadline "Deleting new channel config blocks" "U1F52A"
  deleteNewChannelUpdateTx "mychannel" "FarmerOrgMSP" "cli.farmer.example.com"
  deleteNewChannelUpdateTx "mychannel" "AuditorOrgMSP" "cli.auditor.example.com"
  deleteNewChannelUpdateTx "mychannel" "TransporterOrgMSP" "cli.transporter.example.com"
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

  if [ "$chaincodeName" = "and-policy-chaincode" ]; then
    if [ -n "$(ls "$CHAINCODES_BASE_DIR/../trackmeat")" ]; then
      printHeadline "Packaging chaincode 'and-policy-chaincode'" "U1F60E"
      chaincodeBuild "and-policy-chaincode" "golang" "$CHAINCODES_BASE_DIR/../trackmeat"
      chaincodePackage "cli.farmer.example.com" "peer0.farmer.example.com:7041" "and-policy-chaincode" "$version" "golang" printHeadline "Installing 'and-policy-chaincode' for FarmerOrg" "U1F60E"
      chaincodeInstall "cli.farmer.example.com" "peer0.farmer.example.com:7041" "and-policy-chaincode" "$version" ""
      chaincodeInstall "cli.farmer.example.com" "peer1.farmer.example.com:7042" "and-policy-chaincode" "$version" ""
      chaincodeApprove "cli.farmer.example.com" "peer0.farmer.example.com:7041" "mychannel" "and-policy-chaincode" "$version" "orderer0.group1.root.com:7030" "" "false" "" ""
      printHeadline "Installing 'and-policy-chaincode' for AuditorOrg" "U1F60E"
      chaincodeInstall "cli.auditor.example.com" "peer0.auditor.example.com:7061" "and-policy-chaincode" "$version" ""
      chaincodeInstall "cli.auditor.example.com" "peer1.auditor.example.com:7062" "and-policy-chaincode" "$version" ""
      chaincodeApprove "cli.auditor.example.com" "peer0.auditor.example.com:7061" "mychannel" "and-policy-chaincode" "$version" "orderer0.group1.root.com:7030" "" "false" "" ""
      printHeadline "Installing 'and-policy-chaincode' for TransporterOrg" "U1F60E"
      chaincodeInstall "cli.transporter.example.com" "peer0.transporter.example.com:7081" "and-policy-chaincode" "$version" ""
      chaincodeInstall "cli.transporter.example.com" "peer1.transporter.example.com:7082" "and-policy-chaincode" "$version" ""
      chaincodeApprove "cli.transporter.example.com" "peer0.transporter.example.com:7081" "mychannel" "and-policy-chaincode" "$version" "orderer0.group1.root.com:7030" "" "false" "" ""
      printItalics "Committing chaincode 'and-policy-chaincode' on channel 'mychannel' as 'FarmerOrg'" "U1F618"
      chaincodeCommit "cli.farmer.example.com" "peer0.farmer.example.com:7041" "mychannel" "and-policy-chaincode" "$version" "orderer0.group1.root.com:7030" "" "false" "" "peer0.farmer.example.com:7041,peer0.auditor.example.com:7061,peer0.transporter.example.com:7081" "" ""

    else
      echo "Warning! Skipping chaincode 'and-policy-chaincode' upgrade. Chaincode directory is empty."
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
  docker rm -f $(docker ps -a | grep dev-peer0.farmer.example.com-and-policy-chaincode-0.0.1-* | awk '{print $1}') || echo "docker rm failed, Check if all fabric dockers properly was deleted"
  docker rmi $(docker images dev-peer0.farmer.example.com-and-policy-chaincode-0.0.1-* -q) || echo "docker rm failed, Check if all fabric dockers properly was deleted"
  docker rm -f $(docker ps -a | grep dev-peer1.farmer.example.com-and-policy-chaincode-0.0.1-* | awk '{print $1}') || echo "docker rm failed, Check if all fabric dockers properly was deleted"
  docker rmi $(docker images dev-peer1.farmer.example.com-and-policy-chaincode-0.0.1-* -q) || echo "docker rm failed, Check if all fabric dockers properly was deleted"
  docker rm -f $(docker ps -a | grep dev-peer0.auditor.example.com-and-policy-chaincode-0.0.1-* | awk '{print $1}') || echo "docker rm failed, Check if all fabric dockers properly was deleted"
  docker rmi $(docker images dev-peer0.auditor.example.com-and-policy-chaincode-0.0.1-* -q) || echo "docker rm failed, Check if all fabric dockers properly was deleted"
  docker rm -f $(docker ps -a | grep dev-peer1.auditor.example.com-and-policy-chaincode-0.0.1-* | awk '{print $1}') || echo "docker rm failed, Check if all fabric dockers properly was deleted"
  docker rmi $(docker images dev-peer1.auditor.example.com-and-policy-chaincode-0.0.1-* -q) || echo "docker rm failed, Check if all fabric dockers properly was deleted"
  docker rm -f $(docker ps -a | grep dev-peer0.transporter.example.com-and-policy-chaincode-0.0.1-* | awk '{print $1}') || echo "docker rm failed, Check if all fabric dockers properly was deleted"
  docker rmi $(docker images dev-peer0.transporter.example.com-and-policy-chaincode-0.0.1-* -q) || echo "docker rm failed, Check if all fabric dockers properly was deleted"
  docker rm -f $(docker ps -a | grep dev-peer1.transporter.example.com-and-policy-chaincode-0.0.1-* | awk '{print $1}') || echo "docker rm failed, Check if all fabric dockers properly was deleted"
  docker rmi $(docker images dev-peer1.transporter.example.com-and-policy-chaincode-0.0.1-* -q) || echo "docker rm failed, Check if all fabric dockers properly was deleted"

  printf "\nRemoving generated configs... \U1F5D1 \n"
  rm -rf "$FABLO_NETWORK_ROOT/fabric-config/config"
  rm -rf "$FABLO_NETWORK_ROOT/fabric-config/crypto-config"
  rm -rf "$FABLO_NETWORK_ROOT/fabric-config/chaincode-packages"

  printHeadline "Done! Network was purged" "U1F5D1"
}
