EXTRA_OEMESON_append = " \
    -Dinsecure-tftp-update=enabled \
"

inherit obmc-phosphor-discovery-service

REGISTERED_SERVICES_${PN} += "obmc_redfish:tcp:443:"
REGISTERED_SERVICES_${PN} += "obmc_rest:tcp:443:"
