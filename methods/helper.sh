export METHOD=recat

cd ../ti_${METHOD}

chmod +x run.py
chmod +x run.R
chmod +x example.R

Rscript example.sh example.h5

# build container
docker build -t dynverse/ti_${METHOD} .

# go inside container
docker run -it --entrypoint bash -v $(pwd):/mnt dynverse/ti_${METHOD}
R
task <- dyncli::main(c("--dataset", "/mnt/example.h5", "--output", "/mnt/output.h5")) # and run this

# run method -> see R script to read it!
docker run -v $(pwd):/mnt dynverse/ti_${METHOD} --dataset /mnt/example.h5 --output /mnt/output.h5 --verbosity 3
rm -f output.h5
rm -f example.h5

echo "VERSION=0.9.9" > version

travis_enc_all
yes

git checkout -b dynwrapv2
git add .
git commit -m "dynwrapv2"
git push --set-upstream origin dynwrapv2

