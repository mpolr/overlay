# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
MY_PN=${PN/-bin/}
SRC_URI="https://release.gitkraken.com/linux/v${PV}.tar.gz -> ${MY_PN}-${PV}.tar.gz"
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
RESTRICT="mirror"

# Silence QA messages
QA_PREBUILT="opt/${MY_PN}/*"

S="${WORKDIR}"/gitkraken

src_install() {
        local dst="/opt/${MY_PN}" # install destination

        insinto ${dst}
        doins -r ./*
	doins "${FILESDIR}/gitkraken.png"
	newicon -s 128 "${FILESDIR}/gitkraken.png" gitkraken.png

        # Set permissions for executables and libraries
        fperms 655 ${dst}/gitkraken

	dodir /usr/bin
        dosym ${dst}/gitkraken /usr/bin/gitkraken
        make_desktop_entry /usr/bin/gitkraken "GitKraken ${PV}" ${MY_PN} Development
}

pkg_postinst() {
        gnome2_icon_cache_update
}

pkg_postrm() {
        gnome2_icon_cache_update
}
