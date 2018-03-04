# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

if [[ "${PV%9999}" != "${PV}" ]]; then
	inherit git-r3
        EGIT_REPO_URI="https://github.com/paolostivanin/libbaseencode.git"
	KEYWORDS=""
else
        SRC_URI="https://github.com/paolostivanin/libbaseencode/archive/v${PV}.zip -> ${P}.zip"
	KEYWORDS="~amd64 ~x86"
fi

inherit cmake-utils

DESCRIPTION="Library written in C for encoding and decoding data using base32 or base64 (RFC-4648)"
HOMEPAGE="https://github.com/paolostivanin/libbaseencode"
LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="
	>=sys-devel/gcc-6.4.0
        >=dev-util/cmake-3.8.2
"

RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}"/libbaseencode-cmake-libdir.patch
)

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX:PATH=/usr ../
        )
        cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
}
