# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit pax-utils desktop

DESCRIPTION="An open-source GUI prototyping tool that's available for ALL platforms."
HOMEPAGE="http://pencil.evolus.vn/"
SRC_URI="http://pencil.evolus.vn/dl/V${PV}/Pencil-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"/Pencil-${PV}

# Silence QA messages
QA_PREBUILT="/opt/${PN}/*"

src_install() {
	insinto /opt/${PN}
	doins -r ./*
	newicon "${FILESDIR}/${PN}.png" ${PN}.png
	exeinto /opt/${PN}
	doexe pencil
	dosym /opt/${PN}/pencil /usr/bin/pencil
	make_desktop_entry /usr/bin/pencil "Pencil project ${PV}" ${PN} Development
}
