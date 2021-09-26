#!/bin/bash
set -uex

# assume already install: libgmp-dev nasm nlohmann-json3-dev snarkit plonkit
# see https://github.com/fluidex/fluidex-backend/blob/master/scripts/install_deps.sh

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null 2>&1 && pwd)"
REPO_DIR=$DIR/".."
PLONKIT_DIR=$REPO_DIR/plonkit
CIRCUIT_DIR=$PLONKIT_DIR/test/circuits/simple

function handle_submodule() {
  git submodule update --init --recursive
  if [ -z ${CI+x} ]; then git pull --recurse-submodules; fi
}


function prepare_circuit() {
  # cd $CIRCUIT_DIR
  # npm i
  snarkit compile $CIRCUIT_DIR --verbose --backend=auto 2>&1 | tee /tmp/snarkit.log
  plonkit dump-lagrange -c $CIRCUIT_DIR/circuit.r1cs -m $PLONKIT_DIR/keys/setup/setup_2^10.key -l $PLONKIT_DIR/keys/setup/setup_2^10.lag.key
}

function prepare_config() {
  cd $DIR
  cp *.yaml $REPO_DIR/config/
}

function setup() {
  handle_submodule
  prepare_circuit
  prepare_config
}

if [[ -z ${AS_RESOURCE+x}  ]]; then
  setup
fi
