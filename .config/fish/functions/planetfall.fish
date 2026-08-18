function planetfall --description 'Planetfall (frotz)'
    pushd ~/games/if-saves >/dev/null
    frotz "$HOME/.local/share/Steam/steamapps/common/Zork Anthology/Planetfall/DATA/PLANETFA.DAT"
    popd >/dev/null
end
