#!/usr/bin/env fish

# 1.
# read /tmp/new_bookmark:
# if first line is not an URL, abort
# read URL from first line
# if second line is empty or starts with '#': title is the URL
# otherwise title is the second line
# rest of the non-empty, non-comment lines are tags (each line is a tag)
# print url, title, tags
# delete /tmp/new_bookmark

# 2.
# instead of printing:
# > db: sqlite database for bookmarks
# bookmark: url (pkey), title, tags
# if url already exists: update title and tags
# otherwise add a new row
# then:
# collect all tags from db and write them into ~/.cache/new_bookmark_tags
# format: first line is "# Tags", then each line contains a tag

# use cases for bookmarks:
# 1. list all bookmarks in dmenu
#    show URl, title, tags for each entry in a nice way
#    select -> open URL in firefox new tab
# 2. add new single bookmark / update single bookmark
#    described above
# 3. manage bookmarks
#    for everything that 2. doesn't cover nicely
#    get some sqlite gui/tui for this
