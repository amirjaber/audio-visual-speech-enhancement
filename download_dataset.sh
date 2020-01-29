#preparing for download 
mkdir "gridcorpus"
cd "gridcorpus"
mkdir "raw" "train" "validation" "test"
cd "raw" && mkdir "audio" "video"

for i in `seq 1 $1`
do
    printf "\n\n------------------------- Downloading $i th speaker -------------------------\n\n"
    
    #download the audio of the ith speaker
    cd "audio" && curl "http://spandh.dcs.shef.ac.uk/gridcorpus/s$i/audio/s$i.tar" > "s$i.tar" && cd ..
    cd "video" && curl "http://spandh.dcs.shef.ac.uk/gridcorpus/s$i/video/s$i.mpg_vcd.zip" > "s$i.zip" && cd ..
 
        mkdir "../train/s$i" "../train/s$i/video" "../train/s$i/audio"         
        mkdir "../validation/s$i" "../validation/s$i/video" "../validation/s$i/audio"
        mkdir "../test/s$i" "../test/s$i/video" "../test/s$i/audio"

        mkdir "../s$i/" "../s$i/video" "../s$i/audio"
        unzip -q "video/s$i.zip" -d "../s$i/video"
        tar -xf "audio/s$i.tar" -C "../s$i/audio"

        mv ../s$i/video/s$i/bb* ../train/s$i/video/        
        mv ../s$i/audio/s$i/bb* ../train/s$i/audio/

        mv ../s$i/video/s$i/pb* ../validation/s$i/video/       
        mv ../s$i/audio/s$i/pb* ../validation/s$i/audio/

        mv ../s$i/video/s$i/sb* ../test/s$i/video/        
        mv ../s$i/audio/s$i/sb* ../test/s$i/audio/ && rm -rf ../s$i
done
rm -rf ../raw/
