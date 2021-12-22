#!/bin/bash

APP_NAME=$1                                                     # Name of the app
VERSION=$2                                                      # App version
USERNAME=$3                                                     # Docker Hub username

sbt ad31779d4ee49d5ad5162bf1429c32e2e9933f3b dist                                       # Update app secret and build Play app

cd ./target/universal                                           # Go to directory where application zip is located
rm -rf ./tmp ./dist                                             # Deleted existing directories if those exist

unzip ./"${APP_NAME}"*.zip -d ./tmp                               # Extract application zip
mv ./tmp/"${APP_NAME}"* ./dist                                    # Move application files into dist folder
rm -rf ./tmp                                                    # Remove temp directory
cd ../..                                                        # Go back to application root

docker build -t ${USERNAME}/${APP_NAME}:${VERSION} .            # Build docker image