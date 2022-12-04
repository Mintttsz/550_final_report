project_md.html: project_md.Rmd code/03_render_report.R output/table.rds output/figure.rds
	Rscript code/03_render_report.R

output/table.rds: code/01_make_table.R
	Rscript code/01_make_table.R
	
output/figure.rds: code/02_make_figure.R
	Rscript code/02_make_figure.R

.PHONY: clean
clean:
	rm -f output/*.rds && rm -f project_md.html

               
.PHONY: install
install:
	Rscript -e "renv::restore(prompt=FALSE)"

# docker 
PROJECTFILES = project_md.Rmd code/01_make_table.R code/02_make_figure.R code/03_render_report.R Makefile
RENVEFILES = renv.lock renv/activate.R renv/settings.dcf

# image
project_image: Dockerfile $(PROJECTFILES) $(RENVEFILES)
	docker build -t mengkedu/report .
	touch $@

# container 
report/project_md.html: 
	docker run -v "/$$(pwd)/report":/project/report mengkedu/report