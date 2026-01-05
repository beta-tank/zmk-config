export LS_OPTIONS='-F -la --color=auto'
alias ls='ls $LS_OPTIONS'

Color_Off='\033[0m'       # Text Reset
Green='\033[0;32m'        # Green

build-rt22(){
    base-build nrfmicro/nrf52840 rt-22_left
    base-build nrfmicro/nrf52840 rt-22_right
}

build-rt22-nn(){
    base-build nice_nano rt-22_left
    base-build nice_nano rt-22_right
}

build-rt22-legacy(){
    base-build nrfmicro/nrf52840 rt-22-legacy_left
    base-build nrfmicro/nrf52840 rt-22-legacy_right
}

build-chocofi(){
    base-build nrfmicro/nrf52840 chocofi_left
    base-build nrfmicro/nrf52840 chocofi_right
}

build-tbk-mini(){
    base-build nrfmicro/nrf52833 tbk_mini_left
    base-build nrfmicro/nrf52833 tbk_mini_right
}

build-test(){
    base-build nrfmicro/nrf52840 test-board
}

build-test-833(){
    base-build nrfmicro/nrf52833 test-board
}

build-test-nn(){
    base-build nice_nano test-board
}

build-reset(){
    base-build nrfmicro/nrf52840 settings_reset
}

build-reset-833(){
    base-build nrfmicro/nrf52833 settings_reset
}

build-reset-nn(){
    base-build nice_nano settings_reset
}

base-build() ( # use a subshell
    set -e # to exit the subshell as soon as an error happens
    cd $ZMK_PATH
    rm -rf build # clean the build folder
    west build \
        -s app \
        -d build \
        -b $1 \
        -- -DZMK_CONFIG=$WORKPACE_PATH/config \
        -DSHIELD=$2 # build
    FW_FILE="$WORKPACE_PATH/$BUILD_SUBFOLDER/${2//\//_}_${1//\//_}-zmk.uf2"
    rm -rf $FW_FILE # remove the FW file from the target folder
    mkdir -p $WORKPACE_PATH/$BUILD_SUBFOLDER
    cp build/zephyr/zmk.uf2 $FW_FILE # copy FW to the target folder
    echo -e "${Green}SUCCESSFULLY build $FW_FILE${Color_Off}"
)

