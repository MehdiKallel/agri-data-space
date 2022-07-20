#!/usr/bin/env bash

source "$FABLO_NETWORK_ROOT/fabric-docker/scripts/channel-query-functions.sh"

set -eu

channelQuery() {
  echo "-> Channel query: " + "$@"

  if [ "$#" -eq 1 ]; then
    printChannelsHelp

  elif [ "$1" = "list" ] && [ "$2" = "farmerorg" ] && [ "$3" = "peer0" ]; then

    peerChannelList "cli.farmer.example.com" "peer0.farmer.example.com:7041"

  elif
    [ "$1" = "list" ] && [ "$2" = "farmerorg" ] && [ "$3" = "peer1" ]
  then

    peerChannelList "cli.farmer.example.com" "peer1.farmer.example.com:7042"

  elif
    [ "$1" = "list" ] && [ "$2" = "auditororg" ] && [ "$3" = "peer0" ]
  then

    peerChannelList "cli.auditor.example.com" "peer0.auditor.example.com:7061"

  elif
    [ "$1" = "list" ] && [ "$2" = "auditororg" ] && [ "$3" = "peer1" ]
  then

    peerChannelList "cli.auditor.example.com" "peer1.auditor.example.com:7062"

  elif
    [ "$1" = "list" ] && [ "$2" = "transporterorg" ] && [ "$3" = "peer0" ]
  then

    peerChannelList "cli.transporter.example.com" "peer0.transporter.example.com:7081"

  elif
    [ "$1" = "list" ] && [ "$2" = "transporterorg" ] && [ "$3" = "peer1" ]
  then

    peerChannelList "cli.transporter.example.com" "peer1.transporter.example.com:7082"

  elif

    [ "$1" = "getinfo" ] && [ "$2" = "mychannel" ] && [ "$3" = "farmerorg" ] && [ "$4" = "peer0" ]
  then

    peerChannelGetInfo "mychannel" "cli.farmer.example.com" "peer0.farmer.example.com:7041"

  elif [ "$1" = "fetch" ] && [ "$2" = "config" ] && [ "$3" = "mychannel" ] && [ "$4" = "farmerorg" ] && [ "$5" = "peer0" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchConfig "mychannel" "cli.farmer.example.com" "${FILE_NAME}" "peer0.farmer.example.com:7041"

  elif [ "$1" = "fetch" ] && [ "$2" = "lastBlock" ] && [ "$3" = "mychannel" ] && [ "$4" = "farmerorg" ] && [ "$5" = "peer0" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchLastBlock "mychannel" "cli.farmer.example.com" "${FILE_NAME}" "peer0.farmer.example.com:7041"

  elif [ "$1" = "fetch" ] && [ "$2" = "firstBlock" ] && [ "$3" = "mychannel" ] && [ "$4" = "farmerorg" ] && [ "$5" = "peer0" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchFirstBlock "mychannel" "cli.farmer.example.com" "${FILE_NAME}" "peer0.farmer.example.com:7041"

  elif [ "$1" = "fetch" ] && [ "$2" = "block" ] && [ "$3" = "mychannel" ] && [ "$4" = "farmerorg" ] && [ "$5" = "peer0" ] && [ "$#" = 8 ]; then
    FILE_NAME=$6
    BLOCK_NUMBER=$7

    peerChannelFetchBlock "mychannel" "cli.farmer.example.com" "${FILE_NAME}" "${BLOCK_NUMBER}" "peer0.farmer.example.com:7041"

  elif
    [ "$1" = "getinfo" ] && [ "$2" = "mychannel" ] && [ "$3" = "farmerorg" ] && [ "$4" = "peer1" ]
  then

    peerChannelGetInfo "mychannel" "cli.farmer.example.com" "peer1.farmer.example.com:7042"

  elif [ "$1" = "fetch" ] && [ "$2" = "config" ] && [ "$3" = "mychannel" ] && [ "$4" = "farmerorg" ] && [ "$5" = "peer1" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchConfig "mychannel" "cli.farmer.example.com" "${FILE_NAME}" "peer1.farmer.example.com:7042"

  elif [ "$1" = "fetch" ] && [ "$2" = "lastBlock" ] && [ "$3" = "mychannel" ] && [ "$4" = "farmerorg" ] && [ "$5" = "peer1" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchLastBlock "mychannel" "cli.farmer.example.com" "${FILE_NAME}" "peer1.farmer.example.com:7042"

  elif [ "$1" = "fetch" ] && [ "$2" = "firstBlock" ] && [ "$3" = "mychannel" ] && [ "$4" = "farmerorg" ] && [ "$5" = "peer1" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchFirstBlock "mychannel" "cli.farmer.example.com" "${FILE_NAME}" "peer1.farmer.example.com:7042"

  elif [ "$1" = "fetch" ] && [ "$2" = "block" ] && [ "$3" = "mychannel" ] && [ "$4" = "farmerorg" ] && [ "$5" = "peer1" ] && [ "$#" = 8 ]; then
    FILE_NAME=$6
    BLOCK_NUMBER=$7

    peerChannelFetchBlock "mychannel" "cli.farmer.example.com" "${FILE_NAME}" "${BLOCK_NUMBER}" "peer1.farmer.example.com:7042"

  elif
    [ "$1" = "getinfo" ] && [ "$2" = "mychannel" ] && [ "$3" = "auditororg" ] && [ "$4" = "peer0" ]
  then

    peerChannelGetInfo "mychannel" "cli.auditor.example.com" "peer0.auditor.example.com:7061"

  elif [ "$1" = "fetch" ] && [ "$2" = "config" ] && [ "$3" = "mychannel" ] && [ "$4" = "auditororg" ] && [ "$5" = "peer0" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchConfig "mychannel" "cli.auditor.example.com" "${FILE_NAME}" "peer0.auditor.example.com:7061"

  elif [ "$1" = "fetch" ] && [ "$2" = "lastBlock" ] && [ "$3" = "mychannel" ] && [ "$4" = "auditororg" ] && [ "$5" = "peer0" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchLastBlock "mychannel" "cli.auditor.example.com" "${FILE_NAME}" "peer0.auditor.example.com:7061"

  elif [ "$1" = "fetch" ] && [ "$2" = "firstBlock" ] && [ "$3" = "mychannel" ] && [ "$4" = "auditororg" ] && [ "$5" = "peer0" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchFirstBlock "mychannel" "cli.auditor.example.com" "${FILE_NAME}" "peer0.auditor.example.com:7061"

  elif [ "$1" = "fetch" ] && [ "$2" = "block" ] && [ "$3" = "mychannel" ] && [ "$4" = "auditororg" ] && [ "$5" = "peer0" ] && [ "$#" = 8 ]; then
    FILE_NAME=$6
    BLOCK_NUMBER=$7

    peerChannelFetchBlock "mychannel" "cli.auditor.example.com" "${FILE_NAME}" "${BLOCK_NUMBER}" "peer0.auditor.example.com:7061"

  elif
    [ "$1" = "getinfo" ] && [ "$2" = "mychannel" ] && [ "$3" = "auditororg" ] && [ "$4" = "peer1" ]
  then

    peerChannelGetInfo "mychannel" "cli.auditor.example.com" "peer1.auditor.example.com:7062"

  elif [ "$1" = "fetch" ] && [ "$2" = "config" ] && [ "$3" = "mychannel" ] && [ "$4" = "auditororg" ] && [ "$5" = "peer1" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchConfig "mychannel" "cli.auditor.example.com" "${FILE_NAME}" "peer1.auditor.example.com:7062"

  elif [ "$1" = "fetch" ] && [ "$2" = "lastBlock" ] && [ "$3" = "mychannel" ] && [ "$4" = "auditororg" ] && [ "$5" = "peer1" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchLastBlock "mychannel" "cli.auditor.example.com" "${FILE_NAME}" "peer1.auditor.example.com:7062"

  elif [ "$1" = "fetch" ] && [ "$2" = "firstBlock" ] && [ "$3" = "mychannel" ] && [ "$4" = "auditororg" ] && [ "$5" = "peer1" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchFirstBlock "mychannel" "cli.auditor.example.com" "${FILE_NAME}" "peer1.auditor.example.com:7062"

  elif [ "$1" = "fetch" ] && [ "$2" = "block" ] && [ "$3" = "mychannel" ] && [ "$4" = "auditororg" ] && [ "$5" = "peer1" ] && [ "$#" = 8 ]; then
    FILE_NAME=$6
    BLOCK_NUMBER=$7

    peerChannelFetchBlock "mychannel" "cli.auditor.example.com" "${FILE_NAME}" "${BLOCK_NUMBER}" "peer1.auditor.example.com:7062"

  elif
    [ "$1" = "getinfo" ] && [ "$2" = "mychannel" ] && [ "$3" = "transporterorg" ] && [ "$4" = "peer0" ]
  then

    peerChannelGetInfo "mychannel" "cli.transporter.example.com" "peer0.transporter.example.com:7081"

  elif [ "$1" = "fetch" ] && [ "$2" = "config" ] && [ "$3" = "mychannel" ] && [ "$4" = "transporterorg" ] && [ "$5" = "peer0" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchConfig "mychannel" "cli.transporter.example.com" "${FILE_NAME}" "peer0.transporter.example.com:7081"

  elif [ "$1" = "fetch" ] && [ "$2" = "lastBlock" ] && [ "$3" = "mychannel" ] && [ "$4" = "transporterorg" ] && [ "$5" = "peer0" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchLastBlock "mychannel" "cli.transporter.example.com" "${FILE_NAME}" "peer0.transporter.example.com:7081"

  elif [ "$1" = "fetch" ] && [ "$2" = "firstBlock" ] && [ "$3" = "mychannel" ] && [ "$4" = "transporterorg" ] && [ "$5" = "peer0" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchFirstBlock "mychannel" "cli.transporter.example.com" "${FILE_NAME}" "peer0.transporter.example.com:7081"

  elif [ "$1" = "fetch" ] && [ "$2" = "block" ] && [ "$3" = "mychannel" ] && [ "$4" = "transporterorg" ] && [ "$5" = "peer0" ] && [ "$#" = 8 ]; then
    FILE_NAME=$6
    BLOCK_NUMBER=$7

    peerChannelFetchBlock "mychannel" "cli.transporter.example.com" "${FILE_NAME}" "${BLOCK_NUMBER}" "peer0.transporter.example.com:7081"

  elif
    [ "$1" = "getinfo" ] && [ "$2" = "mychannel" ] && [ "$3" = "transporterorg" ] && [ "$4" = "peer1" ]
  then

    peerChannelGetInfo "mychannel" "cli.transporter.example.com" "peer1.transporter.example.com:7082"

  elif [ "$1" = "fetch" ] && [ "$2" = "config" ] && [ "$3" = "mychannel" ] && [ "$4" = "transporterorg" ] && [ "$5" = "peer1" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchConfig "mychannel" "cli.transporter.example.com" "${FILE_NAME}" "peer1.transporter.example.com:7082"

  elif [ "$1" = "fetch" ] && [ "$2" = "lastBlock" ] && [ "$3" = "mychannel" ] && [ "$4" = "transporterorg" ] && [ "$5" = "peer1" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchLastBlock "mychannel" "cli.transporter.example.com" "${FILE_NAME}" "peer1.transporter.example.com:7082"

  elif [ "$1" = "fetch" ] && [ "$2" = "firstBlock" ] && [ "$3" = "mychannel" ] && [ "$4" = "transporterorg" ] && [ "$5" = "peer1" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchFirstBlock "mychannel" "cli.transporter.example.com" "${FILE_NAME}" "peer1.transporter.example.com:7082"

  elif [ "$1" = "fetch" ] && [ "$2" = "block" ] && [ "$3" = "mychannel" ] && [ "$4" = "transporterorg" ] && [ "$5" = "peer1" ] && [ "$#" = 8 ]; then
    FILE_NAME=$6
    BLOCK_NUMBER=$7

    peerChannelFetchBlock "mychannel" "cli.transporter.example.com" "${FILE_NAME}" "${BLOCK_NUMBER}" "peer1.transporter.example.com:7082"

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

  echo "fablo channel getinfo mychannel farmerorg peer0"
  echo -e "\t Get channel info on 'peer0' of 'FarmerOrg'".
  echo ""
  echo "fablo channel fetch config mychannel farmerorg peer0 <fileName.json>"
  echo -e "\t Download latest config block to current dir. Uses first peer 'peer0' of 'FarmerOrg'".
  echo ""
  echo "fablo channel fetch lastBlock mychannel farmerorg peer0 <fileName.json>"
  echo -e "\t Download last, decrypted block to current dir. Uses first peer 'peer0' of 'FarmerOrg'".
  echo ""
  echo "fablo channel fetch firstBlock mychannel farmerorg peer0 <fileName.json>"
  echo -e "\t Download first, decrypted block to current dir. Uses first peer 'peer0' of 'FarmerOrg'".
  echo ""

  echo "fablo channel getinfo mychannel farmerorg peer1"
  echo -e "\t Get channel info on 'peer1' of 'FarmerOrg'".
  echo ""
  echo "fablo channel fetch config mychannel farmerorg peer1 <fileName.json>"
  echo -e "\t Download latest config block to current dir. Uses first peer 'peer1' of 'FarmerOrg'".
  echo ""
  echo "fablo channel fetch lastBlock mychannel farmerorg peer1 <fileName.json>"
  echo -e "\t Download last, decrypted block to current dir. Uses first peer 'peer1' of 'FarmerOrg'".
  echo ""
  echo "fablo channel fetch firstBlock mychannel farmerorg peer1 <fileName.json>"
  echo -e "\t Download first, decrypted block to current dir. Uses first peer 'peer1' of 'FarmerOrg'".
  echo ""

  echo "fablo channel getinfo mychannel auditororg peer0"
  echo -e "\t Get channel info on 'peer0' of 'AuditorOrg'".
  echo ""
  echo "fablo channel fetch config mychannel auditororg peer0 <fileName.json>"
  echo -e "\t Download latest config block to current dir. Uses first peer 'peer0' of 'AuditorOrg'".
  echo ""
  echo "fablo channel fetch lastBlock mychannel auditororg peer0 <fileName.json>"
  echo -e "\t Download last, decrypted block to current dir. Uses first peer 'peer0' of 'AuditorOrg'".
  echo ""
  echo "fablo channel fetch firstBlock mychannel auditororg peer0 <fileName.json>"
  echo -e "\t Download first, decrypted block to current dir. Uses first peer 'peer0' of 'AuditorOrg'".
  echo ""

  echo "fablo channel getinfo mychannel auditororg peer1"
  echo -e "\t Get channel info on 'peer1' of 'AuditorOrg'".
  echo ""
  echo "fablo channel fetch config mychannel auditororg peer1 <fileName.json>"
  echo -e "\t Download latest config block to current dir. Uses first peer 'peer1' of 'AuditorOrg'".
  echo ""
  echo "fablo channel fetch lastBlock mychannel auditororg peer1 <fileName.json>"
  echo -e "\t Download last, decrypted block to current dir. Uses first peer 'peer1' of 'AuditorOrg'".
  echo ""
  echo "fablo channel fetch firstBlock mychannel auditororg peer1 <fileName.json>"
  echo -e "\t Download first, decrypted block to current dir. Uses first peer 'peer1' of 'AuditorOrg'".
  echo ""

  echo "fablo channel getinfo mychannel transporterorg peer0"
  echo -e "\t Get channel info on 'peer0' of 'TransporterOrg'".
  echo ""
  echo "fablo channel fetch config mychannel transporterorg peer0 <fileName.json>"
  echo -e "\t Download latest config block to current dir. Uses first peer 'peer0' of 'TransporterOrg'".
  echo ""
  echo "fablo channel fetch lastBlock mychannel transporterorg peer0 <fileName.json>"
  echo -e "\t Download last, decrypted block to current dir. Uses first peer 'peer0' of 'TransporterOrg'".
  echo ""
  echo "fablo channel fetch firstBlock mychannel transporterorg peer0 <fileName.json>"
  echo -e "\t Download first, decrypted block to current dir. Uses first peer 'peer0' of 'TransporterOrg'".
  echo ""

  echo "fablo channel getinfo mychannel transporterorg peer1"
  echo -e "\t Get channel info on 'peer1' of 'TransporterOrg'".
  echo ""
  echo "fablo channel fetch config mychannel transporterorg peer1 <fileName.json>"
  echo -e "\t Download latest config block to current dir. Uses first peer 'peer1' of 'TransporterOrg'".
  echo ""
  echo "fablo channel fetch lastBlock mychannel transporterorg peer1 <fileName.json>"
  echo -e "\t Download last, decrypted block to current dir. Uses first peer 'peer1' of 'TransporterOrg'".
  echo ""
  echo "fablo channel fetch firstBlock mychannel transporterorg peer1 <fileName.json>"
  echo -e "\t Download first, decrypted block to current dir. Uses first peer 'peer1' of 'TransporterOrg'".
  echo ""

}
