FROM dssat/dssat-pythia:latest
RUN apt-get install -y r-base-dev && \
cd /app && \
git clone https://github.com/DSSAT/supermaas-aggregate-pythia-outputs && \
cd supermaas-aggregate-pythia-outputs && \
Rscript install-deps.R && \
cp /app/pythia.sh /app/pythia-orig.sh && \
echo 'cd /app/supermaas-aggregate-pythia-outputs' >> /app/pythia.sh && \
echo 'Rscript aggregate-pythia-outputs.R /userdata/outputs/ /userdata/wmout.csv' >> /app/pythia.sh

# Load the data
RUN mkdir -p /data/{eth,base,weather} && \
mkdir /userdata && \
cd /data && \
curl -O https://data.agmip.org/darpa/basedata-latest.tar.xz && \
curl -O https://data.agmip.org/darpa/ethdata-latest.tar.xz && \
curl -O https://data.agmip.org/darpa/ethweather-historical-latest.tar.xz && \
cd /data/base && tar xvf /data/basedata-latest.tar.xz && \
cd /data/eth && tar xvf /data/ethdata-latest.tar.xz && \
cd /data/weather && tar xvf /data/ethweather-historical-latest.tar.xz && \
rm /data/*.tar.xz
