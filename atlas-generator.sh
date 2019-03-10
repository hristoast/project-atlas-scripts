#!/bin/bash

set -e

if [ -z $(which magick 2>/dev/null) ]; then
    echo This script requires a working installation of ImageMagick in \$PATH.
    exit 1
fi

type="${1}"

function usage
{
    cat <<EOF
This script requires one argument, which is the type of texture you want to atlas.

    Usage:

    ${0} (mushrooms | hlaalu | imperial | redoran | urn | velothi | woodpoles)

EOF
    exit 1
}

function target_exists
{
    target_file="${1}"
    if [ -f ATL/"${target_file}" ]; then
        echo "The file '${this_dir}/ATL/${target_file}' already exists.  Move or remove it, then run this script again."
        exit 1
    fi
}

if [ -z "${type}" ]; then
    usage
fi

this_dir=$(realpath $(dirname ${0}))

cd "${this_dir}"

if ! [ -d ATL ]; then
    mkdir ATL
fi

if [ "${type}" == "mushrooms" ]; then
    file1="tx_bc_mushroom_01.dds"
    file2="tx_bc_mushroom_03.dds"
    files_list="tx_bc_fungusbottom_01.dds tx_bc_fungustop_01.dds tx_bc_fungustop_02.dds tx_bc_fungusbottom_02.dds tx_bc_mushroom_04.dds tx_bc_mushroom_01.dds tx_bc_mushroom_02.dds tx_bc_mushroom_02.dds"
    resolutionW=$(magick convert "${file1}" -format \%w info:)
    resolutionH=""
    target_file="tx_bc_mushroom_atlas.dds"

    target_exists "${target_file}"

    magick convert ${file2} ${file2} +append ATL/temp1.bmp
    magick convert ${files_list} ATL/temp1.bmp ATL/temp1.bmp ATL/temp1.bmp -resize $resolutionW -append -define dds:compression=dxt1 ATL/${target_file}

elif [ "${type}" == "hlaalu" ]; then
    file1="tx_hlaalu_wall2_01.dds"
    files_list="tx_hlaalu_wall2_01.dds tx_hlaalu_wall2_02.dds tx_hlaalu_wall2_03.dds tx_hlaalu_sideedge_01.dds tx_hlaalu_topedge_01.dds tx_hlaalu_topedge_02.dds tx_hlaalu_topedge_03.dds"
    resolutionW=$(magick convert "${file1}" -format \%w info:)
    resolutionH=$(expr $resolutionW \* 4)
    target_file="tx_hlaalu_atlas.dds"

    target_exists "${target_file}"

    magick convert ${files_list} -resize ${resolutionW} -append -gravity north -background black -extent x${resolutionH} -define dds:compression=dxt1 ATL/${target_file}

elif [ "${type}" == "imperial" ]; then
    resolutionW=$(magick convert tx_imp_floor_01.dds -format \%w info:)
    target_file="tx_imperial_atlas1.dds"

    target_exists "${target_file}"

    magick convert tx_imp_block_01.dds tx_imp_block_02.dds tx_imp_block_03.dds tx_imp_block_03.dds +append ATL/temp1.bmp

    magick convert tx_imp_botfront_01.dds tx_imp_botfront_01.dds -append ATL/temp2.bmp
    magick convert tx_imp_botside_01.dds tx_imp_botside_01.dds -append ATL/temp3.bmp
    magick convert ATL/temp2.bmp ATL/temp3.bmp +append -rotate "90" ATL/temp4.bmp
    magick convert tx_imp_colthin_01.dds tx_imp_colthin_02.dds tx_imp_colwide_01.dds +append -rotate "90" ATL/temp5.bmp
    magick convert tx_imp_foursquares_01.dds tx_imp_foursquares_01.dds +append ATL/temp6.bmp
    magick convert tx_imp_full_01.dds tx_imp_full_01.dds +append ATL/temp7.bmp
    magick convert tx_imp_half_01.dds tx_imp_half_01.dds tx_imp_half_01.dds tx_imp_half_01.dds +append ATL/temp8.bmp
    magick convert tx_imp_midfront_01.dds tx_imp_midside_01.dds +append ATL/temp9.bmp
    magick convert ATL/temp9.bmp ATL/temp9.bmp ATL/temp9.bmp ATL/temp9.bmp -append -rotate "90" ATL/temp10.bmp
    magick convert tx_imp_plain_01.dds tx_imp_plain_01.dds +append ATL/temp11.bmp
    magick convert tx_imp_stripdark_01.dds tx_imp_stripdark_01.dds +append ATL/temp12.bmp
    magick convert tx_imp_stripmed_01.dds tx_imp_stripmed_01.dds +append ATL/temp13.bmp
    magick convert tx_imp_topfront_01.dds tx_imp_topside_01.dds +append ATL/temp14.bmp
    magick convert ATL/temp14.bmp ATL/temp14.bmp -append -rotate "90" ATL/temp15.bmp

    magick convert tx_imp_archtop_01.dds ATL/temp1.bmp ATL/temp4.bmp tx_imp_ceiling_01.dds tx_imp_ceiling_strip_01.dds tx_imp_ceiling_strip_02.dds  ATL/temp5.bmp tx_imp_floor_01.dds tx_imp_floor_02.dds ATL/temp6.bmp ATL/temp7.bmp ATL/temp8.bmp ATL/temp10.bmp ATL/temp11.bmp tx_imp_step_01.dds tx_imp_step_02.dds tx_imp_step_03.dds tx_imp_step_04.dds tx_imp_step_05.dds tx_imp_step_06.dds tx_imp_step_06.dds ATL/temp12.bmp ATL/temp13.bmp ATL/temp15.bmp -resize ${resolutionW} -append -define dds:compression=dxt1 ATL/${target_file}

    magick convert tx_imp_wall_01.dds tx_imp_wall_02.dds tx_imp_wall_03.dds tx_imp_walltop_01.dds tx_imp_walltop_01.dds tx_imp_walltop_01.dds tx_imp_walltop_01.dds -resize ${resolutionW} -append -define dds:compression=dxt1 ATL/${target_file}

