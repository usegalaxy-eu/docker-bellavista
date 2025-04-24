FROM continuumio/miniconda3

LABEL maintainer="Amirhossein N. Nilchi <nilchia@informatik.uni-freiburg.de>"

# Switch to bash terminal to run "conda" commands
SHELL ["/bin/bash", "-c"]

RUN apt-get update -qq && \
    apt-get install -y -q libgles2-mesa-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* 

RUN conda create -n bellavista -c conda-forge -c bioconda bellavista=0.0.2 && \
    conda clean -afy

ENV PATH=/opt/conda/envs/bellavista/bin:$PATH
ENV CONDA_DEFAULT_ENV=bellavista