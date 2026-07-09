#!/usr/bin/env bash
# Converts today's Gregorian date to Bikram Sambat (Nepali calendar)

to_bs() {
  local year=$1 month=$2 day=$3

  declare -A bs_months
  bs_months[2079]="31 31 32 32 31 30 30 29 30 29 30 30"
  bs_months[2080]="31 32 31 32 31 30 30 30 29 30 29 31"
  bs_months[2081]="31 31 31 32 32 31 30 29 30 29 30 30"
  bs_months[2082]="31 32 31 32 31 30 30 30 29 30 29 31"
  bs_months[2083]="31 31 32 31 32 30 31 29 30 29 30 30"
  bs_months[2084]="31 31 32 32 31 30 30 29 30 29 30 30"
  bs_months[2085]="31 32 31 32 31 30 30 30 29 30 29 31"

  local anchor_ad_y=2024 anchor_ad_m=4 anchor_ad_d=12
  local anchor_bs_y=2081 anchor_bs_m=1 anchor_bs_d=1

  local days=$(( ( $(date -d "$year-$month-$day" +%s) - $(date -d "$anchor_ad_y-$anchor_ad_m-$anchor_ad_d" +%s) ) / 86400 ))

  local bs_y=$anchor_bs_y
  local bs_m=$anchor_bs_m
  local bs_d=$anchor_bs_d

  if (( days >= 0 )); then
    bs_d=$(( bs_d + days ))
    while true; do
      local lengths=( ${bs_months[$bs_y]} )
      local month_len=${lengths[$((bs_m - 1))]}
      if (( bs_d > month_len )); then
        bs_d=$(( bs_d - month_len ))
        bs_m=$(( bs_m + 1 ))
        if (( bs_m > 12 )); then
          bs_m=1
          bs_y=$(( bs_y + 1 ))
        fi
      else
        break
      fi
    done
  fi

  local months_np=("बैशाख" "जन्म महिना" "असार" "श्रावण" "भाद्र" "आश्विन" "कार्तिक" "मंसिर" "पुष" "माघ" "फागुन" "चैत्र")
  echo "${months_np[$((bs_m-1))]} $bs_d, $bs_y"
}

read y m d <<< $(date "+%Y %m %d")
result=$(to_bs $y $((10#$m)) $((10#$d)))
echo "󰸗 $result" 