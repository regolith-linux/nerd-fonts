#!/bin/bash

# set -x
set -e

# curl   -H "Accept: application/vnd.github.v3+json"   https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest | jq '.'

RELEAESE_URL="https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest"
RELEASE_JSON="/tmp/lnfr.json"

curl -H "Accept: application/vnd.github.v3+json" $RELEAESE_URL > $RELEASE_JSON

RELEASE_VERSION=$(cat $RELEASE_JSON | jq -r '.tag_name')

for release_asset in $(cat $RELEASE_JSON | jq -rc '.assets[]'); do
    ASSET_NAME=$(echo $release_asset | jq -r '.name')
    ASSET_URL=$(echo $release_asset | jq -r '.browser_download_url')

    # echo $ASSET_NAME $ASSET_URL

    # Append to control file
    ASSET_DEBIAN_NAME="fonts-nerd-font-${ASSET_NAME%.*}"

    echo "Package: $ASSET_DEBIAN_NAME" >> debian/control
    echo "Architecture: all" >> debian/control
    echo "Multi-Arch: foreign" >> debian/control
    echo "Depends: \${misc:Depends}" >> debian/control
    echo "Description: nerd-fonts ${ASSET_NAME%.*}" >> debian/control
    echo "" >> debian/control

    # Create install file

done
