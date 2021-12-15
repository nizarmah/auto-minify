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

		mkdir -p $f_path
	fi

	min_extn=".min"
	if $overwrite; then
		min_extn=""
	fi

	echo "$f_path/$f_name$min_extn$f_extn" | xargs readlink -m
}

find_files () {
	: '
	arguments:
		1- js | css (supported file extension)

	find all files of certain type inside in_dir
		- `find` returns the relative path, which is needed
		- `*` acts as a recursive operator

	Piped into grep to get all non minified files

	optional parameters:
		- `-maxdepth`
	'

	if ! [ -z $INPUT_MAXDEPTH ] && [[ $INPUT_MAXDEPTH == ?(-)+([0-9]) ]]; then
		MAXDEPTH="-maxdepth ${INPUT_MAXDEPTH}"
	else
		MAXDEPTH=""
	fi

	EXCLUDES=()
	if ! [ -z $INPUT_EXCLUDE_DIRECTORIES ]; then
		IFS=';' read -ra EXCLUDES_ARRAY <<< "$INPUT_EXCLUDE_DIRECTORIES"
		for i in ${EXCLUDES_ARRAY[@]}; do
			if [ -z $EXCLUDES ]; then
				EXCLUDES+=("-path" "$in_dir/$i")
			else
				EXCLUDES+=("-o" "-path" "$in_dir/$i")
			fi
		done
	fi

	if ! [ -z $EXCLUDES ]; then
		EXCLUDES="-type d \( ${EXCLUDES[@]} \) -prune -o"
	fi

	COMMAND="find $in_dir ${MAXDEPTH} ${EXCLUDES} -type f -name *.$1 -not \( -iname *\.min.$1 \) -print"
	eval ${COMMAND}
}

exec_minify_js () {
	: '
	arguments:
		1- input file
		2- output file

	returns the command needed to minify the js file
	based on the requested JavaScript Engine in the
	input `js_engine` 
	'
	file=$1
	out=$2

	js_engine=$INPUT_JS_ENGINE

	if [[ $js_engine == "babel" ]]; then
		npx minify $file --out-file $out
	elif [[ $js_engine == "uglify-js" ]]; then
		npx uglifyjs $file --compress --mangle --output $out
	fi
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
		exec_minify_js $file $out
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

overwrite=false
if [ "${INPUT_OVERWRITE,,}" == "true" ]; then
	overwrite=true
fi

file_set=$({
	find_files 'js' &
	find_files 'css' &
})

set -e

for file in $file_set; do
	minify_file $file
done