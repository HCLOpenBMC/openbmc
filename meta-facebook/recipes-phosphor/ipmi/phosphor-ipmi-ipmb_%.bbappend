FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}/${MACHINE}:"

SRC_URI_append = " file://ipmb-channels.json"

do_install_append() {
    install -m 0644 -D ${WORKDIR}/ipmb-channels.json \
                   ${D}/usr/share/ipmbbridge
}

FILESEXTRAPATHS_prepend_yosemitev2 := "${THISDIR}/${PN}:"

SRC_URI_append_yosemitev2 = " file://ipmb-yosemitev2-channels.json"

do_install_append_yosemitev2(){
    install -m 0644 -D ${WORKDIR}/ipmb-yosemitev2-channels.json \
                   ${D}/usr/share/ipmbbridge/ipmb-channels.json
}
