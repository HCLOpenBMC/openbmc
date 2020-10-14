FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI += "file://bios-update.sh"

PACKAGECONFIG_append = " flash_bios"
RDEPENDS_${PN} += "bash"

SYSTEMD_SERVICE_${PN}-updater += "obmc-flash-host1-bios@.service"
SYSTEMD_SERVICE_${PN}-updater += "obmc-flash-host2-bios@.service"
SYSTEMD_SERVICE_${PN}-updater += "obmc-flash-host3-bios@.service"
SYSTEMD_SERVICE_${PN}-updater += "obmc-flash-host4-bios@.service"
                                                                               
do_install_append() {
    install -d ${D}/${sbindir}
    install -m 0755 ${WORKDIR}/bios-update.sh ${D}/${sbindir}/
}
