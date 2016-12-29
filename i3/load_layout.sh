#!/usr/bin/env bash

# i3-save-tree --workspace 1 | tail -n +2 | fgrep -v "// splitv" | fgrep -v "// splith" | fgrep -v "// tabbed" | sed "s|//||g" > ~/.config/i3/workspace-1.json
# 修改class,instance信息

i3-msg "workspace M; append_layout ~/.config/i3/workspace_N.json"
(uxterm &)

i3-msg "workspace M; append_layout ~/.config/i3/workspace_N.json"
(uxterm &)
