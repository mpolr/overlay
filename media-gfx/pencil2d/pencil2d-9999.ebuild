# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils qmake-utils git-r3

DESCRIPTION="An easy, intuitive tool to make 2D hand-drawn animations"
HOMEPAGE="http://www.pencil2d.org/"
EGIT_REPO_URI="https://github.com/pencil2d/pencil"

KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND="dev-qt/qtgui:5
	dev-qt/qtopengl:5
	dev-qt/qtmultimedia:5
	dev-qt/qtsvg:5
	dev-qt/qtxmlpatterns:5"
DEPEND="${RDEPEND}"

src_configure() {
	eqmake5 "${PN}.pro"
}

src_install() {
	newbin bin/pencil2d ${PN} || die "dobin failed"
	doicon "${S}"/app/data/${PN}.png || die "doicon failed"
	make_desktop_entry ${PN} Pencil2D ${PN} Graphics
}
