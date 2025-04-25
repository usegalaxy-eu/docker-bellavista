[![Docker Repository on Quay](https://quay.io/repository/bgruening/bellavista/status "Docker Repository on Quay")](https://quay.io/repository/bgruening/bellavista)

# docker-bellavista

Docker image with [bellavista](https://github.com/pkosurilab/BellaVista) version 0.0.2

## How to build the container

To build this container you can use the following command:

```bash
git clone https://github.com/usegalaxy-eu/docker-bellavista.git
cd docker-bellavista
docker build -t CONTAINER_NAME .
```

## How to pull the container from Quay.io

The container is stored on Quay.io and you can get it via:

```bash
docker pull quay.io/bgruening/bellavista:latest
```

## How to use the container

```bash
docker run -p 5800:5800 --rm -it -v /host_input/:/input/ CONTAINER_NAME:tag  
```

Then you can access the app via: http://localhost:5800/

**NOTE:** all your input files (i.e. images, transcripts, ...) and the config.json file should be mounted to `/input/` directory in the container.

**NOTE:** the `data_folder` argument in the `config.json` should be set to: `"data_folder": "./",`