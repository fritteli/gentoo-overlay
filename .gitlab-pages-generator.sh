#!/bin/sh

ROOT=$(realpath "${1:-.}")
TARGET=$(realpath "${2:-.public}")
declare -a PARTS=()

function createDir() {
	mkdir -p "${1}"
}

function createDirInTarget() {
	local dirpart="${1}"
	local destinationdirectory=${dirpart/${ROOT}/${TARGET}}
	echo $destinationdirectory
}

function writeHTMLHeader() {
	local targetfile="${1}"
	local currentdir="${2}"

	cat <<EOHEAD > "${targetfile}"
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>gentoo-overlay/${currentdir}</title>
</head>
<body>
	<h1>gentoo-overlay/${currentdir}</h1>
	<ul>
EOHEAD
}

function writeHTMLFooter() {
	local targetfile="${1}"
	cat <<EOFOOT >> "${targetfile}"
	</ul>
</body>
</html>
EOFOOT
}

function writeHTMLFileentry() {
	local targetfile="${1}"
	local filename="${2}"
	cat <<EOFILE >> "${targetfile}"
		<li><a href="${filename}">${filename}</a></li>
EOFILE
}

function pushPart() {
	local part="${1}"
	PARTS=("${PARTS[@]}" "${part}")	
}

function popPart() {
	local index=$(expr ${#PARTS[@]} - 1)
	unset PARTS[${index}]
}

function renderParts() {
	local IFS="/"
	echo "${PARTS[*]}"
}

function renderTargetPath() {
	local parts=$(renderParts)
	echo "${TARGET}${parts:+/}${parts}"
}

function renderTargetFilename() {
	local targetPath=$(renderTargetPath)
	echo "${targetPath}/index.html"
}

function processDir() {
	local dir="${1}"
	cd "${dir}"
	local realpath=$(realpath .)
	local files=$(ls)
	local parts=$(renderParts)
	local targetPath=$(renderTargetPath)
	local targetFilename=$(renderTargetFilename)
	mkdir -p "${targetPath}"
	writeHTMLHeader "${targetFilename}" "${parts}"
	writeHTMLFileentry "${targetFilename}" ".."
	for f in ${files} ; do
		if [ -f "${f}" ] ;then
			cp "${f}" "${targetPath}"
			writeHTMLFileentry "${targetFilename}" "${f}"
		elif [ -d "${f}" ] ; then
			writeHTMLFileentry "${targetFilename}" "${f}/"
			pushPart "${f}"
			processDir "${f}"
			popPart
		else
			echo "Unknown: ${f}"
		fi
	done
	writeHTMLFooter "${targetFilename}"
	cd ..
}

processDir "${ROOT}"
