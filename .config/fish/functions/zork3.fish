function zork3 --description 'Zork III (frotz)'
    pushd ~/games/if-saves >/dev/null
    frotz "$HOME/.local/share/Steam/steamapps/common/Zork Anthology/Zork3/DATA/ZORK3.DAT"
    popd >/dev/null
end
