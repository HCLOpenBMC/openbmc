FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}/${MACHINE}:"
EXTRA_OECONF_append_yosemitev2 = " --enable-concurrent-servers"

SYSTEMD_SERVICE_${PN}_remove_yosemitev2 = "hostlogger.service"

SYSTEMD_SERVICE_${PN} += "hostlogger@0.service"
SYSTEMD_SERVICE_${PN} += "hostlogger@1.service"
SYSTEMD_SERVICE_${PN} += "hostlogger@2.service"
SYSTEMD_SERVICE_${PN} += "hostlogger@3.service"
