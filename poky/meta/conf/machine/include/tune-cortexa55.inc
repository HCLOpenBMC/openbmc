DEFAULTTUNE ?= "cortexa55"

TUNEVALID[cortexa55] = "Enable Cortex-A55 specific processor optimizations"
TUNE_CCARGS .= "${@bb.utils.contains('TUNE_FEATURES', 'cortexa55', ' -mcpu=cortex-a55', '', d)}"

require conf/machine/include/arm/arch-armv8a.inc

# Little Endian base configs
AVAILTUNES += "cortexa55 cortexa55-crypto"
ARMPKGARCH_tune-cortexa55             = "cortexa55"
ARMPKGARCH_tune-cortexa55-crypto      = "cortexa55"
TUNE_FEATURES_tune-cortexa55          = "aarch64 cortexa55 crc"
TUNE_FEATURES_tune-cortexa55-crypto   = "aarch64 cortexa55 crc crypto"
PACKAGE_EXTRA_ARCHS_tune-cortexa55             = "${PACKAGE_EXTRA_ARCHS_tune-armv8a-crc} cortexa55"
PACKAGE_EXTRA_ARCHS_tune-cortexa55-crypto      = "${PACKAGE_EXTRA_ARCHS_tune-armv8a-crc-crypto} cortexa55 cortexa55-crypto"
BASE_LIB_tune-cortexa55               = "lib64"
BASE_LIB_tune-cortexa55-crypto        = "lib64"