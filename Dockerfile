# get base image of R shiny, use installed version of R
FROM rocker/shiny:4.4.0

# install all packages used by this app
RUN install2.r rsconnect tidyverse tidymodels parsnip shinydashboard glmnet shinyWidgets shinyjs shinycssloaders renv markdown      

# create image's work dir
WORKDIR /FUZU

# copy files from remote repo(GitHub) work dir to image ork dir
# to copy all files at once (keeping folder structure), use "COPY . .""
COPY ./ui.R /FUZU/ui.R
COPY ./server.R /FUZU/server.R
COPY ./app.R /FUZU/app.R
COPY ./deploy.R /FUZU/deploy.R

COPY ./mains /FUZU/mains/

# run the deploy script
CMD Rscript deploy.R