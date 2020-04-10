shopt -s nullglob
for f in _posts/*
do
	echo "Adding footer for  $f"
 cat footer >> $f
done
