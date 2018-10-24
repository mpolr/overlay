# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit gnome2-utils

DESCRIPTION="An x-cursor theme inspired by macOS and based on KDE Breeze"
HOMEPAGE="https://github.com/keeferrourke/capitaine-cursors"
SRC_URI="https://github.com/keeferrourke/${PN}/archive/r${PV}.tar.gz -> ${PN}-r${PV}.tar.gz"

LICENSE="LGPLv3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=media-libs/libpng-1.2
	x11-libs/libX11
	x11-libs/libXcursor"

RESTRICT="binchecks strip"
S=${WORKDIR}/capitaine-cursors-r${PV}/dist

src_install() {
	insinto /usr/share/icons/capitaine-cursors
	doins -r * || die "install failed."
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
