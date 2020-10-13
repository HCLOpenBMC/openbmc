FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}/${MACHINE}:"

SRC_URI_append = " file://power-config-host1.json"
SRC_URI_append = " file://power-config-host2.json"
SRC_URI_append = " file://power-config-host3.json"
SRC_URI_append = " file://power-config-host4.json"

	
SYSTEMD_SERVICE_${PN} += "xyz.openbmc_project.Chassis.Control.Power@1.service"
SYSTEMD_SERVICE_${PN} += "xyz.openbmc_project.Chassis.Control.Power@2.service"
SYSTEMD_SERVICE_${PN} += "xyz.openbmc_project.Chassis.Control.Power@3.service"
SYSTEMD_SERVICE_${PN} += "xyz.openbmc_project.Chassis.Control.Power@4.service"

do_install_append() {
    install -m 0755 -d ${D}/${datadir}/${BPN}
    install -m 0644 -D ${WORKDIR}/*.json \
                   ${D}/${datadir}/${BPN}/
}


