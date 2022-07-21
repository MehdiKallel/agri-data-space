#!/usr/bin/env bash

source "$FABLO_NETWORK_ROOT/fabric-docker/scripts/channel-query-functions.sh"

set -eu

channelQuery() {
  echo "-> Channel query: " + "$@"

  if [ "$#" -eq 1 ]; then
    printChannelsHelp

  elif [ "$1" = "list" ] && [ "$2" = "farmer" ] && [ "$3" = "peer0" ]; then

    peerChannelListTls "cli.farmer.example.com" "peer0.farmer.example.com:7041" "crypto-orderer/tlsca.root.com-cert.pem"

  elif
    [ "$1" = "list" ] && [ "$2" = "farmer" ] && [ "$3" = "peer1" ]
  then

    peerChannelListTls "cli.farmer.example.com" "peer1.farmer.example.com:7042" "crypto-orderer/tlsca.root.com-cert.pem"

  elif
    [ "$1" = "list" ] && [ "$2" = "auditor" ] && [ "$3" = "peer0" ]
  then

    peerChannelListTls "cli.auditor.example.com" "peer0.auditor.example.com:7061" "crypto-orderer/tlsca.root.com-cert.pem"

  elif
    [ "$1" = "list" ] && [ "$2" = "auditor" ] && [ "$3" = "peer1" ]
  then

    peerChannelListTls "cli.auditor.example.com" "peer1.auditor.example.com:7062" "crypto-orderer/tlsca.root.com-cert.pem"

  elif
    [ "$1" = "list" ] && [ "$2" = "transporter" ] && [ "$3" = "peer0" ]
  then

    peerChannelListTls "cli.transporter.example.com" "peer0.transporter.example.com:7081" "crypto-orderer/tlsca.root.com-cert.pem"

  elif
    [ "$1" = "list" ] && [ "$2" = "transporter" ] && [ "$3" = "peer1" ]
  then

    peerChannelListTls "cli.transporter.example.com" "peer1.transporter.example.com:7082" "crypto-orderer/tlsca.root.com-cert.pem"

  elif

    [ "$1" = "getinfo" ] && [ "$2" = "agridata" ] && [ "$3" = "farmer" ] && [ "$4" = "peer0" ]
  then

    peerChannelGetInfoTls "agridata" "cli.farmer.example.com" "peer0.farmer.example.com:7041" "crypto-orderer/tlsca.root.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "config" ] && [ "$3" = "agridata" ] && [ "$4" = "farmer" ] && [ "$5" = "peer0" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchConfigTls "agridata" "cli.farmer.example.com" "${FILE_NAME}" "peer0.farmer.example.com:7041" "crypto-orderer/tlsca.root.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "lastBlock" ] && [ "$3" = "agridata" ] && [ "$4" = "farmer" ] && [ "$5" = "peer0" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchLastBlockTls "agridata" "cli.farmer.example.com" "${FILE_NAME}" "peer0.farmer.example.com:7041" "crypto-orderer/tlsca.root.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "firstBlock" ] && [ "$3" = "agridata" ] && [ "$4" = "farmer" ] && [ "$5" = "peer0" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchFirstBlockTls "agridata" "cli.farmer.example.com" "${FILE_NAME}" "peer0.farmer.example.com:7041" "crypto-orderer/tlsca.root.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "block" ] && [ "$3" = "agridata" ] && [ "$4" = "farmer" ] && [ "$5" = "peer0" ] && [ "$#" = 8 ]; then
    FILE_NAME=$6
    BLOCK_NUMBER=$7

    peerChannelFetchBlockTls "agridata" "cli.farmer.example.com" "${FILE_NAME}" "${BLOCK_NUMBER}" "peer0.farmer.example.com:7041" "crypto-orderer/tlsca.root.com-cert.pem"

  elif
    [ "$1" = "getinfo" ] && [ "$2" = "agridata" ] && [ "$3" = "farmer" ] && [ "$4" = "peer1" ]
  then

    peerChannelGetInfoTls "agridata" "cli.farmer.example.com" "peer1.farmer.example.com:7042" "crypto-orderer/tlsca.root.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "config" ] && [ "$3" = "agridata" ] && [ "$4" = "farmer" ] && [ "$5" = "peer1" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchConfigTls "agridata" "cli.farmer.example.com" "${FILE_NAME}" "peer1.farmer.example.com:7042" "crypto-orderer/tlsca.root.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "lastBlock" ] && [ "$3" = "agridata" ] && [ "$4" = "farmer" ] && [ "$5" = "peer1" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchLastBlockTls "agridata" "cli.farmer.example.com" "${FILE_NAME}" "peer1.farmer.example.com:7042" "crypto-orderer/tlsca.root.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "firstBlock" ] && [ "$3" = "agridata" ] && [ "$4" = "farmer" ] && [ "$5" = "peer1" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchFirstBlockTls "agridata" "cli.farmer.example.com" "${FILE_NAME}" "peer1.farmer.example.com:7042" "crypto-orderer/tlsca.root.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "block" ] && [ "$3" = "agridata" ] && [ "$4" = "farmer" ] && [ "$5" = "peer1" ] && [ "$#" = 8 ]; then
    FILE_NAME=$6
    BLOCK_NUMBER=$7

    peerChannelFetchBlockTls "agridata" "cli.farmer.example.com" "${FILE_NAME}" "${BLOCK_NUMBER}" "peer1.farmer.example.com:7042" "crypto-orderer/tlsca.root.com-cert.pem"

  elif
    [ "$1" = "getinfo" ] && [ "$2" = "agridata" ] && [ "$3" = "auditor" ] && [ "$4" = "peer0" ]
  then

    peerChannelGetInfoTls "agridata" "cli.auditor.example.com" "peer0.auditor.example.com:7061" "crypto-orderer/tlsca.root.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "config" ] && [ "$3" = "agridata" ] && [ "$4" = "auditor" ] && [ "$5" = "peer0" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchConfigTls "agridata" "cli.auditor.example.com" "${FILE_NAME}" "peer0.auditor.example.com:7061" "crypto-orderer/tlsca.root.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "lastBlock" ] && [ "$3" = "agridata" ] && [ "$4" = "auditor" ] && [ "$5" = "peer0" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchLastBlockTls "agridata" "cli.auditor.example.com" "${FILE_NAME}" "peer0.auditor.example.com:7061" "crypto-orderer/tlsca.root.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "firstBlock" ] && [ "$3" = "agridata" ] && [ "$4" = "auditor" ] && [ "$5" = "peer0" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchFirstBlockTls "agridata" "cli.auditor.example.com" "${FILE_NAME}" "peer0.auditor.example.com:7061" "crypto-orderer/tlsca.root.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "block" ] && [ "$3" = "agridata" ] && [ "$4" = "auditor" ] && [ "$5" = "peer0" ] && [ "$#" = 8 ]; then
    FILE_NAME=$6
    BLOCK_NUMBER=$7

    peerChannelFetchBlockTls "agridata" "cli.auditor.example.com" "${FILE_NAME}" "${BLOCK_NUMBER}" "peer0.auditor.example.com:7061" "crypto-orderer/tlsca.root.com-cert.pem"

  elif
    [ "$1" = "getinfo" ] && [ "$2" = "agridata" ] && [ "$3" = "auditor" ] && [ "$4" = "peer1" ]
  then

    peerChannelGetInfoTls "agridata" "cli.auditor.example.com" "peer1.auditor.example.com:7062" "crypto-orderer/tlsca.root.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "config" ] && [ "$3" = "agridata" ] && [ "$4" = "auditor" ] && [ "$5" = "peer1" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchConfigTls "agridata" "cli.auditor.example.com" "${FILE_NAME}" "peer1.auditor.example.com:7062" "crypto-orderer/tlsca.root.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "lastBlock" ] && [ "$3" = "agridata" ] && [ "$4" = "auditor" ] && [ "$5" = "peer1" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchLastBlockTls "agridata" "cli.auditor.example.com" "${FILE_NAME}" "peer1.auditor.example.com:7062" "crypto-orderer/tlsca.root.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "firstBlock" ] && [ "$3" = "agridata" ] && [ "$4" = "auditor" ] && [ "$5" = "peer1" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchFirstBlockTls "agridata" "cli.auditor.example.com" "${FILE_NAME}" "peer1.auditor.example.com:7062" "crypto-orderer/tlsca.root.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "block" ] && [ "$3" = "agridata" ] && [ "$4" = "auditor" ] && [ "$5" = "peer1" ] && [ "$#" = 8 ]; then
    FILE_NAME=$6
    BLOCK_NUMBER=$7

    peerChannelFetchBlockTls "agridata" "cli.auditor.example.com" "${FILE_NAME}" "${BLOCK_NUMBER}" "peer1.auditor.example.com:7062" "crypto-orderer/tlsca.root.com-cert.pem"

  elif
    [ "$1" = "getinfo" ] && [ "$2" = "agridata" ] && [ "$3" = "transporter" ] && [ "$4" = "peer0" ]
  then

    peerChannelGetInfoTls "agridata" "cli.transporter.example.com" "peer0.transporter.example.com:7081" "crypto-orderer/tlsca.root.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "config" ] && [ "$3" = "agridata" ] && [ "$4" = "transporter" ] && [ "$5" = "peer0" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchConfigTls "agridata" "cli.transporter.example.com" "${FILE_NAME}" "peer0.transporter.example.com:7081" "crypto-orderer/tlsca.root.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "lastBlock" ] && [ "$3" = "agridata" ] && [ "$4" = "transporter" ] && [ "$5" = "peer0" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchLastBlockTls "agridata" "cli.transporter.example.com" "${FILE_NAME}" "peer0.transporter.example.com:7081" "crypto-orderer/tlsca.root.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "firstBlock" ] && [ "$3" = "agridata" ] && [ "$4" = "transporter" ] && [ "$5" = "peer0" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchFirstBlockTls "agridata" "cli.transporter.example.com" "${FILE_NAME}" "peer0.transporter.example.com:7081" "crypto-orderer/tlsca.root.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "block" ] && [ "$3" = "agridata" ] && [ "$4" = "transporter" ] && [ "$5" = "peer0" ] && [ "$#" = 8 ]; then
    FILE_NAME=$6
    BLOCK_NUMBER=$7

    peerChannelFetchBlockTls "agridata" "cli.transporter.example.com" "${FILE_NAME}" "${BLOCK_NUMBER}" "peer0.transporter.example.com:7081" "crypto-orderer/tlsca.root.com-cert.pem"

  elif
    [ "$1" = "getinfo" ] && [ "$2" = "agridata" ] && [ "$3" = "transporter" ] && [ "$4" = "peer1" ]
  then

    peerChannelGetInfoTls "agridata" "cli.transporter.example.com" "peer1.transporter.example.com:7082" "crypto-orderer/tlsca.root.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "config" ] && [ "$3" = "agridata" ] && [ "$4" = "transporter" ] && [ "$5" = "peer1" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchConfigTls "agridata" "cli.transporter.example.com" "${FILE_NAME}" "peer1.transporter.example.com:7082" "crypto-orderer/tlsca.root.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "lastBlock" ] && [ "$3" = "agridata" ] && [ "$4" = "transporter" ] && [ "$5" = "peer1" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchLastBlockTls "agridata" "cli.transporter.example.com" "${FILE_NAME}" "peer1.transporter.example.com:7082" "crypto-orderer/tlsca.root.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "firstBlock" ] && [ "$3" = "agridata" ] && [ "$4" = "transporter" ] && [ "$5" = "peer1" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchFirstBlockTls "agridata" "cli.transporter.example.com" "${FILE_NAME}" "peer1.transporter.example.com:7082" "crypto-orderer/tlsca.root.com-cert.pem"

  elif [ "$1" = "fetch" ] && [ "$2" = "block" ] && [ "$3" = "agridata" ] && [ "$4" = "transporter" ] && [ "$5" = "peer1" ] && [ "$#" = 8 ]; then
    FILE_NAME=$6
    BLOCK_NUMBER=$7

    peerChannelFetchBlockTls "agridata" "cli.transporter.example.com" "${FILE_NAME}" "${BLOCK_NUMBER}" "peer1.transporter.example.com:7082" "crypto-orderer/tlsca.root.com-cert.pem"

  else

    printChannelsHelp
  fi

}

