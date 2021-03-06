# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit eutils versionator

MY_PV=${PV%.?}-${PV##*.}
MY_PV=${PV}
MY_P=${PN}2-${MY_PV}
DESCRIPTION="library to use the SIP protocol for multimedia session establishement"
HOMEPAGE="https://savannah.nongnu.org/projects/exosip/"
SRC_URI="mirror://nongnu/exosip/${MY_P}.tar.gz"

KEYWORDS="~amd64 ~ppc ~x86 ~ppc-macos ~x86-macos"
SLOT="0/$(get_version_component_range 1-2)"
LICENSE="GPL-2"
IUSE="+srv libressl ssl"

DEPEND=">=net-libs/libosip-4.0.0:=
	ssl? (
		!libressl? ( dev-libs/openssl )
		libressl? ( dev-libs/libressl )
	)"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_configure() {
	econf \
		--enable-mt \
		$(use_enable ssl openssl) \
		$(use_enable srv srvrec)
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README
}
