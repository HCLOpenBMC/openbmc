FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}/${MACHINE}:"

#SRC_URI += "file://*.conf"
SRC_URI_append_yosemitev2 = "file://ttyS0.conf"
SRC_URI_append_yosemitev2 = "file://ttyS1.conf"
SRC_URI += "file://ttyS2.conf"
SRC_URI_append_yosemitev2 = "file://ttyS3.conf"

SYSTEMD_SERVICE_${PN} += "hostlogger@ttyS2.service"

SYSTEMD_SERVICE_${PN}_append_yosemitev2 += "hostlogger@ttyS0.service"
SYSTEMD_SERVICE_${PN}_append_yosemitev2 += "hostlogger@ttyS1.service"
SYSTEMD_SERVICE_${PN}_append_yosemitev2 += "hostlogger@ttyS3.service"

do_install_append() {

          # Install the configurations
          install -m 0755 -d ${D}${sysconfdir}/${BPN}
          install -m 0644 ${WORKDIR}/*.conf ${D}${sysconfdir}/${BPN}/

          # Remove upstream-provided default configuration
          rm -f ${D}${sysconfdir}/${BPN}/ttyVUART0.conf
}
