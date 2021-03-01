SUMMARY = "nftables systemd wrapper"
DESCRIPTION = "nftables systemd wrapper"
PR = "r1"
PV = "1.0"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

inherit systemd

SRC_URI += "file://nftables.service"
SYSTEMD_SERVICE_${PN} += "nftables.service"

do_install() {
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/nftables.service ${D}${systemd_system_unitdir}
}
