
------------------------------------------------------------------------
## Project contents

  I report the summary table of total COVID-19 cases in 2022 stratified by several regions per month. And including a plot showing the trend of new cases over time.
  The report is generated by several R scripts and a Rmarkdown file. Makefile is available also.

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