printChannelsHelp() {
  echo "Channel management commands:"
  echo ""

  echo "fablo channel list farmer peer0"
  echo -e "\t List channels on 'peer0' of 'Farmer'".
  echo ""

  echo "fablo channel list farmer peer1"
  echo -e "\t List channels on 'peer1' of 'Farmer'".
  echo ""

  echo "fablo channel list auditor peer0"
  echo -e "\t List channels on 'peer0' of 'Auditor'".
  echo ""

  echo "fablo channel list auditor peer1"
  echo -e "\t List channels on 'peer1' of 'Auditor'".
  echo ""

  echo "fablo channel list transporter peer0"
  echo -e "\t List channels on 'peer0' of 'Transporter'".
  echo ""

  echo "fablo channel list transporter peer1"
  echo -e "\t List channels on 'peer1' of 'Transporter'".
  echo ""

  echo "fablo channel getinfo agridata farmer peer0"
  echo -e "\t Get channel info on 'peer0' of 'Farmer'".
  echo ""
  echo "fablo channel fetch config agridata farmer peer0 <fileName.json>"
  echo -e "\t Download latest config block to current dir. Uses first peer 'peer0' of 'Farmer'".
  echo ""
  echo "fablo channel fetch lastBlock agridata farmer peer0 <fileName.json>"
  echo -e "\t Download last, decrypted block to current dir. Uses first peer 'peer0' of 'Farmer'".
  echo ""
  echo "fablo channel fetch firstBlock agridata farmer peer0 <fileName.json>"
  echo -e "\t Download first, decrypted block to current dir. Uses first peer 'peer0' of 'Farmer'".
  echo ""

  echo "fablo channel getinfo agridata farmer peer1"
  echo -e "\t Get channel info on 'peer1' of 'Farmer'".
  echo ""
  echo "fablo channel fetch config agridata farmer peer1 <fileName.json>"
  echo -e "\t Download latest config block to current dir. Uses first peer 'peer1' of 'Farmer'".
  echo ""
  echo "fablo channel fetch lastBlock agridata farmer peer1 <fileName.json>"
  echo -e "\t Download last, decrypted block to current dir. Uses first peer 'peer1' of 'Farmer'".
  echo ""
  echo "fablo channel fetch firstBlock agridata farmer peer1 <fileName.json>"
  echo -e "\t Download first, decrypted block to current dir. Uses first peer 'peer1' of 'Farmer'".
  echo ""

  echo "fablo channel getinfo agridata auditor peer0"
  echo -e "\t Get channel info on 'peer0' of 'Auditor'".
  echo ""
  echo "fablo channel fetch config agridata auditor peer0 <fileName.json>"
  echo -e "\t Download latest config block to current dir. Uses first peer 'peer0' of 'Auditor'".
  echo ""
  echo "fablo channel fetch lastBlock agridata auditor peer0 <fileName.json>"
  echo -e "\t Download last, decrypted block to current dir. Uses first peer 'peer0' of 'Auditor'".
  echo ""
  echo "fablo channel fetch firstBlock agridata auditor peer0 <fileName.json>"
  echo -e "\t Download first, decrypted block to current dir. Uses first peer 'peer0' of 'Auditor'".
  echo ""

  echo "fablo channel getinfo agridata auditor peer1"
  echo -e "\t Get channel info on 'peer1' of 'Auditor'".
  echo ""
  echo "fablo channel fetch config agridata auditor peer1 <fileName.json>"
  echo -e "\t Download latest config block to current dir. Uses first peer 'peer1' of 'Auditor'".
  echo ""
  echo "fablo channel fetch lastBlock agridata auditor peer1 <fileName.json>"
  echo -e "\t Download last, decrypted block to current dir. Uses first peer 'peer1' of 'Auditor'".
  echo ""
  echo "fablo channel fetch firstBlock agridata auditor peer1 <fileName.json>"
  echo -e "\t Download first, decrypted block to current dir. Uses first peer 'peer1' of 'Auditor'".
  echo ""

  echo "fablo channel getinfo agridata transporter peer0"
  echo -e "\t Get channel info on 'peer0' of 'Transporter'".
  echo ""
  echo "fablo channel fetch config agridata transporter peer0 <fileName.json>"
  echo -e "\t Download latest config block to current dir. Uses first peer 'peer0' of 'Transporter'".
  echo ""
  echo "fablo channel fetch lastBlock agridata transporter peer0 <fileName.json>"
  echo -e "\t Download last, decrypted block to current dir. Uses first peer 'peer0' of 'Transporter'".
  echo ""
  echo "fablo channel fetch firstBlock agridata transporter peer0 <fileName.json>"
  echo -e "\t Download first, decrypted block to current dir. Uses first peer 'peer0' of 'Transporter'".
  echo ""

  echo "fablo channel getinfo agridata transporter peer1"
  echo -e "\t Get channel info on 'peer1' of 'Transporter'".
  echo ""
  echo "fablo channel fetch config agridata transporter peer1 <fileName.json>"
  echo -e "\t Download latest config block to current dir. Uses first peer 'peer1' of 'Transporter'".
  echo ""
  echo "fablo channel fetch lastBlock agridata transporter peer1 <fileName.json>"
  echo -e "\t Download last, decrypted block to current dir. Uses first peer 'peer1' of 'Transporter'".
  echo ""
  echo "fablo channel fetch firstBlock agridata transporter peer1 <fileName.json>"
  echo -e "\t Download first, decrypted block to current dir. Uses first peer 'peer1' of 'Transporter'".
  echo ""

}
