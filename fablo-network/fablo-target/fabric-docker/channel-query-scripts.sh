#!/usr/bin/env bash

source "$FABLO_NETWORK_ROOT/fabric-docker/scripts/channel-query-functions.sh"

set -eu

channelQuery() {
  echo "-> Channel query: " + "$@"

  if [ "$#" -eq 1 ]; then
    printChannelsHelp

  elif [ "$1" = "list" ] && [ "$2" = "farmerorg" ] && [ "$3" = "peer0" ]; then

    peerChannelListTls "cli.farmer.example.com" "peer0.farmer.example.com:7041" "crypto-orderer/tlsca.orderer.example.com-cert.pem"

  elif
    [ "$1" = "list" ] && [ "$2" = "farmerorg" ] && [ "$3" = "peer1" ]
  then

    peerChannelListTls "cli.farmer.example.com" "peer1.farmer.example.com:7042" "crypto-orderer/tlsca.orderer.example.com-cert.pem"

  elif
    [ "$1" = "list" ] && [ "$2" = "auditororg" ] && [ "$3" = "peer0" ]
  then

    peerChannelListTls "cli.auditor.example.com" "peer0.auditor.example.com:7061" "crypto-orderer/tlsca.orderer.example.com-cert.pem"

  elif
    [ "$1" = "list" ] && [ "$2" = "auditororg" ] && [ "$3" = "peer1" ]
  then

    peerChannelListTls "cli.auditor.example.com" "peer1.auditor.example.com:7062" "crypto-orderer/tlsca.orderer.example.com-cert.pem"

  elif
    [ "$1" = "list" ] && [ "$2" = "transporterorg" ] && [ "$3" = "peer0" ]
  then

    peerChannelListTls "cli.transporter.example.com" "peer0.transporter.example.com:7081" "crypto-orderer/tlsca.orderer.example.com-cert.pem"

  elif
    [ "$1" = "list" ] && [ "$2" = "transporterorg" ] && [ "$3" = "peer1" ]
  then

    peerChannelListTls "cli.transporter.example.com" "peer1.transporter.example.com:7082" "crypto-orderer/tlsca.orderer.example.com-cert.pem"

  elif

    [ "$1" = "getinfo" ] && [ "$2" = "trackmeat-channel" ] && [ "$3" = "farmerorg" ] && [ "$4" = "peer0" ]
  then

    peerChannelGetInfoTls "trackmeat-channel" "cli.farmer.example.com" "peer0.farmer.example.com:7041" "crypto-orderer/tlsca.orderer.example.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "config" ] && [ "$3" = "trackmeat-channel" ] && [ "$4" = "farmerorg" ] && [ "$5" = "peer0" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchConfigTls "trackmeat-channel" "cli.farmer.example.com" "${FILE_NAME}" "peer0.farmer.example.com:7041" "crypto-orderer/tlsca.orderer.example.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "lastBlock" ] && [ "$3" = "trackmeat-channel" ] && [ "$4" = "farmerorg" ] && [ "$5" = "peer0" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchLastBlockTls "trackmeat-channel" "cli.farmer.example.com" "${FILE_NAME}" "peer0.farmer.example.com:7041" "crypto-orderer/tlsca.orderer.example.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "firstBlock" ] && [ "$3" = "trackmeat-channel" ] && [ "$4" = "farmerorg" ] && [ "$5" = "peer0" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchFirstBlockTls "trackmeat-channel" "cli.farmer.example.com" "${FILE_NAME}" "peer0.farmer.example.com:7041" "crypto-orderer/tlsca.orderer.example.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "block" ] && [ "$3" = "trackmeat-channel" ] && [ "$4" = "farmerorg" ] && [ "$5" = "peer0" ] && [ "$#" = 8 ]; then
    FILE_NAME=$6
    BLOCK_NUMBER=$7

    peerChannelFetchBlockTls "trackmeat-channel" "cli.farmer.example.com" "${FILE_NAME}" "${BLOCK_NUMBER}" "peer0.farmer.example.com:7041" "crypto-orderer/tlsca.orderer.example.com-cert.pem"

  elif
    [ "$1" = "getinfo" ] && [ "$2" = "trackmeat-channel" ] && [ "$3" = "farmerorg" ] && [ "$4" = "peer1" ]
  then

    peerChannelGetInfoTls "trackmeat-channel" "cli.farmer.example.com" "peer1.farmer.example.com:7042" "crypto-orderer/tlsca.orderer.example.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "config" ] && [ "$3" = "trackmeat-channel" ] && [ "$4" = "farmerorg" ] && [ "$5" = "peer1" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchConfigTls "trackmeat-channel" "cli.farmer.example.com" "${FILE_NAME}" "peer1.farmer.example.com:7042" "crypto-orderer/tlsca.orderer.example.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "lastBlock" ] && [ "$3" = "trackmeat-channel" ] && [ "$4" = "farmerorg" ] && [ "$5" = "peer1" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchLastBlockTls "trackmeat-channel" "cli.farmer.example.com" "${FILE_NAME}" "peer1.farmer.example.com:7042" "crypto-orderer/tlsca.orderer.example.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "firstBlock" ] && [ "$3" = "trackmeat-channel" ] && [ "$4" = "farmerorg" ] && [ "$5" = "peer1" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchFirstBlockTls "trackmeat-channel" "cli.farmer.example.com" "${FILE_NAME}" "peer1.farmer.example.com:7042" "crypto-orderer/tlsca.orderer.example.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "block" ] && [ "$3" = "trackmeat-channel" ] && [ "$4" = "farmerorg" ] && [ "$5" = "peer1" ] && [ "$#" = 8 ]; then
    FILE_NAME=$6
    BLOCK_NUMBER=$7

    peerChannelFetchBlockTls "trackmeat-channel" "cli.farmer.example.com" "${FILE_NAME}" "${BLOCK_NUMBER}" "peer1.farmer.example.com:7042" "crypto-orderer/tlsca.orderer.example.com-cert.pem"

  elif
    [ "$1" = "getinfo" ] && [ "$2" = "trackmeat-channel" ] && [ "$3" = "auditororg" ] && [ "$4" = "peer0" ]
  then

    peerChannelGetInfoTls "trackmeat-channel" "cli.auditor.example.com" "peer0.auditor.example.com:7061" "crypto-orderer/tlsca.orderer.example.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "config" ] && [ "$3" = "trackmeat-channel" ] && [ "$4" = "auditororg" ] && [ "$5" = "peer0" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchConfigTls "trackmeat-channel" "cli.auditor.example.com" "${FILE_NAME}" "peer0.auditor.example.com:7061" "crypto-orderer/tlsca.orderer.example.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "lastBlock" ] && [ "$3" = "trackmeat-channel" ] && [ "$4" = "auditororg" ] && [ "$5" = "peer0" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchLastBlockTls "trackmeat-channel" "cli.auditor.example.com" "${FILE_NAME}" "peer0.auditor.example.com:7061" "crypto-orderer/tlsca.orderer.example.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "firstBlock" ] && [ "$3" = "trackmeat-channel" ] && [ "$4" = "auditororg" ] && [ "$5" = "peer0" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchFirstBlockTls "trackmeat-channel" "cli.auditor.example.com" "${FILE_NAME}" "peer0.auditor.example.com:7061" "crypto-orderer/tlsca.orderer.example.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "block" ] && [ "$3" = "trackmeat-channel" ] && [ "$4" = "auditororg" ] && [ "$5" = "peer0" ] && [ "$#" = 8 ]; then
    FILE_NAME=$6
    BLOCK_NUMBER=$7

    peerChannelFetchBlockTls "trackmeat-channel" "cli.auditor.example.com" "${FILE_NAME}" "${BLOCK_NUMBER}" "peer0.auditor.example.com:7061" "crypto-orderer/tlsca.orderer.example.com-cert.pem"

  elif
    [ "$1" = "getinfo" ] && [ "$2" = "trackmeat-channel" ] && [ "$3" = "auditororg" ] && [ "$4" = "peer1" ]
  then

    peerChannelGetInfoTls "trackmeat-channel" "cli.auditor.example.com" "peer1.auditor.example.com:7062" "crypto-orderer/tlsca.orderer.example.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "config" ] && [ "$3" = "trackmeat-channel" ] && [ "$4" = "auditororg" ] && [ "$5" = "peer1" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchConfigTls "trackmeat-channel" "cli.auditor.example.com" "${FILE_NAME}" "peer1.auditor.example.com:7062" "crypto-orderer/tlsca.orderer.example.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "lastBlock" ] && [ "$3" = "trackmeat-channel" ] && [ "$4" = "auditororg" ] && [ "$5" = "peer1" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchLastBlockTls "trackmeat-channel" "cli.auditor.example.com" "${FILE_NAME}" "peer1.auditor.example.com:7062" "crypto-orderer/tlsca.orderer.example.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "firstBlock" ] && [ "$3" = "trackmeat-channel" ] && [ "$4" = "auditororg" ] && [ "$5" = "peer1" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchFirstBlockTls "trackmeat-channel" "cli.auditor.example.com" "${FILE_NAME}" "peer1.auditor.example.com:7062" "crypto-orderer/tlsca.orderer.example.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "block" ] && [ "$3" = "trackmeat-channel" ] && [ "$4" = "auditororg" ] && [ "$5" = "peer1" ] && [ "$#" = 8 ]; then
    FILE_NAME=$6
    BLOCK_NUMBER=$7

    peerChannelFetchBlockTls "trackmeat-channel" "cli.auditor.example.com" "${FILE_NAME}" "${BLOCK_NUMBER}" "peer1.auditor.example.com:7062" "crypto-orderer/tlsca.orderer.example.com-cert.pem"

  elif
    [ "$1" = "getinfo" ] && [ "$2" = "trackmeat-channel" ] && [ "$3" = "transporterorg" ] && [ "$4" = "peer0" ]
  then

    peerChannelGetInfoTls "trackmeat-channel" "cli.transporter.example.com" "peer0.transporter.example.com:7081" "crypto-orderer/tlsca.orderer.example.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "config" ] && [ "$3" = "trackmeat-channel" ] && [ "$4" = "transporterorg" ] && [ "$5" = "peer0" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchConfigTls "trackmeat-channel" "cli.transporter.example.com" "${FILE_NAME}" "peer0.transporter.example.com:7081" "crypto-orderer/tlsca.orderer.example.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "lastBlock" ] && [ "$3" = "trackmeat-channel" ] && [ "$4" = "transporterorg" ] && [ "$5" = "peer0" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchLastBlockTls "trackmeat-channel" "cli.transporter.example.com" "${FILE_NAME}" "peer0.transporter.example.com:7081" "crypto-orderer/tlsca.orderer.example.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "firstBlock" ] && [ "$3" = "trackmeat-channel" ] && [ "$4" = "transporterorg" ] && [ "$5" = "peer0" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchFirstBlockTls "trackmeat-channel" "cli.transporter.example.com" "${FILE_NAME}" "peer0.transporter.example.com:7081" "crypto-orderer/tlsca.orderer.example.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "block" ] && [ "$3" = "trackmeat-channel" ] && [ "$4" = "transporterorg" ] && [ "$5" = "peer0" ] && [ "$#" = 8 ]; then
    FILE_NAME=$6
    BLOCK_NUMBER=$7

    peerChannelFetchBlockTls "trackmeat-channel" "cli.transporter.example.com" "${FILE_NAME}" "${BLOCK_NUMBER}" "peer0.transporter.example.com:7081" "crypto-orderer/tlsca.orderer.example.com-cert.pem"

  elif
    [ "$1" = "getinfo" ] && [ "$2" = "trackmeat-channel" ] && [ "$3" = "transporterorg" ] && [ "$4" = "peer1" ]
  then

    peerChannelGetInfoTls "trackmeat-channel" "cli.transporter.example.com" "peer1.transporter.example.com:7082" "crypto-orderer/tlsca.orderer.example.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "config" ] && [ "$3" = "trackmeat-channel" ] && [ "$4" = "transporterorg" ] && [ "$5" = "peer1" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchConfigTls "trackmeat-channel" "cli.transporter.example.com" "${FILE_NAME}" "peer1.transporter.example.com:7082" "crypto-orderer/tlsca.orderer.example.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "lastBlock" ] && [ "$3" = "trackmeat-channel" ] && [ "$4" = "transporterorg" ] && [ "$5" = "peer1" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchLastBlockTls "trackmeat-channel" "cli.transporter.example.com" "${FILE_NAME}" "peer1.transporter.example.com:7082" "crypto-orderer/tlsca.orderer.example.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "firstBlock" ] && [ "$3" = "trackmeat-channel" ] && [ "$4" = "transporterorg" ] && [ "$5" = "peer1" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchFirstBlockTls "trackmeat-channel" "cli.transporter.example.com" "${FILE_NAME}" "peer1.transporter.example.com:7082" "crypto-orderer/tlsca.orderer.example.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "block" ] && [ "$3" = "trackmeat-channel" ] && [ "$4" = "transporterorg" ] && [ "$5" = "peer1" ] && [ "$#" = 8 ]; then
    FILE_NAME=$6
    BLOCK_NUMBER=$7

    peerChannelFetchBlockTls "trackmeat-channel" "cli.transporter.example.com" "${FILE_NAME}" "${BLOCK_NUMBER}" "peer1.transporter.example.com:7082" "crypto-orderer/tlsca.orderer.example.com-cert.pem"

  else

    printChannelsHelp
  fi

}

