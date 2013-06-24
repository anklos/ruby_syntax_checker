#!/bin/bash
RUBY_VERSION=$(ruby -v)
echo "You are using $RUBY_VERSION"
echo "Starting to check syntax for rb files in $1"

EXIT=0

for file in $(find $1 -name '*.rb')
do
  OUTPUT=$(ruby -c $file 2>&1 )
  if [ "$OUTPUT" != "Syntax OK" ]; then
    ERRORS=$ERRORS"\n"$OUTPUT
    printf 'x'
    EXIT=1
  else
    printf '.'
  fi
done
echo $ERRORS
exit $EXIT
