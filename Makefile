project_md.html: project_md.Rmd code/03_render_report.R output/table.rds output/figure.rds
	Rscript code/03_render_report.R

output/table.rds: code/01_make_table.R
	Rscript code/01_make_table.R
	
output/figure.rds: code/02_make_figure.r
	Rscript code/02_make_figure.R

.PHONY: clean
clean:
	rm -f output/*.rds && rm -f report.html


