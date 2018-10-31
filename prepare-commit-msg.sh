#!/bin/bash

# This way you can customize which branches should be skipped when
# prepending commit message. 
if [ -z "$BRANCHES_TO_SKIP" ]; then
  BRANCHES_TO_SKIP=(master develop test)
fi

ORIGINAL_BRANCH_NAME=$(git symbolic-ref --short HEAD)
STRIPPED_BRANCH_NAME=${ORIGINAL_BRANCH_NAME##*/}
#BRANCH_NAME=$(echo $STRIPPED_BRANCH_NAME | sed -e 's/^.*\/\(DG-[[:digit:]]\+\).*$/x/g')
BRANCH_NAME=$(sed -e 's/\(DG-[[:digit:]]\+\).*/\1/g' <<< $STRIPPED_BRANCH_NAME)


BRANCH_EXCLUDED=$(printf "%s\n" "${BRANCHES_TO_SKIP[@]}" | grep -c "^$BRANCH_NAME$")
BRANCH_IN_COMMIT=$(grep -c "\[$BRANCH_NAME\]" $1)

echo >> LOG
if [ -n "$BRANCH_NAME" ] && ! [[ $BRANCH_EXCLUDED -eq 1 ]] && ! [[ $BRANCH_IN_COMMIT -ge 1 ]] && [ "$BRANCH_NAME" != "$STRIPPED_BRANCH_NAME" ] ; then
  echo OK >> LOG
  sed -i.bak -e "1s/^/$BRANCH_NAME /" $1
fi
