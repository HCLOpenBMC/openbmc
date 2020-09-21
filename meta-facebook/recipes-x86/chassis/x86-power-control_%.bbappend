FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}/${MACHINE}:"

SRC_URI_append = " file://power-config-host1.json"

	
SYSTEMD_SERVICE_${PN} += "xyz.openbmc_project.Chassis.Control.Power@1.service"

do_install_append() {
    install -m 0755 -d ${D}/${datadir}/${BPN}
    install -m 0644 -D ${WORKDIR}/*.json \
                   ${D}/${datadir}/${BPN}/
}


