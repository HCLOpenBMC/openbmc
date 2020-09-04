FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " file://phosphor-multi-gpio-monitor.json"
SRC_URI_append = " file://hand_switch_position1.service"
SRC_URI_append = " file://hand_switch_position2.service"
SRC_URI_append = " file://hand_switch_position3.service"
SRC_URI_append = " file://hand_switch_position4.service"

SYSTEMD_SERVICE_${PN}_append_yosemitev2 = " hand_switch_position1.service"
SYSTEMD_SERVICE_${PN}_append_yosemitev2 = " hand_switch_position2.service"
SYSTEMD_SERVICE_${PN}_append_yosemitev2 = " hand_switch_position3.service"
SYSTEMD_SERVICE_${PN}_append_yosemitev2 = " hand_switch_position4.service"

do_install_append() {
    install -m 0644 -D ${WORKDIR}/phosphor-multi-gpio-monitor.json \
                   ${D}/usr/share/phosphor-gpio-monitor

    install -m 0644 -D ${WORKDIR}/hand_switch_position1.service \
                   ${D}/lib/systemd/system

    install -m 0644 -D ${WORKDIR}/hand_switch_position2.service \
                   ${D}/lib/systemd/system

    install -m 0644 -D ${WORKDIR}/hand_switch_position3.service \
                   ${D}/lib/systemd/system

    install -m 0644 -D ${WORKDIR}/hand_switch_position4.service \
                   ${D}/lib/systemd/system
   
}

FILES_${PN} += "/lib/systemd/system"
FILES_${PN} += "/usr/share/phosphor-gpio-monitor"
FILES_${PN} += "/usr/bin/hand_switch_position.sh"

