#!/usr/bin/env fish

set filename /tmp/new_bookmark

set input (cat $filename)
if [ -z "$input" ]
    echo "/tmp/new_bookmark file is empty or missing - aborting"
    exit 1
end

set lines (string split \n $input)

set url $lines[1]
set title $lines[2]
set tags $lines[3..]

set tags2 (string join '...' $tags)

if ! string match --quiet --regex "^(http://|https://)" "$url"
    echo "first line is not an URL - aborting"
    exit 1
end

if string match --quiet --regex "^[^#].*\S+" "$title"
    set title (string trim "$title")
else
    set title "$url"
end

set parsed_tags ""

for tag in $tags
    if string match --quiet --regex "^[^#].*\S+" "$tag"
        set parsed_tags "$parsed_tags$tag;"
    end
end

echo "url: $url"
echo "title: $title"
echo "tags: $parsed_tags"

rm $filename

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
