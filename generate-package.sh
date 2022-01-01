#!/bin/bash

# set -x
set -e

RELEAESE_URL="https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest"
RELEASE_JSON="/tmp/lnfr.json"
TMP_ASSET_DIR="/tmp/nfa"

write_debian_control_start() {
    echo "Source: fonts-nerd-fonts" >> debian/control
    echo "Section: fonts" >> debian/control
    echo "Priority: optional" >> debian/control
    echo "Maintainer: Regolith Linux <regolith.linux@gmail.com>" >> debian/control
    echo "Build-Depends: debhelper (>= 10)" >> debian/control
    echo "Standards-Version: 4.1.2" >> debian/control
}

write_debian_rules() {
    echo "%:" >> debian/rules
	echo "    dh \$@" >> debian/rules
}

download_latest_release() {
    curl -H "Accept: application/vnd.github.v3+json" $RELEAESE_URL > $RELEASE_JSON
}

setup() {
    if [ ! -d $TMP_ASSET_DIR ]; then
        mkdir -p $TMP_ASSET_DIR
    fi

    rm -Rf debian
    mkdir debian

    write_debian_control_start
    write_debian_rules
}

RELEASE_VERSION=$(cat $RELEASE_JSON | jq -r '.tag_name')

generate_debian_package() {
    for release_asset in $(cat $RELEASE_JSON | jq -rc '.assets[]'); do
        ASSET_NAME=$(echo $release_asset | jq -r '.name' | awk '{print tolower($0)}')
        ASSET_FILENAME=$(echo $release_asset | jq -r '.name')
        ASSET_URL=$(echo $release_asset | jq -r '.browser_download_url')

        # echo $ASSET_NAME $ASSET_URL

        # Append to control file
        ASSET_DEBIAN_NAME="fonts-nerd-font-${ASSET_NAME%.*}"

        echo "" >> debian/control
        echo "Package: $ASSET_DEBIAN_NAME" >> debian/control
        echo "Architecture: all" >> debian/control
        echo "Multi-Arch: foreign" >> debian/control
        echo "Depends: \${misc:Depends}" >> debian/control
        echo "Description: nerd-fonts ${ASSET_NAME%.*}" >> debian/control    

        # Create install file
        wget -P $TMP_ASSET_DIR "$ASSET_URL"
        mkdir -p "usr/share/fonts/opentype/${ASSET_NAME%.*}"
        unzip "$TMP_ASSET_DIR/$ASSET_FILENAME" "*.otf" -d "usr/share/fonts/opentype/${ASSET_NAME%.*}/"
    done
}

setup
download_latest_release

write_debian_control_start