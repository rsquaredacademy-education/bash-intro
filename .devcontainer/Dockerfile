FROM rocker/r-ver:4.4.2

# System tools needed by the book: Quarto, Typst, shell utilities
RUN apt-get update && apt-get install -y --no-install-recommends \
      wget ca-certificates \
      zip unzip bsdmainutils \
      fonts-linuxlibertine fonts-dejavu-core \
    && wget -q https://github.com/quarto-dev/quarto-cli/releases/download/v1.6.40/quarto-1.6.40-linux-amd64.deb \
    && dpkg -i quarto-1.6.40-linux-amd64.deb || apt-get install -f -y \
    && rm quarto-1.6.40-linux-amd64.deb \
    && wget -q https://github.com/typst/typst/releases/download/v0.12.0/typst-x86_64-unknown-linux-musl.tar.xz \
    && tar -xf typst-x86_64-unknown-linux-musl.tar.xz \
    && mv typst-x86_64-unknown-linux-musl/typst /usr/local/bin/typst \
    && rm -rf typst-x86_64-unknown-linux-musl* \
    && rm -rf /var/lib/apt/lists/*

# R execution dependencies (matches renv.lock runtime set)
RUN R -e 'install.packages(c("knitr", "magrittr", "processx", "fs", "readr", "rmarkdown"), repos = "https://packagemanager.posit.co/cran/__linux__/jammy/latest")'
