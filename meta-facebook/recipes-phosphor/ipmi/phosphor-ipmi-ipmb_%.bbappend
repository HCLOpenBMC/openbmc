FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}/${MACHINE}:"

SRC_URI_append = " file://ipmb-channels.json"

SYSTEMD_SERVICE_${PN} += "ipmb@0.service \
                          ipmb@1.service \
                          ipmb@2.service \
                          ipmb@3.service"

do_install_append() {
    install -m 0644 -D ${WORKDIR}/ipmb-channels0.json \
                   ${D}/usr/share/ipmbbridge
    install -m 0644 -D ${WORKDIR}/ipmb-channels1.json \
                   ${D}/usr/share/ipmbbridge
    install -m 0644 -D ${WORKDIR}/ipmb-channels2.json \
                   ${D}/usr/share/ipmbbridge
    install -m 0644 -D ${WORKDIR}/ipmb-channels3.json \
                   ${D}/usr/share/ipmbbridge
}
