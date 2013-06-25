#!/bin/bash
RUBY_VERSION=$(ruby -v)
echo "You are using $RUBY_VERSION"
echo "Starting to check syntax for rb files in $1"

EXIT=0

for file in $(find $1 -name '*.rb')
do
  OUTPUT=$(ruby -c $file 2>&1 )
  if [[ "$OUTPUT" =~ "warning" ]]; then
    OUTPUT=$(echo $OUTPUT)
    WARNINGS="$WARNINGS$OUTPUT"
    printf '.'
  elif [[ "$OUTPUT" =~ "error" ]]; then
    ERRORS="$ERRORS\n$OUTPUT"
    printf 'x'
    EXIT=1
  else
    printf '.'
  fi
done

printf "\nWarnings:\n"
printf "$WARNINGS\n"
echo "-------------------------------------------------"
printf "Errors:"
printf "$ERRORS\n"

exit $EXIT
