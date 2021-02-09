SUMMARY = "Facebook Ipmi service to monitor and update GPIO's from Ipmi"
DESCRIPTION = "Facebook Ipmi service to monitor and update GPIO's from Ipmi"

SRC_URI = "git://github.com//HCLOpenBMC/openbmc-tools.git"
SRCREV = "cf0cc7569ac0802eb12fe966912214033a70076c"

PV = "1.0+git${SRCPV}"

S = "${WORKDIR}/git/oem-firmware-update"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=86d3f3a95c324c9479bd8986968f4327"

inherit cmake systemd
DEPENDS += " \
    boost \
    i2c-tools \
    libgpiod \
    sdbusplus \
    phosphor-logging \
  "
