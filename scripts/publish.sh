#!/bin/bash

# Push a version update commit with this message
VERSION=$(git rev-parse HEAD)

TARGET_DIR=$(mktemp -d)
DIST_DIR=dist
HEAD_VERSION=$(git rev-parse HEAD)
DEFAULT_CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
CURRENT_BRANCH=${TRAVIS_BRANCH:-$DEFAULT_CURRENT_BRANCH}
TARGET_REPO=https://supersonic-backdoor:932981be6dec428fb8e75219ea78397ef4088d78@github.com/AppGyver/supersonic-bower.git

echo Publishing branch $CURRENT_BRANCH version $HEAD_VERSION with message $VERSION

# Build distributable
grunt build

# Clone target repo
echo Cloning $TARGET_REPO to $TARGET_DIR
git clone $TARGET_REPO $TARGET_DIR
(cd $TARGET_DIR ; git config user.email "richard.anderson+supersonic@appgyver.com" ; git config user.name "Richard Anderson")

# Copy distribution artefacts to target bower repo
# Tag and push repo
echo Updating branch $CURRENT_BRANCH in target repository
(cd $TARGET_DIR && (git checkout -b $CURRENT_BRANCH || git checkout $CURRENT_BRANCH)) && \
(rm -rf $TARGET_DIR/* && \
  cp -r $DIST_DIR/* $TARGET_DIR && \
  cp bower.json $TARGET_DIR && \
  cp README.bower.md $TARGET_DIR/README.md) && \
(cd $TARGET_DIR && \
  git add -A && \
  git commit -m $VERSION && \
  git push origin -f $CURRENT_BRANCH)

# Clean up
echo Cleaning up
rm -rf $TARGET_DIR
echo Done!
