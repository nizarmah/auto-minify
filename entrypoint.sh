#!/bin/bash -l

cd /app/

DIR="/github/workspace"

INPUT_DIRECTORY="$DIR/$INPUT_DIRECTORY"
if [[ $INPUT_DIRECTORY =~ ^.*\/$ ]]; then
	INPUT_DIRECTORY=${INPUT_DIRECTORY::-1}
fi

if [ -z $INPUT_OUTPUT ]; then
	INPUT_OUTPUT=$INPUT_DIRECTORY
elif [[ $INPUT_OUTPUT =~ ^.*\/$ ]]; then
	INPUT_OUTPUT=${INPUT_OUTPUT::-1}

	INPUT_OUTPUT="$DIR/$INPUT_OUTPUT"
fi

for filename in `ls $INPUT_DIRECTORY`; do
	filepath="$INPUT_DIRECTORY/$filename"

	extension="${filename#*.}"
	filename="${filename%.*}"

	outpath="$INPUT_OUTPUT/$filename.min"

	if [ "$extension" == "js" ]; then
		outpath="$outpath.js"

		npx uglifyjs $filepath --compress --mangle --output $outpath
	elif [ "$extension" == "css" ]; then
		outpath="$outpath.css"

		npx cleancss -o $outpath $filepath
	fi
done