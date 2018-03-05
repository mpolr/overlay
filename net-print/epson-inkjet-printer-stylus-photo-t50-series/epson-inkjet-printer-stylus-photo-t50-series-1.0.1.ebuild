# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

SRC_URI="amd64? ( http://download.ebz.epson.net/dsc/op/stable/RPMS/x86_64/epson-inkjet-printer-stylus-photo-t50-series-${PV}-1lsb3.2.x86_64.rpm )
                x86? ( http://download.ebz.epson.net/dsc/op/stable/RPMS/i486/epson-inkjet-printer-stylus-photo-t50-series-${PV}-1lsb3.2.i486.rpm )"
KEYWORDS="~amd64 ~x86"

inherit rpm eutils multilib

DESCRIPTION="Epson Inkjet Printer Driver for Linux"
HOMEPAGE="http://www.openprinting.org/printer/Epson/Epson-Stylus_Photo_T50"
LICENSE="LGPL-and-SEIKO-EPSON-CORPORATION-SOFTWARE-LICENSE-AGREEMENT"
SLOT="0"
IUSE=""

DEPEND=""

RDEPEND="
	>=net-print/cups-1.16.4
"
RESTRICT="mirror"

# Silence QA messages
#QA_PREBUILT="opt/${PN}-${PV}/*"

S=${WORKDIR}/opt

src_unpack () {
        rpm_src_unpack ${A}
        cd "${S}"
}

src_install() {
        local dst="/opt"
        insinto ${dst}

        doins -r ./*
	elog "Installing symlink for 'ld-linux-x86-64.so.2' in /$(get_libdir)"
        dosym ld-linux-x86-64.so.2 /$(get_libdir)/ld-lsb-x86-64.so.3

        # Set permissions for executables and libraries
	elog "Change ownership of '${dst}/${PN}' to root:root"
	fowners -R root:root ${dst}/${PN}
	elog "Change permissions of '${dst}/${PN}' to 755"
        fperms -R 755 ${dst}/${PN}
}
