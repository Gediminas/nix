fname=$1

# #test
# cp $1 /tmp/last
# fname=/tmp/last
# ls $resurrect_dir/last

# sed -ie "s| --cmd .*-vim-pack-dir||g" $1
sed -ie "s| --cmd lua vim.* | |g" $fname

sed -i 's|fish	:\[fish\] <defunct>|fish	:|g' $fname
sed -i ':a;N;$!ba;s|\[fish\] <defunct>\n||g' $fname
sed -i "s|/run/current-system/sw/bin/||g" $fname
sed -i "s| $HOME| ~|g" $fname

sed -ie "s|^state.*$|state	SYSTEM|" $fname
# sed -i "s|~|$HOME|g" $fname

# #test
# cat $fname


#sed -ie "s|:bash .*/tmp/nix-shell-.*/rc|:nix-shell|g" $1

#line_type
#session_name
#window_number
#window_active
#window_flags
#pane_index

#pane_title
#dir
#pane_active
#pane_command
#full_command
