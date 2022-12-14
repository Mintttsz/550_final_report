
------------------------------------------------------------------------
## Project contents

  I report the summary table of total COVID-19 cases in 2022 stratified by several regions per month. And including a plot showing the trend of new cases over time.
  The report is generated by several R scripts and a Rmarkdown file. Makefile is available also.

------------------------------------------------------------------------
## Update using docker

`Dockerfile`

  - builds an image that can be used to create my final report.
  - link to the image on DockerHub: https://hub.docker.com/r/mengkedu/report

Instruction to build the final report locally

  - forks and clones
  - navigates to project directory
  - runs `make project_image` to build the docker image, it would take some time.
  - runs `make report/project_md.html` to run the docker container. Once finish, the final report would be in the `report` folder.

Instruction to build the final report by pulling image from Docker Hub

  - use link above
  - run `docker pull mengkedu/report`
  - run `docker run -it mengkedu/report`
  - Final report creates.

My target will build appropriately on Windows system



------------------------------------------------------------------------
## Initial code description

`code/01_make_table.R`

  - loads data and generates summary table
  - saves summary table as a `.rds` object in `output/` folder
  
`code/02_make_figure.R`

  - loads data and generates trend figure
  - saves trend figure as a `.rds` object in `output/` folder

`code/03_render_report.R`

  - renders `project_md.Rmd`

`project_md.Rmd`

  - loads data and lists the first several rows of data
  - reads table generated by `code/01_make_table.R`
  - reads figure generated by `code/02_make_figure.R`
  - shows results
  
------------------------------------------------------------------------
## Update using renv package

`renv`

  - Folder generated by the `renv::init()`

`renv.lock`

  - Lockfile that contains information of the R packages related to the project

`Makefile`
  - Updates with `make install` rule, which use `renv::restore()` to synchronize the project library
  - Builds the final report by executing `make` in the terminal under project directory
  

