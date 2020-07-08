#!/bin/bash -l

output_name () {
	: '
	arguments:
		1- filepath (from find_files)

	checks out_dir if empty or not
		- if empty, returns :
			dirname + filename + `.min` + file_extension
			eg: /js/a/ + main + .min + .js
		- if not empty, returns:
			out_dir + sub_dir + filename + `.min` + file_extension
			eg: /min_js/ + /a/ + main + .min + .js

	> note : sub_dir = dirname $1 - in_path
	'
	f_name=$( basename $1 | grep -oP '^.*(?=\.)' )
	f_extn=$( basename $1 | grep -oP '\.[^\.]*$' )

	f_dir=$( dirname $1 | xargs readlink -m )
	# assume that in_dir is `js/*` directly, so we want
	# first dirname or the list of its files inside it
	in_path=$( dirname $in_dir | head -1 | xargs readlink -m )
	# but if it is just a `js/`, we need its full path
	# not just the dirname, but also the basename with it
	if [ -d "${in_dir}" ]; then
		in_path=$f_dir
	fi

	f_path=$f_dir
	if [ ! -z $out_dir ]; then
		f_path="$out_dir/${f_dir#"$in_path"}"
	fi

	echo "$f_path/$f_name.min$f_extn" | xargs readlink -m
}

find_files () {
	: '
	arguments:
		1- js | css (supported file extension)

	find all files of certain type inside in_dir
		- `-maxdepth` helps us specify only specified scope
		- `find` returns the relative path, which is needed
		- `*` acts as a recursive operator

	Piped into grep to get all non minified files
	'
	find $in_dir -maxdepth 1 -type f -name "*.$1" | grep -v ".min.$1$"
}

exec_minify_cmd () {
	: '
	arguments: 
		1- input file
		2- output file

	returns the command needed to minify the file
	depending on what type the file is (its extension)
	'
	file=$1
	out=$2

	if [[ $file == *.js ]]; then
		npx minify $file --out-file $out
	elif [[ $file == *.css ]]; then
		npx cleancss -o $out $file
	fi
}

minify_file () {
	: '
	arguments:
		1- input file

	checks the file type (whether css or js)
	then creates the output file of that file
	then minifies the file with a specific command
	then checks if the command returned an error
	if it did, program exits with that error code
	'
	file=$( readlink -m $1 )
	out=$( output_name $file )

	echo "Minify : $file -> $out"

	exec_minify_cmd $file $out
}

cd /app/

dir="/github/workspace"

in_dir="$dir/$INPUT_DIRECTORY"

out_dir=""
if [ ! -z $INPUT_OUTPUT ]; then
	out_dir="$dir/$INPUT_OUTPUT"
fi

if [ ! -z $out_dir ]; then
	# create output directories if they don't exist
	mkdir -p $out_dir
fi

js_files=$( find_files 'js' )
css_files=$( find_files 'css' )

set -e

for file in $js_files; do
	minify_file $file
done

for file in $css_files; do
	minify_file	$file
done