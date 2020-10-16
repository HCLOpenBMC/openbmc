FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}/${MACHINE}:"

SRC_URI += "file://*.conf"

SYSTEMD_SERVICE_${PN} += "hostlogger@ttyS0.service"
SYSTEMD_SERVICE_${PN} += "hostlogger@ttyS1.service"
SYSTEMD_SERVICE_${PN} += "hostlogger@ttyS2.service"
SYSTEMD_SERVICE_${PN} += "hostlogger@ttyS3.service"

do_install_append() {

          # Install the configuration
          install -m 0755 -d ${D}${sysconfdir}/${BPN}
          install -m 0644 ${WORKDIR}/*.conf ${D}${sysconfdir}/${BPN}/

          # Remove upstream-provided default configuration
          rm -f ${D}${sysconfdir}/${BPN}/ttyVUART0.conf
}
