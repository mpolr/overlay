# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LICENSE="Canon-IJ GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
DESCRIPTION="IJ Printer Driver for Linux"
HOMEPAGE="https://www.canon-europe.com/support/"
SRC_URI="http://gdlp01.c-wss.com/gds/0/0100009490/01/cnijfilter2-source-5.60-1.tar.gz -> cnijfilter2-source-5.60-1.tar.gz"
S="${WORKDIR}/cnijfilter2-source-5.60-1"
RDEPEND="
	virtual/libusb:1
	>=net-print/cups-1.6.0
	app-text/ghostscript-gpl
	dev-libs/glib
	dev-libs/popt
	media-libs/libpng:0
	media-libs/tiff:0
"
DEPEND="${RDEPEND}"

pkg_setup() {
	CN_PATH="${EPREFIX}/usr"
	CN_ARC="64"
	CN_BINDIR="/bin"
	CN_LIBDIR="/$(get_libdir)"
	CN_SHAREDIR="/share"
	CN_CNLIBS="${CN_LIBDIR}/bjlib2"
	CN_PPDIR="${CN_SHAREDIR}/cups/model"
	CN_CUPSBINDIR="/libexec/cups"
}

src_prepare() {
	default_src_prepare

	# fix cups filters path
	sed -i -e \
	    "s:filterdir=\$(libdir)\/cups\/filter:filterdir=\$(libexecdir)\/cups\/filter:g" \
	    "${S}/rastertocanonij/src/Makefile.am" \
			|| die "patching rastertocanonij/src/Makefile.am failed"
	sed -i -e \
	    "s:filterdir=\$(libdir)\/cups\/filter:filterdir=\$(libexecdir)\/cups\/filter:g" \
	    "${S}/cmdtocanonij3/filter/Makefile.am" \
			|| die "patching cmdtocanonij3/filter/Makefile.am failed"

	# fix cups backends path
	sed -i -e \
	    "s:/usr/lib/cups/backend:\$(libexecdir)\/cups\/backend:g" \
	    "${S}/cnijbe2/src/Makefile.am" \
			|| die "patching cnijbe2/src/Makefile.am failed"
}

src_compile() {
	cd "${S}/cmdtocanonij3"
	./autogen.sh \
		--prefix=${CN_PATH} \
		--datadir=${CN_PATH}${CN_SHAREDIR} \
		LDFLAGS="-L../../com/libs_bin${CN_ARC}"
	emake

	cd "${S}/cnijbe2"
	./autogen.sh \
		--prefix=${CN_PATH} \
		--enable-progpath=${CN_PATH}${CN_BINDIR}
	emake

	cd "${S}/lgmon3"
	./autogen.sh \
		--prefix=${CN_PATH} \
		--enable-libpath=${CN_PATH}${CN_CNLIBS} \
		--enable-progpath=${CN_PATH}${CN_BINDIR} \
		--datadir=${CN_PATH}${CN_SHAREDIR} \
		LDFLAGS="-L../../com/libs_bin${CN_ARC}"
	emake

	cd "${S}/rastertocanonij"
	./autogen.sh \
		--prefix=${CN_PATH} \
		--enable-progpath=${CN_PATH}${CN_BINDIR}
	emake

	cd "${S}/tocanonij"
	./autogen.sh --prefix=${CN_PATH}
	emake

	cd "${S}/tocnpwg"
	./autogen.sh --prefix=${CN_PATH}
	emake
}

src_install() {
	insinto ${CN_PATH}${CN_CNLIBS}
	insopts -m 644
	doins com/ini/cnnet.ini

	dolib.so com/libs_bin${CN_ARC}/*.so.*
	dolib.so com/libs_bin${CN_ARC}/*.so.*
	dosym libcnbpcnclapicom2.so.5.0.0 "${CN_PATH}${CN_LIBDIR}/libcnbpcnclapicom2.so"
	dosym libcnnet2.so.1.2.4 "${CN_PATH}${CN_LIBDIR}/libcnnet2.so"

	cd "${S}/ppd"
	insinto ${CN_PATH}${CN_PPDIR}
	insopts -m 644
	doins *.ppd

	cd "${S}/cmdtocanonij3"
	emake DESTDIR="${D}" install

	cd "${S}/cnijbe2"
	emake DESTDIR="${D}" install

	cd "${S}/lgmon3"
	emake DESTDIR="${D}" install

	cd "${S}/rastertocanonij"
	emake DESTDIR="${D}" install

	cd "${S}/tocanonij"
	emake DESTDIR="${D}" install

	cd "${S}/tocnpwg"
	emake DESTDIR="${D}" install
}

src_test() {
	cd "${S}/cmdtocanonij3"
	emake check

	cd "${S}/cnijbe2"
	emake check

	cd "${S}/lgmon3"
	emake check

	cd "${S}/rastertocanonij"
	emake check

	cd "${S}/tocanonij"
	emake check

	cd "${S}/tocnpwg"
	emake check
}
