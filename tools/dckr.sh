#!/usr/bin/env sh

DCKR_FILE=$1

if [ -z "${DCKR_FILE}" ]; then
	echo please specify file
	exit 1
elif [ ! -r "${DCKR_FILE}" ]; then
	echo file: \"${DCKR_FILE}\" not found
	exit 1
fi

if [ "$2" = "-f" ]; then
	docker build -t "${DCKR_FILE#*-}" - < ${DCKR_FILE}
	exit 0
fi


echo read image from docker file
while IFS=" " read -r exp val; do
	[ "$exp" = "FROM" ] && IMG="$val"
done < ${DCKR_FILE}
 
echo docker pull
STATUS=$(docker pull "${IMG}" | grep 'Status:')
echo latest
LATEST="Status: Image is up to date for ${IMG}"

echo compare
if [ "${LATEST}" != "${STATUS}" ]; then
	docker build -t "${DCKR_FILE#*-}" - < ${DCKR_FILE}
fi

echo docker run
docker run -it -v $HOME/.ssh/:/home/user/.ssh -v $(pwd):/yocto -m 16G "${DCKR_FILE#*-}"