elif [ "${type}" == "redoran" ]; then
    file1="tx_redoran_marble_red.dds"
    files_list=""
    resolutionW=$(magick convert "${file1}" -format \%w info:)
    resolutionH=$(expr $resolutionW \* 4)
    target_file="tx_redoran_atlas.dds"

    target_exists "${target_file}"

    magick convert tx_redoran_barracks_trim.dds tx_redoran_barracks_trim.dds +append ATL/temp1.bmp
    magick convert tx_border_redoran_step_01.dds tx_border_redoran_step_01.dds +append ATL/temp2.bmp
    magick convert tx_block_adobe_white_01.dds tx_block_adobe_white_01.dds +append ATL/temp3.bmp
    magick convert tx_redoran_brokenedge_01.dds tx_redoran_brokenedge_01.dds tx_redoran_brokenedge_01.dds tx_redoran_brokenedge_01.dds +append ATL/temp4.bmp

    magick convert tx_redoran_marble_red.dds tx_redoran_marble_white.dds tx_redoran_tavern_01.dds ATL/temp1.bmp ATL/temp1.bmp ATL/temp2.bmp ATL/temp3.bmp ATL/temp3.bmp -resize ${resolutionW} -append -gravity north -background black -extent x${resolutionH} -define dds:compression=dxt1 ATL/${target_file}

    magick convert tx_redoran_hut_00.dds tx_redoran_hut_00.dds tx_redoran_hut_00.dds ATL/temp1.bmp ATL/temp1.bmp ATL/temp4.bmp ATL/temp4.bmp -resize ${resolutionW} -append -gravity north -background black -extent x${resolutionH} -define dds:compression=dxt1 ATL/tx_redwall_atlas.dds

elif [ "${type}" == "urn" ]; then
    resolutionW=$(magick convert tx_urn_01.dds -format \%w info:)

    magick convert tx_urn_plain_01.dds tx_urn_plain_01.dds +append ATL/temp1.bmp

    magick convert tx_urn_01.dds tx_urn_01.dds tx_urn_top_01.dds ATL/temp1.bmp tx_urn_strip_01.dds tx_urn_strip_01.dds -resize $resolutionW -append -define dds:compression=dxt1 ATL/tx_urns_atlas.dds

elif [ "${type}" == "velothi" ]; then
    file1="tx_v_floor_01.dds"
    file2="tx_v_bridgedetail_04.dds"
    resolutionW=$(magick convert "${file1}" -format \%w info:)
    resolutionH=$(expr $resolutionW \* 16)

    magick convert tx_block_adobe_redbrown_01.dds tx_block_adobe_redbrown_01.dds +append ATL/temp1.bmp

    resolutionBH=$(magick convert "${file2}" -format \%h info)
    resolutionBW=$(magick convert "${file2}" -format \%w info:)
    if [ "${resolutionBH}" != "${resolutionBW}" ]; then
        magick convert tx_v_bridgedetail_04.dds -define dds:compression=dxt1 -gravity north -background black -extent x${resolutionBW} tx_v_bridgedetail_04.dds
    fi

    magick convert tx_v_bridgedetail_04.dds tx_v_bridgedetail_04.dds +append ATL/temp2.bmp
    magick convert ATL/temp1.bmp ATL/temp2.bmp tx_v_floor_01.dds tx_v_entcover_01.dds tx_v_bridgedetail_03.dds tx_v_bridgedetail_01.dds tx_v_base_10.dds tx_v_base_09.dds tx_v_base_07.dds tx_v_base_04.dds tx_v_base_02.dds tx_v_base_01.dds tx_v_strip_02.dds tx_v_strip_04.dds tx_v_strip_03.dds tx_v_strip_01.dds tx_v_base_08.dds tx_wall_adobe_brown_02.dds tx_v_b_base_01.dds -resize $resolutionW -append -gravity south -background black -extent x${resolutionH} -define dds:compression=dxt1 ATL/atlas_velothi.dds

elif [ "${type}" == "woodpoles" ]; then
    resolutionH=$(magick convert tx_wood_brown_posts_02.dds -format \%w info:)
    resolutionHalf=$(echo $(( resolutionH / 2 )))

    magick convert tx_wood_brown_rings_01.dds Tx_wood_dock_rings.dds -resize $resolutionHalf -append ATL/temp1.bmp
    magick convert tx_wood_wethered.dds -rotate "90" ATL/temp2.bmp
    magick convert -size 6x8 xc:black ATL/temp3.bmp
    magick convert tx_rope_brown_02.dds tx_rope_brown_02.dds -append ATL/temp4.bmp
    magick convert tx_rope_heavy.dds -rotate "90" ATL/temp5.bmp

    magick convert tx_wood_brown_posts_02.dds ATL/temp1.bmp ATL/temp2.bmp ATL/temp3.bmp ATL/temp4.bmp ATL/temp5.bmp -resize x${resolutionH} +append -define dds:compression=dxt1 ATL/atlas_woodpoles.dds
fi

rm -f "${this_dir}"/ATL/temp*.bmp

echo "Conversion of '${type}' is completed:  $(ls -1 ${this_dir}/ATL/*_atlas.dds)"
