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

write_debian_compat() {
    echo "10" >> debian/compat
}

write_debian_source_format() {
    mkdir -p debian/source
    echo "3.0 (quilt)" >> debian/source/format
}

write_debian_copyright() {
    echo "Format: https://www.debian.org/doc/packaging-manuals/copyright-format/1.0/" >> debian/copyright
    echo "Upstream-Name: Nerd Fonts" >> debian/copyright
    echo "Source: https://github.com/ryanoasis/nerd-fonts" >> debian/copyright
    echo "" >> debian/copyright
    echo "Files: *" >> debian/copyright
    echo "Copyright: 2014 Ryan L McIntyre" >> debian/copyright
    echo "License: MIT" >> debian/copyright
    echo " Permission is hereby granted, free of charge, to any person obtaining a copy" >> debian/copyright
    echo " of this software and associated documentation files (the "Software"), to deal" >> debian/copyright
    echo " in the Software without restriction, including without limitation the rights" >> debian/copyright
    echo " to use, copy, modify, merge, publish, distribute, sublicense, and/or sell" >> debian/copyright
    echo " copies of the Software, and to permit persons to whom the Software is" >> debian/copyright
    echo " furnished to do so, subject to the following conditions:" >> debian/copyright
    echo " ." >> debian/copyright
    echo " The above copyright notice and this permission notice shall be included in all" >> debian/copyright
    echo " copies or substantial portions of the Software." >> debian/copyright
    echo " ." >> debian/copyright
    echo " THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR" >> debian/copyright
    echo " IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY," >> debian/copyright
    echo " FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE" >> debian/copyright
    echo " AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER" >> debian/copyright
    echo " LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM," >> debian/copyright
    echo " OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE" >> debian/copyright
    echo " SOFTWARE." >> debian/copyright
    echo " ." >> debian/copyright
    echo " ## Various Fonts, Patched Fonts, SVGs, Glyph Fonts, and any files in a folder with explicit SIL OFL 1.1 License" >> debian/copyright
    echo " ." >> debian/copyright
    echo " Copyright (c) 2014, Ryan L McIntyre (https://ryanlmcintyre.com)." >> debian/copyright
    echo " ." >> debian/copyright
    echo " This Font Software is licensed under the SIL Open Font License, Version 1.1." >> debian/copyright
    echo " This license is copied below, and is also available with a FAQ at:" >> debian/copyright
    echo " http://scripts.sil.org/OFL" >> debian/copyright
    echo " ." >> debian/copyright
    echo " -----------------------------------------------------------" >> debian/copyright
    echo " SIL OPEN FONT LICENSE Version 1.1 - 26 February 2007" >> debian/copyright
    echo " -----------------------------------------------------------" >> debian/copyright
    echo " ." >> debian/copyright
    echo " PREAMBLE" >> debian/copyright
    echo " The goals of the Open Font License (OFL) are to stimulate worldwide" >> debian/copyright
    echo " development of collaborative font projects, to support the font creation" >> debian/copyright
    echo " efforts of academic and linguistic communities, and to provide a free and" >> debian/copyright
    echo " open framework in which fonts may be shared and improved in partnership" >> debian/copyright
    echo " with others." >> debian/copyright
    echo " ." >> debian/copyright
    echo " The OFL allows the licensed fonts to be used, studied, modified and" >> debian/copyright
    echo " redistributed freely as long as they are not sold by themselves. The" >> debian/copyright
    echo " fonts, including any derivative works, can be bundled, embedded, " >> debian/copyright
    echo " redistributed and/or sold with any software provided that any reserved" >> debian/copyright
    echo " names are not used by derivative works. The fonts and derivatives," >> debian/copyright
    echo " however, cannot be released under any other type of license. The" >> debian/copyright
    echo " requirement for fonts to remain under this license does not apply" >> debian/copyright
    echo " to any document created using the fonts or their derivatives." >> debian/copyright
    echo " ." >> debian/copyright
    echo " DEFINITIONS" >> debian/copyright
    echo " "Font Software" refers to the set of files released by the Copyright" >> debian/copyright
    echo " Holder(s) under this license and clearly marked as such. This may" >> debian/copyright
    echo " include source files, build scripts and documentation." >> debian/copyright
    echo " ." >> debian/copyright
    echo " "Reserved Font Name" refers to any names specified as such after the" >> debian/copyright
    echo " copyright statement(s)." >> debian/copyright
    echo " ." >> debian/copyright
    echo " "Original Version" refers to the collection of Font Software components as" >> debian/copyright
    echo " distributed by the Copyright Holder(s)." >> debian/copyright
    echo " ." >> debian/copyright
    echo " "Modified Version" refers to any derivative made by adding to, deleting," >> debian/copyright
    echo " or substituting -- in part or in whole -- any of the components of the" >> debian/copyright
    echo " Original Version, by changing formats or by porting the Font Software to a" >> debian/copyright
    echo " new environment." >> debian/copyright
    echo " ." >> debian/copyright
    echo " "Author" refers to any designer, engineer, programmer, technical" >> debian/copyright
    echo " writer or other person who contributed to the Font Software." >> debian/copyright
    echo " ." >> debian/copyright
    echo " PERMISSION & CONDITIONS" >> debian/copyright
    echo " Permission is hereby granted, free of charge, to any person obtaining" >> debian/copyright
    echo " a copy of the Font Software, to use, study, copy, merge, embed, modify," >> debian/copyright
    echo " redistribute, and sell modified and unmodified copies of the Font" >> debian/copyright
    echo " Software, subject to the following conditions:" >> debian/copyright
    echo " ." >> debian/copyright
    echo " 1) Neither the Font Software nor any of its individual components," >> debian/copyright
    echo " in Original or Modified Versions, may be sold by itself." >> debian/copyright
    echo " ." >> debian/copyright
    echo " 2) Original or Modified Versions of the Font Software may be bundled," >> debian/copyright
    echo " redistributed and/or sold with any software, provided that each copy" >> debian/copyright
    echo " contains the above copyright notice and this license. These can be" >> debian/copyright
    echo " included either as stand-alone text files, human-readable headers or" >> debian/copyright
    echo " in the appropriate machine-readable metadata fields within text or" >> debian/copyright
    echo " binary files as long as those fields can be easily viewed by the user." >> debian/copyright
    echo " ." >> debian/copyright
    echo " 3) No Modified Version of the Font Software may use the Reserved Font" >> debian/copyright
    echo " Name(s) unless explicit written permission is granted by the corresponding" >> debian/copyright
    echo " Copyright Holder. This restriction only applies to the primary font name as" >> debian/copyright
    echo " presented to the users." >> debian/copyright
    echo " ." >> debian/copyright
    echo " 4) The name(s) of the Copyright Holder(s) or the Author(s) of the Font" >> debian/copyright
    echo " Software shall not be used to promote, endorse or advertise any" >> debian/copyright
    echo " Modified Version, except to acknowledge the contribution(s) of the" >> debian/copyright
    echo " Copyright Holder(s) and the Author(s) or with their explicit written" >> debian/copyright
    echo " permission." >> debian/copyright
    echo " ." >> debian/copyright
    echo " 5) The Font Software, modified or unmodified, in part or in whole," >> debian/copyright
    echo " must be distributed entirely under this license, and must not be" >> debian/copyright
    echo " distributed under any other license. The requirement for fonts to" >> debian/copyright
    echo " remain under this license does not apply to any document created" >> debian/copyright
    echo " using the Font Software." >> debian/copyright
    echo " ." >> debian/copyright
    echo " TERMINATION" >> debian/copyright
    echo " This license becomes null and void if any of the above conditions are" >> debian/copyright
    echo " not met." >> debian/copyright
    echo " ." >> debian/copyright
    echo " DISCLAIMER" >> debian/copyright
    echo " THE FONT SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND," >> debian/copyright
    echo " EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OF" >> debian/copyright
    echo " MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT" >> debian/copyright
    echo " OF COPYRIGHT, PATENT, TRADEMARK, OR OTHER RIGHT. IN NO EVENT SHALL THE" >> debian/copyright
    echo " COPYRIGHT HOLDER BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY," >> debian/copyright
    echo " INCLUDING ANY GENERAL, SPECIAL, INDIRECT, INCIDENTAL, OR CONSEQUENTIAL" >> debian/copyright
    echo " DAMAGES, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING" >> debian/copyright
    echo " FROM, OUT OF THE USE OR INABILITY TO USE THE FONT SOFTWARE OR FROM" >> debian/copyright
    echo " OTHER DEALINGS IN THE FONT SOFTWARE." >> debian/copyright
}

