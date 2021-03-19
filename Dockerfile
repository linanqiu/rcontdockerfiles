FROM rocker/tidyverse:4.0.4

# cut through to install faster. ideally we'd just install from source from a secure repo by putting the options repo override on top of this line
RUN install2.r devtools tidyverse AzureStor Rcpp glmnet onehot RcppArmadillo visNetwork plyr
RUN echo "options(repos = c(CRAN = 'https://rcontartifactory.jfrog.io/artifactory/cran/'), download.file.method = 'libcurl')" >> /usr/local/lib/R/etc/Rprofile.site
RUN Rscript -e 'install.packages("Rforestry")'

COPY job.R job.R

CMD ["Rscript", "job.R"]
# CMD ["/init"]