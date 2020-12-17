FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}/${MACHINE}:"

SRC_URI += "file://ttyS2.conf"

SRC_URI_append_yosemitev2 += "file://ttyS0.conf"
SRC_URI_append_yosemitev2 += "file://ttyS1.conf"
SRC_URI_append_yosemitev2 += "file://ttyS3.conf"

do_install_append() {

          # Install the configurations
          install -m 0755 -d ${D}${sysconfdir}/${BPN}
          install -m 0644 ${WORKDIR}/*.conf ${D}${sysconfdir}/${BPN}/

          # Remove upstream-provided default configuration
          rm -f ${D}${sysconfdir}/${BPN}/ttyVUART0.conf
}
