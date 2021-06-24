FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://fileTable.json"
SRC_URI += "file://enum_attrs.json"
SRC_URI += "file://11.json"
SRC_URI += "file://host_eid"


SRC_URI += "file://pldmd.service"

SYSTEMD_SERVICE_${PN} = "pldmd.service"

do_install_append() {
        install -d ${D}$/lib/systemd/system
        install -m 0644 ${WORKDIR}/pldmd.service  ${D}$/lib/systemd/system


        install -d ${D}${datadir}/pldm/bios/
        install -d ${D}${datadir}/pldm/pdr/
        install -m 0644 ${WORKDIR}/fileTable.json ${D}${datadir}/pldm/
        install -m 0644 ${WORKDIR}/enum_attrs.json ${D}${datadir}/pldm/bios/
        install -m 0644 ${WORKDIR}/11.json ${D}${datadir}/pldm/pdr/
        install -m 0644 ${WORKDIR}/host_eid ${D}${datadir}/pldm/
}

FILES_${PN} += "/lib/systemd/system/pldmSoftPowerOff.service"

