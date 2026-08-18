function notes --description "Open the notes vault"
    cd ~/notes; or return 1
    if command -sq git; and test -d .git
        git pull --rebase --quiet 2>/dev/null; or echo "notes: pull failed, working offline"
    end

    # resolve target: no arg → Home; add .md if missing
    set -l target
    if test (count $argv) -eq 0
        set target "_000 Home_.md"
    else if string match -q "*.md" -- $argv[1]
        set target $argv[1]
    else
        set target "$argv[1].md"
    end

    # only open notes that already exist
    if not test -e "$target"
        echo "notes: $target does not exist"
        return 1
    end

    nvim "$target"
end
