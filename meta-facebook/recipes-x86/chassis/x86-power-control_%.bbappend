FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
EXTRA_OECMAKE += "-DCHASSIS_SYSTEM_RESET=ON"
FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}/${MACHINE}:"



SRC_URI_append_yosemitev2 = " file://power-config-host1.json"
SRC_URI_append_yosemitev2 = " file://power-config-host2.json"
SRC_URI_append_yosemitev2 = " file://power-config-host3.json"
SRC_URI_append_yosemitev2 = " file://power-config-host4.json"

SYSTEMD_SERVICE_${PN}_append_tiogapass += "xyz.openbmc_project.Chassis.Control.Power@0.service"
    
SYSTEMD_SERVICE_${PN}_append_yosemitev2 += "xyz.openbmc_project.Chassis.Control.Power@1.service"
SYSTEMD_SERVICE_${PN}_append_yosemitev2 += "xyz.openbmc_project.Chassis.Control.Power@2.service"
SYSTEMD_SERVICE_${PN}_append_yosemitev2 += "xyz.openbmc_project.Chassis.Control.Power@3.service"
SYSTEMD_SERVICE_${PN}_append_yosemitev2 += "xyz.openbmc_project.Chassis.Control.Power@4.service"

do_install_append_yosemitev2() {
    install -m 0755 -d ${D}/${datadir}/${BPN}
    install -m 0644 -D ${WORKDIR}/*.json \
                   ${D}/${datadir}/${BPN}/
}
