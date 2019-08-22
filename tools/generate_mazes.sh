# Expects all of the great stuff from 
# https://github.com/joeatwork/mazes-c
# to be built and available in
# $MAZES_DIRECTORY

# We target
#  400 pixels across
#  

# (10 20 40 80 160 320)
# (1   2  4  8  16  32)
# (64 32 16   8     4)
# (240)
# (48)
# (6)


# We also need a "half-step" between 4 and 5 : (  )

for seed in 122 233 344 455; do
mseed=$seed
for i in 1 2 3 4 5 6; do

    width=$(echo "5*(2^$i)" | bc)
    height=$(echo "2^($i - 1)" | bc)
    pathwidth=$(echo "256 / (2^$i)" | bc)

    $MAZES_DIRECTORY/grid --width=$width --height=$height | \
       $MAZES_DIRECTORY/maze --seed=$mseed | \
       $MAZES_DIRECTORY/color --seed=$seed | \
       $MAZES_DIRECTORY/png --path-width=$pathwidth > /tmp/mazes/${i}_${width}x${height}_${mseed}.png
done

$MAZES_DIRECTORY/grid --width=240 --height=24 | \
       $MAZES_DIRECTORY/maze --seed=$mseed | \
       $MAZES_DIRECTORY/color --seed=$seed | \
       $MAZES_DIRECTORY/png --path-width=5 > /tmp/mazes/5.5_240x24_${mseed}.png
done

optipng /tmp/mazes/*.png

