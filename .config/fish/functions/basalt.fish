function basalt --description "Launch Basalt in an opaque terminal"
    if set -q BASALT_OPAQUE
        command basalt $argv
    else
        BASALT_OPAQUE=1 ghostty --background-opacity=1 -e basalt $argv
    end
end
