# Expects all of the great stuff from 
# https://github.com/joeatwork/mazes-c
# to be built and available in
# $MAZES_DIRECTORY

#           0   1   2   3   4   5   6   7   8   9  10
widths=(    0  18  54  72 108 162 163 216 216 216 216)
heights=(   0   1   3   4   6   9  12  24 162 216 432)
pathwidths=(0  36  12   9   6   4   4   3   3   3   3)

for mseed in 122 211 342 456 543 63; do
seed=5556
for i in 1 2 3 4 5 6 7 8 9 10; do

    width=${widths[$i]}
    height=${heights[$i]}
    pathwidth=${pathwidths[$i]}

    $MAZES_DIRECTORY/grid --width=$width --height=$height | \
       $MAZES_DIRECTORY/maze --seed=$mseed | \
       $MAZES_DIRECTORY/color --seed=$seed | \
       $MAZES_DIRECTORY/png --path-width=$pathwidth > /tmp/mazes/${i}_${width}x${height}x${pathwidth}_${mseed}.png
done
done

optipng /tmp/mazes/*.png

