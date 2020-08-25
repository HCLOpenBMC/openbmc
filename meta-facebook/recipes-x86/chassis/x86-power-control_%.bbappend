FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}/${MACHINE}:"

SRC_URI_append = " file://*.sh"


SYSTEMD_SERVICE_${PN} += "power_good1_asserted.service \
                          power_good2_asserted.service \
                          power_good3_asserted.service \
                          power_good4_asserted.service \
"

do_install_append() {
    install -m 0755 -d ${D}/${datadir}/${BPN}
    install -m 0644 -D ${WORKDIR}/*.json \
                   ${D}/${datadir}/${BPN}/
}
