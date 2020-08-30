FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " file://phosphor-multi-gpio-monitor.json"

do_install_append() {
    install -m 0644 -D ${WORKDIR}/phosphor-multi-gpio-monitor.json \
                   ${D}/usr/share/phosphor-gpio-monitor
}
