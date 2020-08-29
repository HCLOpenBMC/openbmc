SUMMARY = "Facebook Ipmi service to monitor and update GPIO's from Ipmi"
DESCRIPTION = "Facebook Ipmi service to monitor and update GPIO's from Ipmi"

SRC_URI = "git://github.com/HCLOpenBMC/fb-ipmi"
SRCREV = "33fe63494f13655d7baddf427c42fc856ba5514d"

PV = "1.0+git${SRCPV}"

S = "${WORKDIR}/git"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=86d3f3a95c324c9479bd8986968f4327"

inherit cmake systemd

SYSTEMD_SERVICE_${PN} += "xyz.openbmc_project.Chassis.Control.Misc.service"

DEPENDS += " \
    boost \
    i2c-tools \
    libgpiod \
    sdbusplus \
    phosphor-logging \
    nlohmann-json \
  "

