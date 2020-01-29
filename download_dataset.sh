#preparing for download 
mkdir "gridcorpus"
cd "gridcorpus"
mkdir "raw"
cd "raw" && mkdir "audio" "video"

for i in `seq $1 $2`
do
    printf "\n\n------------------------- Downloading $i th speaker -------------------------\n\n"
    
    #download the audio of the ith speaker
    cd "audio" && curl "http://spandh.dcs.shef.ac.uk/gridcorpus/s$i/audio/s$i.tar" > "s$i.tar" && cd ..
    cd "video" && curl "http://spandh.dcs.shef.ac.uk/gridcorpus/s$i/video/s$i.mpg_vcd.zip" > "s$i.zip" && cd ..

    if (( $3 == "y" ))
    printf "\n\n--untar the files--\n\n"
    then
        mkdir "../s$i"
        mkdir "../s$i/video" "../s$i/audio"
        unzip -q "video/s$i.zip" -d "../s$i/video"
        mv ../s$i/video/s$i/* ../s$i/video/ && rm -rf ../s$i/video/s$i        
        tar -xf "audio/s$i.tar" -C "../s$i/audio"
        mv ../s$i/audio/s$i/* ../s$i/audio/ && rm -rf ../s$i/audio/s$i
    fi
done
