FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " file://powerOff.service"
SRC_URI_append = " file://powerOff.sh"

RDEPENDS_${PN} += "bash"

do_install_append(){

    install -d ${D}/lib/systemd/system
    install -m 0644 ${WORKDIR}/powerOff.service ${D}/lib/systemd/system

    install -d ${D}/usr/sbin
    install -m 0777 ${WORKDIR}/powerOff.sh ${D}/usr/sbin
}

FILES_${PN} += "/lib/systemd/system/powerOff.service"
