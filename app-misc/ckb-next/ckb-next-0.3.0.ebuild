# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit vcs-snapshot cmake-utils systemd

DESCRIPTION="Corsair K55/K65/K70/K95 Driver"
HOMEPAGE="https://github.com/ckb-next/ckb-next"
SRC_URI="https://github.com/ckb-next/ckb-next/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-libs/quazip-0.7.2[qt5(+)]
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5"
RDEPEND="${DEPEND}"

DOCS=( README.md BUILD.md DAEMON.md )


src_configure() {
	local mycmakeargs=(
		-H. -Bbuild -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_LIBEXECDIR=lib
	)
	cmake-utils_src_configure
}

src_install() {
	cd ${BUILD_DIR}
	dobin bin/ckb-next bin/ckb-next-daemon
	dodir /usr/libexec/ckb-next-animations
	exeinto /usr/libexec/ckb-next-animations
	doexe bin/*
	newinitd "${FILESDIR}"/ckb-next.initd ckb-next-daemon
	make_desktop_entry ${PN} "Corsair Keyboard Driver" "${PN}" Settings
	doicon src/gui/ckb-next.png
	systemd_dounit src/daemon/service/ckb-next-daemon.service
}

