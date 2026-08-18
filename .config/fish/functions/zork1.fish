function zork1 --description 'Zork I (frotz)'
    pushd ~/games/if-saves >/dev/null
    frotz "$HOME/.local/share/Steam/steamapps/common/Zork Anthology/Zork/DATA/ZORK1.DAT"
    popd >/dev/null
end
