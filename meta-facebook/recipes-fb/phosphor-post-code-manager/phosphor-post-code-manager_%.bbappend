FILESEXTRAPATHS_prepend_yosemitev2 := "${THISDIR}/${PN}:"

SYSTEMD_SERVICE_${PN}_append_yosemitev2 = " xyz.openbmc_project.State.Boot.PostCode@1.service \
                                            xyz.openbmc_project.State.Boot.PostCode@2.service \
                                            xyz.openbmc_project.State.Boot.PostCode@3.service \
                                            xyz.openbmc_project.State.Boot.PostCode@4.service "

