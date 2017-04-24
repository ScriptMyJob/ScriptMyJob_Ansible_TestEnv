#!/bin/bash
set -e

#######################################
### Main Function #####################
#######################################

main_function(){
    (
        list_envs &&
        print "README.md" orange &&
        markdown_eval README.md
    ) | less -R;
}

#######################################
### Generic Functions #################
#######################################

print(){
    # opted against $_ and $! for this usage
    last="${!#}"
    output="$1";
    size="${#output}";

    # Colors pulled from ansi-color script
    ######################################
    case "$2" in
        red)
            color="196"
            ;;
        orange)
            color="202"
            ;;
        yellow)
            color="226"
            ;;
        green)
            color="46"
            ;;
        blue)
            color="27"
            ;;
        indigo)
            color="21"
            ;;
        violet)
            color="54"
            ;;
        dark-grey)
            color="236"
            ;;
        grey)
            color="8"
            ;;
        *)
            color="0"
            ;;
    esac

    printf -v sep "%${size}s" "-";

    [[ "$last" == "--nosep" ]] && {
        printf "\e[38;5;%dm%s\e[0m\n" "$color" "$output";
        return;
    };

    printf "\n\e[38;5;%dm%s\e[0m\n%s\n" "$color" "$output" "${sep// /-}";

};

#######################################
### Program Specific Functions ########
#######################################

list_envs(){
    print "Current Vagrant environments:" orange
    find ./Vagrant \
        -d 1 \
        -name "Env*" \
        -type d | while read -r folder; do
            printf "%s - %s\n" "$folder" "$(cat "$folder/about.txt")"
        done
}

markdown_eval(){
    file="$1"
    code_block=false

    while read -r line; do

        [[ "$line" == '``` bash' ]] && code_block=true && continue;

        if  [[ "$code_block" == true ]]; then
            [[ "$line" == '```' ]] && 
                code_block=false && 
                    continue;
            print "  $line" red --nosep;

        elif [[ "$line" =~ ^\#\#\#  ]]; then
            line=${line##*\#\ }
            print "$line" violet --nosep && 
                continue;

        elif [[ "$line" =~ ^\#\#  ]]; then
            line=${line##*\#\ }
            print "$line" blue && 
                continue;

        elif [[ "$line" =~ ^\#  ]]; then
            line=${line##*\#\ }
            print "$line" green

        else
            printf "%s\n" "$line"
        fi

    done < "$file"

#        sed "
#         s,\`\`\`\ bash$, $(printf '\e[33m'),;
#         s,\`\`\`, $(printf "\e[0m"),
#     " "$file"
}

#######################################
### Execution #########################
#######################################

main_function;
