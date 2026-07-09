#!/usr/bin/env bash

# BS month lengths for years 2080-2086
declare -A bs_months
bs_months[2079]="31 31 32 32 31 30 30 29 30 29 30 30"
bs_months[2080]="31 32 31 32 31 30 30 30 29 30 29 31"
bs_months[2081]="31 31 31 32 32 31 30 29 30 29 30 30"
bs_months[2082]="31 32 31 32 31 30 30 30 29 30 29 31"
bs_months[2083]="31 31 32 31 32 30 31 29 30 29 30 30"
bs_months[2084]="31 31 32 32 31 30 30 29 30 29 30 30"
bs_months[2085]="31 32 31 32 31 30 30 30 29 30 29 31"
bs_months[2086]="31 31 31 32 32 31 30 29 30 29 30 30"

months_np=("बैशाख" "जेठ" "असार" "श्रावण" "भाद्र" "आश्विन" "कार्तिक" "मंसिर" "पुष" "माघ" "फागुन" "चैत्र")
days_np=("आइत" "सोम" "मंगल" "बुध" "बिही" "शुक्र" "शनि")

# Get today in BS using anchor
anchor_ad="2024-04-12"
anchor_bs_y=2081; anchor_bs_m=1; anchor_bs_d=1

today=$(date +%Y-%m-%d)
days_diff=$(( ( $(date -d "$today" +%s) - $(date -d "$anchor_ad" +%s) ) / 86400 ))

bs_y=$anchor_bs_y; bs_m=$anchor_bs_m; bs_d=$anchor_bs_d
bs_d=$(( bs_d + days_diff ))

while true; do
    lengths=( ${bs_months[$bs_y]} )
    month_len=${lengths[$((bs_m-1))]}
    if (( bs_d > month_len )); then
        bs_d=$(( bs_d - month_len ))
        bs_m=$(( bs_m + 1 ))
        if (( bs_m > 12 )); then bs_m=1; bs_y=$(( bs_y + 1 )); fi
    else
        break
    fi
done

today_bs_d=$bs_d
today_bs_m=$bs_m
today_bs_y=$bs_y

# Get day of week for 1st of current BS month
# Go back (today_bs_d - 1) days from today
first_day_ad=$(date -d "$today - $((today_bs_d - 1)) days" +%u)
# %u = 1(Mon)..7(Sun), we want 0=Sun..6=Sat
dow=$(( first_day_ad % 7 ))

# Build calendar
lengths=( ${bs_months[$bs_y]} )
month_len=${lengths[$((bs_m-1))]}
month_name="${months_np[$((bs_m-1))]}"

# Header
output="${month_name} ${bs_y}\n"
output+="आइत  सोम  मंगल  बुध  बिही  शुक्र  शनि\n"
output+="─────────────────────────────────────\n"

# Leading spaces
line=""
for (( i=0; i<dow; i++ )); do
    line+="     "
done

col=$dow
for (( d=1; d<=month_len; d++ )); do
    if (( d == today_bs_d )); then
        line+=$(printf "[%2d]  " $d)
    else
        line+=$(printf " %2d   " $d)
    fi
    col=$(( col + 1 ))
    if (( col % 7 == 0 )); then
        output+="${line}\n"
        line=""
    fi
done

if [[ -n "$line" ]]; then
    output+="${line}\n"
fi

output+="─────────────────────────────────────\n"
output+="आज: ${month_name} ${today_bs_d}, ${today_bs_y}"

echo -e "$output" | rofi \
    -dmenu \
    -p "📅 नेपाली पात्रो" \
    -no-custom \
    -theme-str '
    window {
        width: 380px;
        background-color: rgba(12,13,20,0.96);
        border: 1px solid rgba(255,255,255,0.08);
        border-radius: 14px;
        padding: 10px;
    }
    mainbox { background-color: transparent; }
    inputbar { background-color: transparent; padding: 6px 10px; }
    prompt {
        background-color: transparent;
        text-color: #f9e2af;
        font: "JetBrainsMono Nerd Font 11";
    }
    entry { background-color: transparent; text-color: transparent; }
    listview {
        background-color: transparent;
        scrollbar: false;
        lines: 12;
        fixed-height: true;
    }
    element {
        background-color: transparent;
        text-color: #cdd6f4;
        font: "JetBrainsMono Nerd Font 11";
        padding: 2px 8px;
    }
    element selected {
        background-color: transparent;
        text-color: #cdd6f4;
    }
    '