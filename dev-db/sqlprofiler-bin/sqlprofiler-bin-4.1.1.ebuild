# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

SRC_URI="amd64? ( 
			http://www.profilesql.com/files/download/sqlprofiler-${PV}-x64.rpm
			https://rpmfind.net/linux/mageia/distrib/4/x86_64/media/core/updates/lib64icu52-52.1-2.5.mga4.x86_64.rpm
			https://rpmfind.net/linux/fedora/linux/development/rawhide/Everything/x86_64/os/Packages/l/libpng12-1.2.57-6.fc28.x86_64.rpm
		 )
	x86? ( 
			http://www.profilesql.com/files/download/sqlprofiler-${PV}-x32.rpm
			https://rpmfind.net/linux/mageia/distrib/4/i586/media/core/updates/libicu52-52.1-2.5.mga4.i586.rpm
			https://rpmfind.net/linux/fedora-secondary/development/rawhide/Everything/i386/os/Packages/l/libpng12-1.2.57-6.fc28.i686.rpm
	 )"
KEYWORDS="~amd64 ~x86"

inherit eutils gnome2-utils desktop rpm multilib

DESCRIPTION="MySQL profiling tool for tracking the SQL queries"
HOMEPAGE="http://www.profilesql.com"
LICENSE="freedist"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""
RESTRICT="mirror"

# Silence QA messages
QA_PREBUILT="/usr/*"

S=${WORKDIR}/usr

src_unpack () {
	rpm_src_unpack ${A}
	cd "${S}"
	mv ./$(get_libdir)/lib* ./lib/sqlprofiler/
	rm ./share/applications/sqlprofiler.desktop
	rm ./share/app-install/desktop/sqlprofiler.desktop
	rm -r ./lib/.build-id
}

src_install() {
	local dst="/usr"
        insinto ${dst}

        doins -r ./*
        fperms 655 ${dst}/bin/sqlprofiler
	fperms 655 ${dst}/bin/sqlprofiler.sh

        make_desktop_entry /usr/bin/sqlprofiler.sh "Neor Profile SQL ${PV}" sqlprofiler Development
}

pkg_postinst() {
        gnome2_icon_cache_update
}

pkg_postrm() {
        gnome2_icon_cache_update
}
