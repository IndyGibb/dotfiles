function zork2 --description 'Zork II (frotz)'
    pushd ~/games/if-saves >/dev/null
    frotz "$HOME/.local/share/Steam/steamapps/common/Zork Anthology/Zork2/DATA/ZORK2.DAT"
    popd >/dev/null
end
