# How to contribute

Follow the below steps to setup the package

## Install / update Repo Dependencies

Always run: `npm install'

## Install Dependent Packages

For all of the dependencies inside of the packageDirectories, run this command:

`sfdx force:package:install -p $PACKAGE_ID -k $KEY`

## Push Metadata to Scratch Org

`sfdx force:source:push`

# Deploying

### Create Package (Run once)

`sfdx force:package:create --name "Apex Enterprise Patterns" --path sfdx-source/apex-common \--packagetype Unlocked`

### Create New Version

`sfdx force:package:version:create --package "Apex Enterprise Patterns" --path sfdx-source/apex-common --installationkey $KEY --definitionfile config/project-scratch-def.json --wait 10`

### List Package Versions

Grab the new version that you want to install:
`sfdx force:package:version:list`

### Install Package

Specify username `--targetusername $ORG_USERNAME` or it will install with your current default connection

`sfdx force:package:install -p $SUBSCRIBER_PACKAGE_VERSION --wait 10 -k "$KEY -a package`