#!/usr/bin/env bash

source "$FABLO_NETWORK_ROOT/fabric-docker/scripts/channel-query-functions.sh"

set -eu

channelQuery() {
  echo "-> Channel query: " + "$@"

  if [ "$#" -eq 1 ]; then
    printChannelsHelp

  elif [ "$1" = "list" ] && [ "$2" = "org1" ] && [ "$3" = "peer0" ]; then

    peerChannelList "cli.org1.example.com" "peer0.org1.example.com:7041"

  elif
    [ "$1" = "list" ] && [ "$2" = "org1" ] && [ "$3" = "peer1" ]
  then

    peerChannelList "cli.org1.example.com" "peer1.org1.example.com:7042"

  elif
    [ "$1" = "list" ] && [ "$2" = "org2" ] && [ "$3" = "peer0" ]
  then

    peerChannelList "cli.org2.example.com" "peer0.org2.example.com:7061"

  elif

    [ "$1" = "getinfo" ] && [ "$2" = "mychannel" ] && [ "$3" = "org1" ] && [ "$4" = "peer0" ]
  then

    peerChannelGetInfo "mychannel" "cli.org1.example.com" "peer0.org1.example.com:7041"

  elif [ "$1" = "fetch" ] && [ "$2" = "config" ] && [ "$3" = "mychannel" ] && [ "$4" = "org1" ] && [ "$5" = "peer0" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchConfig "mychannel" "cli.org1.example.com" "${FILE_NAME}" "peer0.org1.example.com:7041"

  elif [ "$1" = "fetch" ] && [ "$2" = "lastBlock" ] && [ "$3" = "mychannel" ] && [ "$4" = "org1" ] && [ "$5" = "peer0" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchLastBlock "mychannel" "cli.org1.example.com" "${FILE_NAME}" "peer0.org1.example.com:7041"

  elif [ "$1" = "fetch" ] && [ "$2" = "firstBlock" ] && [ "$3" = "mychannel" ] && [ "$4" = "org1" ] && [ "$5" = "peer0" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchFirstBlock "mychannel" "cli.org1.example.com" "${FILE_NAME}" "peer0.org1.example.com:7041"

  elif [ "$1" = "fetch" ] && [ "$2" = "block" ] && [ "$3" = "mychannel" ] && [ "$4" = "org1" ] && [ "$5" = "peer0" ] && [ "$#" = 8 ]; then
    FILE_NAME=$6
    BLOCK_NUMBER=$7

    peerChannelFetchBlock "mychannel" "cli.org1.example.com" "${FILE_NAME}" "${BLOCK_NUMBER}" "peer0.org1.example.com:7041"

  elif
    [ "$1" = "getinfo" ] && [ "$2" = "mychannel" ] && [ "$3" = "org1" ] && [ "$4" = "peer1" ]
  then

    peerChannelGetInfo "mychannel" "cli.org1.example.com" "peer1.org1.example.com:7042"

  elif [ "$1" = "fetch" ] && [ "$2" = "config" ] && [ "$3" = "mychannel" ] && [ "$4" = "org1" ] && [ "$5" = "peer1" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchConfig "mychannel" "cli.org1.example.com" "${FILE_NAME}" "peer1.org1.example.com:7042"

  elif [ "$1" = "fetch" ] && [ "$2" = "lastBlock" ] && [ "$3" = "mychannel" ] && [ "$4" = "org1" ] && [ "$5" = "peer1" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchLastBlock "mychannel" "cli.org1.example.com" "${FILE_NAME}" "peer1.org1.example.com:7042"

  elif [ "$1" = "fetch" ] && [ "$2" = "firstBlock" ] && [ "$3" = "mychannel" ] && [ "$4" = "org1" ] && [ "$5" = "peer1" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchFirstBlock "mychannel" "cli.org1.example.com" "${FILE_NAME}" "peer1.org1.example.com:7042"

  elif [ "$1" = "fetch" ] && [ "$2" = "block" ] && [ "$3" = "mychannel" ] && [ "$4" = "org1" ] && [ "$5" = "peer1" ] && [ "$#" = 8 ]; then
    FILE_NAME=$6
    BLOCK_NUMBER=$7

    peerChannelFetchBlock "mychannel" "cli.org1.example.com" "${FILE_NAME}" "${BLOCK_NUMBER}" "peer1.org1.example.com:7042"

  elif
    [ "$1" = "getinfo" ] && [ "$2" = "mychannel" ] && [ "$3" = "org2" ] && [ "$4" = "peer0" ]
  then

    peerChannelGetInfo "mychannel" "cli.org2.example.com" "peer0.org2.example.com:7061"

  elif [ "$1" = "fetch" ] && [ "$2" = "config" ] && [ "$3" = "mychannel" ] && [ "$4" = "org2" ] && [ "$5" = "peer0" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchConfig "mychannel" "cli.org2.example.com" "${FILE_NAME}" "peer0.org2.example.com:7061"

  elif [ "$1" = "fetch" ] && [ "$2" = "lastBlock" ] && [ "$3" = "mychannel" ] && [ "$4" = "org2" ] && [ "$5" = "peer0" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchLastBlock "mychannel" "cli.org2.example.com" "${FILE_NAME}" "peer0.org2.example.com:7061"

  elif [ "$1" = "fetch" ] && [ "$2" = "firstBlock" ] && [ "$3" = "mychannel" ] && [ "$4" = "org2" ] && [ "$5" = "peer0" ] && [ "$#" = 7 ]; then
    FILE_NAME=$6

    peerChannelFetchFirstBlock "mychannel" "cli.org2.example.com" "${FILE_NAME}" "peer0.org2.example.com:7061"

  elif [ "$1" = "fetch" ] && [ "$2" = "block" ] && [ "$3" = "mychannel" ] && [ "$4" = "org2" ] && [ "$5" = "peer0" ] && [ "$#" = 8 ]; then
    FILE_NAME=$6
    BLOCK_NUMBER=$7

    peerChannelFetchBlock "mychannel" "cli.org2.example.com" "${FILE_NAME}" "${BLOCK_NUMBER}" "peer0.org2.example.com:7061"

  else

    printChannelsHelp
  fi

}

printChannelsHelp() {
  echo "Channel management commands:"
  echo ""

  echo "fablo channel list org1 peer0"
  echo -e "\t List channels on 'peer0' of 'Org1'".
  echo ""

  echo "fablo channel list org1 peer1"
  echo -e "\t List channels on 'peer1' of 'Org1'".
  echo ""

  echo "fablo channel list org2 peer0"
  echo -e "\t List channels on 'peer0' of 'Org2'".
  echo ""

  echo "fablo channel getinfo mychannel org1 peer0"
  echo -e "\t Get channel info on 'peer0' of 'Org1'".
  echo ""
  echo "fablo channel fetch config mychannel org1 peer0 <fileName.json>"
  echo -e "\t Download latest config block to current dir. Uses first peer 'peer0' of 'Org1'".
  echo ""
  echo "fablo channel fetch lastBlock mychannel org1 peer0 <fileName.json>"
  echo -e "\t Download last, decrypted block to current dir. Uses first peer 'peer0' of 'Org1'".
  echo ""
  echo "fablo channel fetch firstBlock mychannel org1 peer0 <fileName.json>"
  echo -e "\t Download first, decrypted block to current dir. Uses first peer 'peer0' of 'Org1'".
  echo ""

  echo "fablo channel getinfo mychannel org1 peer1"
  echo -e "\t Get channel info on 'peer1' of 'Org1'".
  echo ""
  echo "fablo channel fetch config mychannel org1 peer1 <fileName.json>"
  echo -e "\t Download latest config block to current dir. Uses first peer 'peer1' of 'Org1'".
  echo ""
  echo "fablo channel fetch lastBlock mychannel org1 peer1 <fileName.json>"
  echo -e "\t Download last, decrypted block to current dir. Uses first peer 'peer1' of 'Org1'".
  echo ""
  echo "fablo channel fetch firstBlock mychannel org1 peer1 <fileName.json>"
  echo -e "\t Download first, decrypted block to current dir. Uses first peer 'peer1' of 'Org1'".
  echo ""

  echo "fablo channel getinfo mychannel org2 peer0"
  echo -e "\t Get channel info on 'peer0' of 'Org2'".
  echo ""
  echo "fablo channel fetch config mychannel org2 peer0 <fileName.json>"
  echo -e "\t Download latest config block to current dir. Uses first peer 'peer0' of 'Org2'".
  echo ""
  echo "fablo channel fetch lastBlock mychannel org2 peer0 <fileName.json>"
  echo -e "\t Download last, decrypted block to current dir. Uses first peer 'peer0' of 'Org2'".
  echo ""
  echo "fablo channel fetch firstBlock mychannel org2 peer0 <fileName.json>"
  echo -e "\t Download first, decrypted block to current dir. Uses first peer 'peer0' of 'Org2'".
  echo ""

}
