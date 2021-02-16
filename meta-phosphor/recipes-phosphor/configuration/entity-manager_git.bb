SUMMARY = "Entity Manager"
DESCRIPTION = "Entity Manager provides d-bus configuration data \
and configures system sensors"

#SRC_URI = "git://github.com/openbmc/entity-manager.git file://blocklist.json"
#SRCREV = "f094125cd3bdbc8737dc8035a6e9ac252f6e8840"

SRC_URI = "git://github.com/HCLOpenBMC/entity-manager.git;protocol=http;branch=YV2-Demo-22Oct file://blocklist.json"
SRCREV = "9a46f7ae16be1cd0936a337046f0c2ddb61fffe4"
PV = "0.1+git${SRCPV}"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENCE;md5=a6a4edad4aed50f39a66d098d74b265b"

DEPENDS = "boost \
           dbus \
           nlohmann-json \
           sdbusplus \
           valijson"

S = "${WORKDIR}/git"
inherit meson systemd

EXTRA_OEMESON = "-Dtests=disabled"

PACKAGECONFIG ??= "ipmi-fru"
PACKAGECONFIG[ipmi-fru] = "-Dfru-device=true, -Dfru-device=false, i2c-tools,"

EXTRA_ENTITY_MANAGER_PACKAGES = " \
    ${@bb.utils.contains('PACKAGECONFIG', 'ipmi-fru', 'fru-device', '', d)} \
    "

PACKAGE_BEFORE_PN = "${EXTRA_ENTITY_MANAGER_PACKAGES}"

do_install_append() {
    install -D ${WORKDIR}/blocklist.json ${D}${datadir}/${BPN}/blacklist.json
}

FILES_${PN} += " \
    ${datadir}/dbus-1/system-services/xyz.openbmc_project.EntityManager.service \
    "
FILES_fru-device = "${bindir}/fru-device ${datadir}/${BPN}/blacklist.json"

SYSTEMD_PACKAGES = "${PN} ${EXTRA_ENTITY_MANAGER_PACKAGES}"
SYSTEMD_SERVICE_${PN} = "xyz.openbmc_project.EntityManager.service"
SYSTEMD_SERVICE_fru-device = "xyz.openbmc_project.FruDevice.service"
SYSTEMD_SERVICE_fru-device += "xyz.openbmc_project.Ipmb.FruDevice.service"
SYSTEMD_AUTO_ENABLE_fru-device_ibm-power-cpu = "disable"
