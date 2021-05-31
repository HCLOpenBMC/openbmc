FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_yosemitev2 = " file://led-group-config.json"

#SYSTEMD_PACKAGES = "${PN}"

SYSTEMD_PACKAGES = "${PN} ${PN}-faultmonitor"
SYSTEMD_SERVICE_${PN}-faultmonitor += "obmc-fru-fault-monitor.service"
#EXTRA_OECONF += " --enable-use-json"
#EXTRA_OECONF += " --enable-monitor-operational-status"
PACKAGECONFIG_append_yosemitev2 = " use-json multi-purpose-monitor"
#PACKAGECONFIG_${PN}-faultmonitor = " multi-purpose-monitor"

do_install_append_yosemitev2() {

    install -m 0755 -d ${D}/usr/share/phosphor-led-manager

    install -m 0644 -D ${WORKDIR}/led-group-config.json \
                   ${D}/usr/share/phosphor-led-manager
}
