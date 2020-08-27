FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}/${MACHINE}:"

EXTRA_OECMAKE_append_yosemitev2 ="-DPOWER_SLOT_OPTION=1"

SRC_URI_append = " file://*.json"


SYSTEMD_SERVICE_${PN} += "xyz.openbmc_project.Chassis.Control.Power@1.service \
                          xyz.openbmc_project.Chassis.Control.Power@2.service \
                          xyz.openbmc_project.Chassis.Control.Power@3.service \
                          xyz.openbmc_project.Chassis.Control.Power@4.service \
"

do_install_append() {
    install -m 0755 -d ${D}/${datadir}/${BPN}
    install -m 0644 -D ${WORKDIR}/*.json \
                   ${D}/${datadir}/${BPN}/
}

