# Expects all of the great stuff from 
# https://github.com/joeatwork/mazes-c
# to be built and available in
# $MAZES_DIRECTORY

# We target
#  400 pixels across
#  

# (20 40 80 160   320)
# (4   8 16  32    64)
# (64 32 16   8     4)
# (240)
# (48)
# (6)


# We also need a "half-step" between 4 and 5 : (  )

for preseed in 123 345 131 222 555; do
for i in 1 2 3 4 5 6; do
    seed="${preseed}${i}"

    width=$(echo "5*(2^$i)" | bc)
    height=$(echo "2^($i)" | bc)
    pathwidth=$(echo "256 / (2^$i)" | bc)

    $MAZES_DIRECTORY/grid --width=$width --height=$height | \
       $MAZES_DIRECTORY/maze --seed=$seed | \
       $MAZES_DIRECTORY/color --seed=$seed | \
       $MAZES_DIRECTORY/png --path-width=$pathwidth > /tmp/mazes/${i}_${width}x${height}_${seed}.png
done


$MAZES_DIRECTORY/grid --width=240 --height=48 | \
       $MAZES_DIRECTORY/maze --seed=$seed | \
       $MAZES_DIRECTORY/color --seed=$seed | \
       $MAZES_DIRECTORY/png --path-width=5 > /tmp/mazes/5.5_240x48_${seed}.png
done

optipng /tmp/mazes/*.png

