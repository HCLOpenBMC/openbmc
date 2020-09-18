FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}/${MACHINE}:"

SRC_URI_append = " file://power-config-host1.json"

do_install_append() {
    install -m 0755 -d ${D}/${datadir}/${BPN}
    install -m 0644 -D ${WORKDIR}/power-config-host1.json \
                   ${D}/${datadir}/${BPN}/
}


