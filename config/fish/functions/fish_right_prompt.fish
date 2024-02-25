
function fish_right_prompt
  set -l last_status $status
  set -l stat
  if test $last_status -ne 0
    set stat (set_color red)"[$last_status]"(set_color normal)
  end

  string join '' -- $stat (fish_git_prompt)
end
