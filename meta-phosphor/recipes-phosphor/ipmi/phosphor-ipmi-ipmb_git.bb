SUMMARY = "IPMB bridge"
DESCRIPTION = "The IPMB bridge implements a Dbus compliant interface for \
implementing IPMB interfaces"

SRC_URI = "git://github.com/openbmc/ipmbbridge.git"
SRCREV = "09027c0e07c5ec4a426a3106f0dbcff99610dc1f"
PV = "0.1+git${SRCPV}"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=e3fc50a88d0a364313df4b21ef20c29e"

SYSTEMD_SERVICE_${PN} = "ipmb.service"

DEPENDS = "sdbusplus \
           phosphor-logging \
           i2c-tools \
           boost \
           nlohmann-json"

S = "${WORKDIR}/git/"
inherit cmake systemd
FILES_${PN} += "/usr/share/ipmbbridge/ipmb-channels.json"
