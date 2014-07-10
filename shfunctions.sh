function battery() {
    acpi -V | head -1 | cut -d',' -f '2,3' | \
              sed -r s/\([0-9]\{2\}%,\ [0-9]\{2\}:[0-9]\{2\}\):[0-9][0-9]/\\1/
}

function volume() {
    pct=$(amixer sget Master | sed -n 5p | \
                                     sed -r s/.*?\\[\([0-9]*\)[0-9]%\\].*/\\1/)
    if [[ -z $pct ]]; then
        echo 'Volume: ['`printf -- '-%.s' $(seq 1 10)`']'
    elif [[ $pct == '10' ]]; then
        echo 'Volume: ['`printf '#%.s' $(seq 1 10)`']'
    else
        ipct=$(echo '10-'$pct | bc)
        echo 'Volume: ['`printf '#%.s' $(seq 1 $pct)``printf -- '-%.s' $(seq 1 $ipct)`']'
    fi
}

function tod() {
    date +'%A, %B %e, %l:%M %p %Z'
}
