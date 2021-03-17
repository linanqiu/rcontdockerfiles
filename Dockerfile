FROM rocker/r-ver:4.0.4

RUN install2.r devtools tidyverse AzureStor
# RUN Rscript -e 'install.packages(c("devtools", "tidyverse", "AzureStor"))'
# cut through to install faster. ideally we'd just install from source from a secure repo
RUN echo "options(repos = c(CRAN = 'https://rcontartifactory.jfrog.io/artifactory/cran/'), download.file.method = 'libcurl')" >> /usr/local/lib/R/etc/Rprofile.site
RUN Rscript -e 'devtools::install_github("forestry-labs/Rforestry")'

COPY job.R job.R

RUN Rscript job.R