printChannelsHelp() {
  echo "Channel management commands:"
  echo ""

  echo "fablo channel list farmerorg peer0"
  echo -e "\t List channels on 'peer0' of 'FarmerOrg'".
  echo ""

  echo "fablo channel list farmerorg peer1"
  echo -e "\t List channels on 'peer1' of 'FarmerOrg'".
  echo ""

  echo "fablo channel list auditororg peer0"
  echo -e "\t List channels on 'peer0' of 'AuditorOrg'".
  echo ""

  echo "fablo channel list auditororg peer1"
  echo -e "\t List channels on 'peer1' of 'AuditorOrg'".
  echo ""

  echo "fablo channel list transporterorg peer0"
  echo -e "\t List channels on 'peer0' of 'TransporterOrg'".
  echo ""

  echo "fablo channel list transporterorg peer1"
  echo -e "\t List channels on 'peer1' of 'TransporterOrg'".
  echo ""

  echo "fablo channel getinfo trackmeat-channel farmerorg peer0"
  echo -e "\t Get channel info on 'peer0' of 'FarmerOrg'".
  echo ""
  echo "fablo channel fetch config trackmeat-channel farmerorg peer0 <fileName.json>"
  echo -e "\t Download latest config block to current dir. Uses first peer 'peer0' of 'FarmerOrg'".
  echo ""
  echo "fablo channel fetch lastBlock trackmeat-channel farmerorg peer0 <fileName.json>"
  echo -e "\t Download last, decrypted block to current dir. Uses first peer 'peer0' of 'FarmerOrg'".
  echo ""
  echo "fablo channel fetch firstBlock trackmeat-channel farmerorg peer0 <fileName.json>"
  echo -e "\t Download first, decrypted block to current dir. Uses first peer 'peer0' of 'FarmerOrg'".
  echo ""

  echo "fablo channel getinfo trackmeat-channel farmerorg peer1"
  echo -e "\t Get channel info on 'peer1' of 'FarmerOrg'".
  echo ""
  echo "fablo channel fetch config trackmeat-channel farmerorg peer1 <fileName.json>"
  echo -e "\t Download latest config block to current dir. Uses first peer 'peer1' of 'FarmerOrg'".
  echo ""
  echo "fablo channel fetch lastBlock trackmeat-channel farmerorg peer1 <fileName.json>"
  echo -e "\t Download last, decrypted block to current dir. Uses first peer 'peer1' of 'FarmerOrg'".
  echo ""
  echo "fablo channel fetch firstBlock trackmeat-channel farmerorg peer1 <fileName.json>"
  echo -e "\t Download first, decrypted block to current dir. Uses first peer 'peer1' of 'FarmerOrg'".
  echo ""

  echo "fablo channel getinfo trackmeat-channel auditororg peer0"
  echo -e "\t Get channel info on 'peer0' of 'AuditorOrg'".
  echo ""
  echo "fablo channel fetch config trackmeat-channel auditororg peer0 <fileName.json>"
  echo -e "\t Download latest config block to current dir. Uses first peer 'peer0' of 'AuditorOrg'".
  echo ""
  echo "fablo channel fetch lastBlock trackmeat-channel auditororg peer0 <fileName.json>"
  echo -e "\t Download last, decrypted block to current dir. Uses first peer 'peer0' of 'AuditorOrg'".
  echo ""
  echo "fablo channel fetch firstBlock trackmeat-channel auditororg peer0 <fileName.json>"
  echo -e "\t Download first, decrypted block to current dir. Uses first peer 'peer0' of 'AuditorOrg'".
  echo ""

  echo "fablo channel getinfo trackmeat-channel auditororg peer1"
  echo -e "\t Get channel info on 'peer1' of 'AuditorOrg'".
  echo ""
  echo "fablo channel fetch config trackmeat-channel auditororg peer1 <fileName.json>"
  echo -e "\t Download latest config block to current dir. Uses first peer 'peer1' of 'AuditorOrg'".
  echo ""
  echo "fablo channel fetch lastBlock trackmeat-channel auditororg peer1 <fileName.json>"
  echo -e "\t Download last, decrypted block to current dir. Uses first peer 'peer1' of 'AuditorOrg'".
  echo ""
  echo "fablo channel fetch firstBlock trackmeat-channel auditororg peer1 <fileName.json>"
  echo -e "\t Download first, decrypted block to current dir. Uses first peer 'peer1' of 'AuditorOrg'".
  echo ""

  echo "fablo channel getinfo trackmeat-channel transporterorg peer0"
  echo -e "\t Get channel info on 'peer0' of 'TransporterOrg'".
  echo ""
  echo "fablo channel fetch config trackmeat-channel transporterorg peer0 <fileName.json>"
  echo -e "\t Download latest config block to current dir. Uses first peer 'peer0' of 'TransporterOrg'".
  echo ""
  echo "fablo channel fetch lastBlock trackmeat-channel transporterorg peer0 <fileName.json>"
  echo -e "\t Download last, decrypted block to current dir. Uses first peer 'peer0' of 'TransporterOrg'".
  echo ""
  echo "fablo channel fetch firstBlock trackmeat-channel transporterorg peer0 <fileName.json>"
  echo -e "\t Download first, decrypted block to current dir. Uses first peer 'peer0' of 'TransporterOrg'".
  echo ""

  echo "fablo channel getinfo trackmeat-channel transporterorg peer1"
  echo -e "\t Get channel info on 'peer1' of 'TransporterOrg'".
  echo ""
  echo "fablo channel fetch config trackmeat-channel transporterorg peer1 <fileName.json>"
  echo -e "\t Download latest config block to current dir. Uses first peer 'peer1' of 'TransporterOrg'".
  echo ""
  echo "fablo channel fetch lastBlock trackmeat-channel transporterorg peer1 <fileName.json>"
  echo -e "\t Download last, decrypted block to current dir. Uses first peer 'peer1' of 'TransporterOrg'".
  echo ""
  echo "fablo channel fetch firstBlock trackmeat-channel transporterorg peer1 <fileName.json>"
  echo -e "\t Download first, decrypted block to current dir. Uses first peer 'peer1' of 'TransporterOrg'".
  echo ""

}
