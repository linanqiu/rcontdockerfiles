FROM rocker/r-ver:4.0.4

# from rstudio container
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    file \
    git \
    libapparmor1 \
    libclang-dev \
    libcurl4-openssl-dev \
    libedit2 \
    libssl-dev \
    lsb-release \
    multiarch-support \
    psmisc \
    procps \
    python-setuptools \
    sudo \
    wget 

# from tidyverse container
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
  libxml2-dev \
  libcairo2-dev \
  libsqlite-dev \
  libmariadbd-dev \
  libmariadbclient-dev \
  libpq-dev \
  libssh2-1-dev \
  unixodbc-dev \
  libsasl2-dev

# cut through to install faster. ideally we'd just install from source from a secure repo by putting the options repo override on top of this line
RUN install2.r devtools tidyverse AzureStor Rcpp glmnet onehot RcppArmadillo
RUN echo "options(repos = c(CRAN = 'https://rcontartifactory.jfrog.io/artifactory/cran/'), download.file.method = 'libcurl')" >> /usr/local/lib/R/etc/Rprofile.site
RUN Rscript -e 'devtools::install_github("forestry-labs/Rforestry")'

COPY job.R job.R

RUN Rscript job.R