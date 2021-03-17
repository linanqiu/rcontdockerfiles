FROM rocker/r-ver:4.0.4

ENV S6_VERSION=v2.1.0.2
ENV RSTUDIO_VERSION=latest
ENV PATH=/usr/lib/rstudio-server/bin:$PATH

RUN /rocker_scripts/install_rstudio.sh
RUN /rocker_scripts/install_pandoc.sh
RUN /rocker_scripts/install_tidyverse.sh

# cut through to install faster. ideally we'd just install from source from a secure repo by putting the options repo override on top of this line
RUN install2.r devtools tidyverse AzureStor Rcpp glmnet onehot RcppArmadillo visNetwork plyr
RUN echo "options(repos = c(CRAN = 'https://rcontartifactory.jfrog.io/artifactory/cran/'), download.file.method = 'libcurl')" >> /usr/local/lib/R/etc/Rprofile.site
RUN Rscript -e 'devtools::install_github("forestry-labs/Rforestry")'

COPY job.R job.R

CMD ["Rscript", "job.R"]