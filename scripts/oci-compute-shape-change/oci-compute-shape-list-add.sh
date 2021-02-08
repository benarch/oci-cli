cat oci_shapes.txt| grep . |
while read shape; do
oci compute image-shape-compatibility-entry add --image-id "<image-id>" --shape-name "$shape"
done