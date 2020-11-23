echo "----- Creating Scratch Org -----"
sfdx force:org:create -f config/project-scratch-def.json --setalias sf-apex-common-dev --durationdays 30 --setdefaultusername

echo "\n----- Install Metadata -----"
sfdx texei:package:dependencies:install -k "1:$1"

echo "\n----- Pushing Metadata -----"
sfdx force:source:push