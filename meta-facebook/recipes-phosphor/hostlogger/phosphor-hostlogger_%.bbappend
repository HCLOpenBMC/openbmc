FILESEXTRAPATHS_prepend := "${THISDIR}:"

SYSTEMD_SERVICE_${PN} += "hostlogger@0.service"
SYSTEMD_SERVICE_${PN} += "hostlogger@1.service"
SYSTEMD_SERVICE_${PN} += "hostlogger@2.service"
SYSTEMD_SERVICE_${PN} += "hostlogger@3.service"
