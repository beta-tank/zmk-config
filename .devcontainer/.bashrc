export LS_OPTIONS='-F -la --color=auto'
alias ls='ls $LS_OPTIONS'

Color_Off='\033[0m'       # Text Reset
Green='\033[0;32m'        # Green

build-rt22(){
    base-build nrfmicro_13 rt-22_left
    base-build nrfmicro_13 rt-22_right
}

build-rt22-legacy(){
    base-build nrfmicro_13 rt-22-legacy_left
    base-build nrfmicro_13 rt-22-legacy_right
}

build-chocofi(){
    base-build nrfmicro_13 chocofi_left
    base-build nrfmicro_13 chocofi_right
}

build-tbk-mini(){
    base-build nrfmicro_13_52833 tbk_mini_left
    base-build nrfmicro_13_52833 tbk_mini_right
}

build-reset(){
    base-build nrfmicro_13 settings_reset
}

build-test(){
    base-build nrfmicro_13 test-board
}

build-test-833(){
    base-build nrfmicro_13_52833 test-board
}

build-reset(){
    base-build nrfmicro_13 settings_reset
}

build-reset-833(){
    base-build nrfmicro_13_52833 settings_reset
}

base-build() ( # use subshell
    set -e # to exit the subshell as soon as an error happens
    cd $ZMK_PATH
    rm -rf build # clean buld folder
    west build \
        -s app \
        -d build \
        -b $1 \
        -- -DZMK_CONFIG=$WORKPACE_PATH/config \
        -DSHIELD=$2 # build
    FW_FILE="$WORKPACE_PATH/$BUILD_SUBFOLDER/$2_$1-zmk.uf2"
    rm -rf $FW_FILE # rm FW file in target folder
    mkdir -p $WORKPACE_PATH/$BUILD_SUBFOLDER
    cp build/zephyr/zmk.uf2 $FW_FILE # copy FW to target folder
    echo -e "${Green}SUCCESSFULLY build $FW_FILE${Color_Off}"
)

