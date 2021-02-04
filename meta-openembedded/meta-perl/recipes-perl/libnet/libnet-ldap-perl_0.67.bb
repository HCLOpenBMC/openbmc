SUMMARY = "LDAP Perl module"
DESCRIPTION = "Net::LDAP is a collection of modules that implements \
a LDAP services API for Perl programs. The module may be used to \
search directories or perform maintenance functions such as adding, \
deleting or modifying entries."

SECTION = "libs"

LICENSE = "Artistic-1.0|GPLv1+"
LIC_FILES_CHKSUM = "file://README;beginline=3;endline=5;md5=4d6588c2fa0d38ae162f6314d201d89e"

SRC_URI = "${CPAN_MIRROR}/authors/id/M/MA/MARSCHAP/perl-ldap-${PV}.tar.gz"

SRC_URI[md5sum] = "a949a2bab07b44cc043b965485fe493a"
SRC_URI[sha256sum] = "19a2f7f7959fe23d16367475772c325109f8604d2949e34b96dddb2dfa031170"

S = "${WORKDIR}/perl-ldap-${PV}"

inherit cpan ptest-perl

do_configure_prepend() {
    perl -pi -e 's/auto_install_now.*//g' Makefile.PL
}

do_install_ptest() {
	cp -r ${B}/data ${D}${PTEST_PATH}
	chown -R root:root ${D}${PTEST_PATH}
}

RDEPENDS_${PN} += " \
    libconvert-asn1-perl \
    libio-socket-ssl-perl \
    libauthen-sasl-perl \
    perl-module-integer \
"

RDEPENDS_${PN}-ptest += " \
    libxml-sax-base-perl \
    libxml-sax-writer-perl \
    perl-module-file-compare \
    perl-module-perlio \
    perl-module-test-more \
"

BBCLASSEXTEND = "native"
