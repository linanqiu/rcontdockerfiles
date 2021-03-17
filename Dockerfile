FROM rocker/r-ver:4.0.4

RUN echo "options(repos = c(CRAN = 'https://rcontartifactory.jfrog.io/artifactory/cran/'), download.file.method = 'libcurl')" >> /usr/local/lib/R/etc/Rprofile.site

RUN Rscript -e 'install.packages(c("devtools", "tidyverse", "AzureStor"))'
RUN Rscript -e 'devtools::install_github("forestry-labs/Rforestry")'

COPY job.R job.R

RUN Rscript job.R