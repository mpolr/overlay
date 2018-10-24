# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit gnome2-utils

DESCRIPTION="La Capitaine is an icon pack designed to integrate with most desktop environments"
HOMEPAGE="https://github.com/keeferrourke/la-capitaine-icon-theme"
SRC_URI="https://github.com/keeferrourke/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPLv3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="x11-themes/hicolor-icon-theme"

RESTRICT="binchecks strip"

S=${WORKDIR}/la-capitaine-icon-theme-${PV}

src_install() {
	insinto /usr/share/icons/la-capitaine
	doins -r *
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
