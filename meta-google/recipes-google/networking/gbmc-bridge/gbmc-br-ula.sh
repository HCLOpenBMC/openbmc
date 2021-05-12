# Copyright 2021 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

[ -z "${gbmc_br_ula_lib-}" ] || return

source /usr/share/network/lib.sh || exit

gbmc_br_ula_init=
gbmc_br_ula_mac=

gbmc_br_ula_update() {
  [ -n "$gbmc_br_ula_init" ] || return

  echo "gBMC Bridge ULA MAC: ${gbmc_br_ula_mac:-(deleted)}" >&2

  local addr=
  contents='[Network]'$'\n'
  if [ -n "$gbmc_br_ula_mac" ]; then
    local eui64
    eui64="$(mac_to_eui64 "$mac")" || return
    addr="fdb5:0481:10ce:0:$eui64/64"
    contents+="Address=$addr"$'\n'
  fi

  local netfile
  for netfile in /run/systemd/network/{00,}-bmc-gbmcbr.network.d/60-ula.conf; do
    mkdir -p -m 755 "$(dirname "$netfile")"
    printf '%s' "$contents" >"$netfile"
  done

  # We have to add the address after writing the systemd config to ensure we
  # don't race with reconfiguration and drop the address.
  if [ -n "$addr" ]; then
    ip addr replace "$addr" dev gbmcbr
  fi
}

gbmc_br_ula_hook() {
  if [ "$change" = 'init' ]; then
    gbmc_br_ula_init=1
    gbmc_br_ula_update
  elif [ "$change" = 'link' -a "$intf" = 'gbmcbr' ]; then
    if [ "$action" = 'add' -a "$mac" != "$gbmc_br_ula_mac" ]; then
      gbmc_br_ula_mac="$mac"
      gbmc_br_ula_update
    fi
    if [ "$action" = 'del' -a "$mac" = "$gbmc_br_ula_mac" ]; then
      gbmc_br_ula_mac=
      gbmc_br_ula_update
    fi
  fi
}

GBMC_IP_MONITOR_HOOKS+=(gbmc_br_ula_hook)

gbmc_br_ula_lib=1
