# Switch git branch interactively
#
# If the selected branch has a worktree associated with it, gb will cd to it,
# instead of trying to check it out. If trying to check out a remote branch, an
# appropriately named local tracking branch will be created for it. Branches
# are always checked out from the main worktree; linked worktrees will always
# point to the branch they were originally created for. It is assumed that
# worktrees are always created via gb and not through any other means.
#
# -h,--help: show help
# -w,--as-worktree: if the branch does not already have a worktree associated
#   with it, create a worktree for it, as a sibling of the main worktree. Then,
#   switch to the worktree
# NAME: exact name of a branch to switch to
function gb
    argparse h/help w/as-worktree -- $argv
    or return

    if set -q _flag_help
        echo "Usage: gb [-h | --help] [-w | --as-worktree] [NAME]" >&2
        return 1
    end

    # Die if not in a git repository
    if ! set git_dir (git rev-parse --path-format=absolute --git-common-dir)
        return 1
    end

    # If branch name is given, use it; otherwise, ask user for branch name via fzf
    if [ "$argv[1]" ]
        set branch "$argv[1]"
        set worktree_branch (string match --quiet "branch refs/heads/$branch" \
            (git worktree list --porcelain) \
            && echo "$branch")
    else
        if set -q _flag_as_worktree
            set header "Switching to worktree"
        else
            set header "Switching to branch or worktree"
        end

        set branch (git branch --all \
          | fzf --header "$header" --header-first \
          | string replace --regex "\* |  " "")
        [ -z "$branch" ] && return 0
        set worktree_branch (string replace --filter "+ " "" "$branch")
    end

    # If selected branch is already checked out in a worktree, just cd to it
    if [ "$worktree_branch" ]
        set worktrees (git worktree list --porcelain)

        set i 3
        while true
            set line "$worktrees[$i]"
            [ -z "$line" ] && break
            if string match --entire --quiet "$worktree_branch" "$line"
                set worktree_path (string split --fields 2 " " "$worktrees[$(math $i - 2)]")
            end
            set i (math $i + 4)
        end

        if [ "$worktree_path" ]
            if [ (pwd) != "$worktree_path" ]
                cd "$worktree_path"
                echo "Switched to worktree '$worktree_branch'"
            end
            return 0
        else
            echo "Could not find the directory of worktree '$worktree_branch'"
            return 1
        end
    end

    # Abort if trying to checkout the current commit when HEAD is detached
    # This is necessary because comparison with the current branch does
    # not work in this case (detached HEAD is not a branch)
    if string match --entire --quiet HEAD "$branch"
        return 0
    end

    # Already on the branch; nothing to do
    if [ "$branch" = "$(git branch --show-current)" ]
        return 0
    end

    set main_worktree (path resolve "$git_dir/..")
    set repo_name (path basename "$main_worktree")
    set in_linked_worktree (string match --entire "/.git/worktrees/" (git rev-parse --git-dir))

    # We want to check out branches from the main working tree
    # Linked working trees should always point to the branch for which they
    # were originally created for
    if [ "$in_linked_worktree" -a \(! (set -ql _flag_as_worktree)\) ]
        cd "$main_worktree"
    end

    set remote_regex "^remotes/($(git remote | string join "|" | string replace -a '/' '\\/'))/"

    # If a remote branch is selected, we set up a new tracking branch for it
    set is_remote_branch (string match --regex "$remote_regex" "$branch")
    set local_branch_name (string replace --regex "$remote_regex" "" "$branch")
    if [ "$is_remote_branch" ]
        set git_opts --track -b $local_branch_name
    end

    if set -q _flag_as_worktree
        set sanitized_branch_name (string replace --regex --all '/|\\\\' '_' "$local_branch_name")
        set worktree_dirname (printf "%s__%s" "$repo_name" "$sanitized_branch_name")
        set worktree_path (path resolve "$main_worktree/../$worktree_dirname")
        eval "git worktree add $git_opts $worktree_path $branch" && cd "$worktree_path"
    else
        eval "git checkout $git_opts $branch"
    end
end
