FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI += "file://bios-update.sh"

PACKAGECONFIG_append = " flash_bios"
RDEPENDS_${PN} += "bash"

SYSTEMD_SERVICE_${PN}-updater += "obmc-flash-host-1_BIOS@.service"
                                                                               
do_install_append() {
    install -d ${D}/${sbindir}
    install -m 0755 ${WORKDIR}/bios-update.sh ${D}/${sbindir}/
}
