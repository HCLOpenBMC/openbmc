FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI += "file://SetTimeBmc.sh"
#SRC_URI += "file://time-manager-bmc-set-time.service"
SYSTEMD_SERVICE_${PN} += "time-manager-bmc-set-time.service"
SYSTEMD_AUTO_ENABLE ?= "disable"

RDEPENDS_${PN} += "bash"
do_install_append(){

    install -d ${D}$/lib/systemd/system
    install -m 0644 ${WORKDIR}/time-manager-bmc-set-time.service  ${D}$/lib/systemd/system
    install -d ${D}/usr/sbin
    install -m 0777 ${WORKDIR}/SetTimeBmc.sh ${D}/usr/sbin

}

