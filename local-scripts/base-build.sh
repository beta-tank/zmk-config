cd ../../zmk
rm -rf build/temp
west build -s app -d build/temp -b $1 \
  -- -DZMK_CONFIG=/workspaces/zmk-config/config -DSHIELD=$2
cp build/temp/zephyr/zmk.uf2 "build/$2_$1-zmk.uf2"   