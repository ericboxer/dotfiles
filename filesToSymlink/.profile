# ~/.profile
for I in aliases; do
  [ -f ~/.$I ] && . ~/.$I
done