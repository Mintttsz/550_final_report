FROM rocker/r-ubuntu

RUN apt-get update && apt-get install -y pandoc libcurl4-openssl-dev libssl-dev libxml2-dev libfontconfig1-dev libcairo2-dev libjpeg-dev libgif-dev
RUN apt-get install -y --no-install-recommends libxt6

RUN mkdir /project
WORKDIR /project

RUN mkdir code
RUN mkdir output
RUN mkdir data

COPY code code
COPY output output
COPY data data

COPY Makefile .
COPY README.md .
COPY .gitignore .
COPY project_md.Rmd .
COPY .Rprofile .
COPY renv.lock . 

RUN mkdir renv
COPY renv/activate.R renv
COPY renv/settings.dcf renv
COPY renv/.gitignore  renv

RUN Rscript -e "renv::restore(prompt=FALSE)"

RUN mkdir report
CMD make && mv project_md.html report