# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

if [[ "${PV%9999}" != "${PV}" ]]; then
	inherit git-r3
        EGIT_REPO_URI="https://github.com/paolostivanin/libcotp.git"
	KEYWORDS=""
else
        SRC_URI="https://github.com/paolostivanin/libcotp/archive/v${PV}.zip -> ${P}.zip"
	KEYWORDS="~amd64 ~x86"
fi

inherit cmake-utils

DESCRIPTION="C library that generates TOTP and HOTP"
HOMEPAGE="https://github.com/paolostivanin/libcotp"
LICENSE="Apache-2.0"
SLOT="0"
IUSE=""
RESTRICT="mirror"

DEPEND="
	>=sys-devel/gcc-6.4.0
        >=dev-util/cmake-3.8.2
	>=dev-libs/libbaseencode-1.0.6
"
src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX:PATH=/usr ../
        )
        cmake-utils_src_configure
}
