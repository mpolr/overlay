# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

SRC_URI="https://release.gitkraken.com/linux/gitkraken-amd64.tar.gz -> ${P}-amd64.tar.gz"
KEYWORDS="~amd64"

inherit eutils gnome2-utils desktop

DESCRIPTION="The legendary Git GUI client for Windows, Mac and Linux"
HOMEPAGE="https://www.gitkraken.com"
LICENSE="GitKraken-EULA"
SLOT="0"
IUSE=""

DEPEND=""

RDEPEND="
	>=x11-libs/gtk+-3.22
"
RESTRICT="bindist mirror"

# Silence QA messages
QA_PREBUILT="opt/${PN}-${PV}/*"

S="${WORKDIR}"/gitkraken

src_install() {
        local dst="/opt/${PN}-${PV}" # install destination

        insinto ${dst}
        doins -r ./*
	doins "${FILESDIR}/gitkraken.png"
	newicon "${FILESDIR}/gitkraken.png" gitkraken.png

        # Set permissions for executables and libraries
        fperms 655 ${dst}/gitkraken

	dodir /opt/bin
        dosym ${dst}/gitkraken /opt/bin/gitkraken
        make_desktop_entry gitkraken "GitKraken ${PV}" gitkraken Development
}

pkg_postinst() {
        gnome2_icon_cache_update
}

pkg_postrm() {
        gnome2_icon_cache_update
}
