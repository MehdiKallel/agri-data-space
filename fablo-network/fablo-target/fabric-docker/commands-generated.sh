#!/usr/bin/env bash

generateArtifacts() {
  printHeadline "Generating basic configs" "U1F913"

  printItalics "Generating crypto material for Orderer" "U1F512"
  certsGenerate "$FABLO_NETWORK_ROOT/fabric-config" "crypto-config-orderer.yaml" "peerOrganizations/orderer.example.com" "$FABLO_NETWORK_ROOT/fabric-config/crypto-config/"

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
  printHeadline "Generating config for 'trackmeat-channel'" "U1F913"
  createChannelTx "trackmeat-channel" "$FABLO_NETWORK_ROOT/fabric-config" "TrackmeatChannel" "$FABLO_NETWORK_ROOT/fabric-config/config"
}

installChannels() {
  printHeadline "Creating 'trackmeat-channel' on FarmerOrg/peer0" "U1F63B"
  docker exec -i cli.farmer.example.com bash -c "source scripts/channel_fns.sh; createChannelAndJoinTls 'trackmeat-channel' 'FarmerOrgMSP' 'peer0.farmer.example.com:7041' 'crypto/users/Admin@farmer.example.com/msp' 'crypto/users/Admin@farmer.example.com/tls' 'crypto-orderer/tlsca.orderer.example.com-cert.pem' 'orderer0.group1.orderer.example.com:7030';"

  printItalics "Joining 'trackmeat-channel' on  FarmerOrg/peer1" "U1F638"
  docker exec -i cli.farmer.example.com bash -c "source scripts/channel_fns.sh; fetchChannelAndJoinTls 'trackmeat-channel' 'FarmerOrgMSP' 'peer1.farmer.example.com:7042' 'crypto/users/Admin@farmer.example.com/msp' 'crypto/users/Admin@farmer.example.com/tls' 'crypto-orderer/tlsca.orderer.example.com-cert.pem' 'orderer0.group1.orderer.example.com:7030';"
  printItalics "Joining 'trackmeat-channel' on  AuditorOrg/peer0" "U1F638"
  docker exec -i cli.auditor.example.com bash -c "source scripts/channel_fns.sh; fetchChannelAndJoinTls 'trackmeat-channel' 'AuditorOrgMSP' 'peer0.auditor.example.com:7061' 'crypto/users/Admin@auditor.example.com/msp' 'crypto/users/Admin@auditor.example.com/tls' 'crypto-orderer/tlsca.orderer.example.com-cert.pem' 'orderer0.group1.orderer.example.com:7030';"
  printItalics "Joining 'trackmeat-channel' on  AuditorOrg/peer1" "U1F638"
  docker exec -i cli.auditor.example.com bash -c "source scripts/channel_fns.sh; fetchChannelAndJoinTls 'trackmeat-channel' 'AuditorOrgMSP' 'peer1.auditor.example.com:7062' 'crypto/users/Admin@auditor.example.com/msp' 'crypto/users/Admin@auditor.example.com/tls' 'crypto-orderer/tlsca.orderer.example.com-cert.pem' 'orderer0.group1.orderer.example.com:7030';"
  printItalics "Joining 'trackmeat-channel' on  TransporterOrg/peer0" "U1F638"
  docker exec -i cli.transporter.example.com bash -c "source scripts/channel_fns.sh; fetchChannelAndJoinTls 'trackmeat-channel' 'TransporterOrgMSP' 'peer0.transporter.example.com:7081' 'crypto/users/Admin@transporter.example.com/msp' 'crypto/users/Admin@transporter.example.com/tls' 'crypto-orderer/tlsca.orderer.example.com-cert.pem' 'orderer0.group1.orderer.example.com:7030';"
  printItalics "Joining 'trackmeat-channel' on  TransporterOrg/peer1" "U1F638"
  docker exec -i cli.transporter.example.com bash -c "source scripts/channel_fns.sh; fetchChannelAndJoinTls 'trackmeat-channel' 'TransporterOrgMSP' 'peer1.transporter.example.com:7082' 'crypto/users/Admin@transporter.example.com/msp' 'crypto/users/Admin@transporter.example.com/tls' 'crypto-orderer/tlsca.orderer.example.com-cert.pem' 'orderer0.group1.orderer.example.com:7030';"
}

installChaincodes() {
  echo "No chaincodes"
}

notifyOrgsAboutChannels() {
  printHeadline "Creating new channel config blocks" "U1F537"
  createNewChannelUpdateTx "trackmeat-channel" "FarmerOrgMSP" "TrackmeatChannel" "$FABLO_NETWORK_ROOT/fabric-config" "$FABLO_NETWORK_ROOT/fabric-config/config"
  createNewChannelUpdateTx "trackmeat-channel" "AuditorOrgMSP" "TrackmeatChannel" "$FABLO_NETWORK_ROOT/fabric-config" "$FABLO_NETWORK_ROOT/fabric-config/config"
  createNewChannelUpdateTx "trackmeat-channel" "TransporterOrgMSP" "TrackmeatChannel" "$FABLO_NETWORK_ROOT/fabric-config" "$FABLO_NETWORK_ROOT/fabric-config/config"

  printHeadline "Notyfing orgs about channels" "U1F4E2"
  notifyOrgAboutNewChannelTls "trackmeat-channel" "FarmerOrgMSP" "cli.farmer.example.com" "peer0.farmer.example.com" "orderer0.group1.orderer.example.com:7030" "crypto-orderer/tlsca.orderer.example.com-cert.pem"
  notifyOrgAboutNewChannelTls "trackmeat-channel" "AuditorOrgMSP" "cli.auditor.example.com" "peer0.auditor.example.com" "orderer0.group1.orderer.example.com:7030" "crypto-orderer/tlsca.orderer.example.com-cert.pem"
  notifyOrgAboutNewChannelTls "trackmeat-channel" "TransporterOrgMSP" "cli.transporter.example.com" "peer0.transporter.example.com" "orderer0.group1.orderer.example.com:7030" "crypto-orderer/tlsca.orderer.example.com-cert.pem"

  printHeadline "Deleting new channel config blocks" "U1F52A"
  deleteNewChannelUpdateTx "trackmeat-channel" "FarmerOrgMSP" "cli.farmer.example.com"
  deleteNewChannelUpdateTx "trackmeat-channel" "AuditorOrgMSP" "cli.auditor.example.com"
  deleteNewChannelUpdateTx "trackmeat-channel" "TransporterOrgMSP" "cli.transporter.example.com"
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

  printf "\nRemoving generated configs... \U1F5D1 \n"
  rm -rf "$FABLO_NETWORK_ROOT/fabric-config/config"
  rm -rf "$FABLO_NETWORK_ROOT/fabric-config/crypto-config"
  rm -rf "$FABLO_NETWORK_ROOT/fabric-config/chaincode-packages"

  printHeadline "Done! Network was purged" "U1F5D1"
}
