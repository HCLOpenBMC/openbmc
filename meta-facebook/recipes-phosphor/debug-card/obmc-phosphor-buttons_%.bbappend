FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}/${MACHINE}:"

SRC_URI_append = " file://gpio_defs.json"


EXTRA_OECMAKE_append ="-DMULTI_HOST_FRONTPANEL=1"
EXTRA_OECMAKE_append +="-DCHASSIS_SYSTEM_RESET_ENABLED=1"
EXTRA_OECMAKE_append +="-DTOTAL_NUMBER_OF_HOST=4"


SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE_${PN} = "phosphor-button-handler.service xyz.openbmc_project.Chassis.Buttons.service"

do_install_append() {

     install -m 0755 -d ${D}/etc/default/obmc/gpio
     install -m 0644 -D ${WORKDIR}/gpio_defs.json \
                   ${D}/etc/default/obmc/gpio

}
