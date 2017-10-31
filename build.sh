#!/bin/bash
set -e

[ -f *.snap ] && rm *.snap || true
[ -f *.assert ] && rm *.assert || true
[ -d squashfs-root ] && rm -rf squashfs-root || true

snap download nextcloud
snap=(*.snap)
snapout="${snap%%.snap}-fixup.snap"

unsquashfs "$snap"
(cd squashfs-root && patch -p1 < ../fixup.patch)
mksquashfs squashfs-root "$snapout"

echo ""
echo "Done. Install using:"
echo "  snap install --dangerous $snapout"