write_debian_rules() {
    echo "#!/usr/bin/make -f" >> debian/rules
    echo "" >> debian/rules
    echo "%:" >> debian/rules
    echo "	dh \$@" >> debian/rules
    echo "" >> debian/rules
}

download_latest_release() {
    curl -H "Accept: application/vnd.github.v3+json" $RELEAESE_URL > $RELEASE_JSON
}

setup() {
    if [ ! -d $TMP_ASSET_DIR ]; then
        mkdir -p $TMP_ASSET_DIR
    fi

    rm -Rf usr
    rm -Rf debian
    mkdir debian

    write_debian_copyright
    write_debian_control_start
    write_debian_rules
    write_debian_compat
    write_debian_source_format
}

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
        unzip "$TMP_ASSET_DIR/$ASSET_FILENAME" "*.otf" -d "usr/share/fonts/opentype/${ASSET_NAME%.*}/" -x "*Windows Compatible*" || true
        mkdir -p "usr/share/fonts/truetype/${ASSET_NAME%.*}"
        unzip "$TMP_ASSET_DIR/$ASSET_FILENAME" "*.ttf" -d "usr/share/fonts/truetype/${ASSET_NAME%.*}/" -x "*Windows Compatible*" || true

        if [ -n "$(find usr/share/fonts/opentype/${ASSET_NAME%.*} -prune -empty -type d 2>/dev/null)" ]; then
            rmdir "usr/share/fonts/opentype/${ASSET_NAME%.*}"
        else
            echo "usr/share/fonts/opentype/${ASSET_NAME%.*}" >> "debian/$ASSET_DEBIAN_NAME.install"
        fi

        if [ -n "$(find usr/share/fonts/truetype/${ASSET_NAME%.*} -prune -empty -type d 2>/dev/null)" ]; then
            rmdir "usr/share/fonts/truetype/${ASSET_NAME%.*}"
        else
            echo "usr/share/fonts/truetype/${ASSET_NAME%.*}" >> "debian/$ASSET_DEBIAN_NAME.install"
        fi        
    done

    RELEASE_VERSION=$(cat $RELEASE_JSON | jq -r '.tag_name' | sed 's/^v*//')
    dch --create --newversion $RELEASE_VERSION --package fonts-nerd-fonts --distribution focal "Automated release"
}

setup
download_latest_release
generate_debian_package