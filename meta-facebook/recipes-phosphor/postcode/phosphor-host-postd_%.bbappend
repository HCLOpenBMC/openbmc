FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}/${MACHINE}:"

SRC_URI_append = " file://lpcsnoop.service"

SYSTEMD_SERVICE_${PN}= "lpcsnoop.service"

do_install_append() {
    install -m 0644 ${WORKDIR}/lpcsnoop.service ${D}${systemd_system_unitdir} 
}


