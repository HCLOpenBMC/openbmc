FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}/${MACHINE}:"

SERVICE_FILE = "lpcsnoop.service"
SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE_${PN} += "${SERVICE_FILE}"

NUMBER_OF_HOST ?= "4"

#EXTRA_OEMESON += "-Dpost-code-bytes=false "





