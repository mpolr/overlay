# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
MY_PN=${PN/-bin/}
SRC_URI="https://release.gitkraken.com/linux/GitKraken-v${PV}.tar.gz -> ${MY_PN}-${PV}.tar.gz"
KEYWORDS="~amd64"

inherit eutils multilib desktop gnome2-utils

DESCRIPTION="The legendary Git GUI client for Windows, Mac and Linux"
HOMEPAGE="https://www.gitkraken.com"
LICENSE="GitKraken-EULA"
SLOT="0"
IUSE=""

DEPEND=""

RDEPEND="
	>=x11-libs/gtk+-3.22
	>=net-misc/curl-7.57
"
RESTRICT="mirror"

# Silence QA messages
QA_PREBUILT="opt/${MY_PN}/*"

S="${WORKDIR}"/gitkraken

src_install() {
        local dst="/opt/${MY_PN}" # install destination

        insinto ${dst}
        doins -r ./*
	doins "${FILESDIR}/gitkraken.png" || die "icon doins failed"
	newicon -s 128 "${FILESDIR}/gitkraken.png" gitkraken.png || die "newicon failed"

        # Set permissions for executables and libraries
        fperms 655 ${dst}/gitkraken

	dodir /usr/bin
        dosym ${dst}/gitkraken /usr/bin/gitkraken
	#dosym /usr/$(get_libdir)/libcurl.so.4 /usr/$(get_libdir)/libcurl-gnutls.so.4
	make_desktop_entry ${MY_PN} GitKraken ${MY_PN} Development
}

pkg_postinst() {
        gnome2_icon_cache_update
}

pkg_postrm() {
        gnome2_icon_cache_update
}
