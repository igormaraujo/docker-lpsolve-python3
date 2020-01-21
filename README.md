# Docker Container lpsolve with Python 3.7 and Jupyter Lab
###### Tested on Ubuntu 18.04.3 LTS, Docker version 19.03.5

A ready-to-use environment of [Jupyter Lab](https://jupyter.org/) v1.2.1 and [lpsolve](https://sourceforge.net/projects/lpsolve/) v.5.5.2.5 with Python 3.7

## Getting Started

### Prerequisites

```
Docker
```

### Installing

1. Download and extract the project zip file or git clone the repository.
2. In the terminal, inside the project folder where has the Dockerfile, use the command below to build the Docker Image:
```
docker build --rm -t lpsolve .
```
3. Create and start the container with name lpsolve
```
docker run --name lpsolve lpsolve
```
3.1.(optional) Port Forwarding
```
docker run -p 8001:8888 --name lpsolve lpsolve
```
3.2.(optional) Volume (A volume allows data to persist, even when a container is deleted. Volumes are also a convenient way to share data between the host and the container)
```
docker run -v "$HOME":/home/jovyan/work --name lpsolve lpsolve
```
4. Starting a container already created
```
docker start lpsolve
```
(Optional). Get jupyter notebook token
```
docker exec lpsolve jupyter notebook list
```

(Optional). Docker container terminal as root
```
docker exec -it --user root lpsolve bash
```

## Running the tests

1. Access the URL [http://localhost:8888] from a browser
1.1 (Optional) Enter with the notebook token
2. The folder examples has two notebook document: **ex.ipynb** with a variety of simples usage cases, and **example1.ipnb** with a detail usage case. Both examples are included in [lpsolve python extension](http://lpsolve.sourceforge.net/5.5/Python.htm)
(Optional) It is possible to install python libraries as *numpy*, with the command in the JupyterLab terminals:
```
conda install numpy
```

## Uninstalling

1. Remove docker lpsolve container (WARNING! The data not inside the volume mounted will be LOST)
```
docker rm lpsolve
```

2. Remove docker image
```
docker image rm lpsolve
```

## Built With
- [JupyterLab](https://hub.docker.com/r/jupyter/base-notebook) - Version 1.2.1 from base-notebook Docker image
- [lp-solve](http://lpsolve.sourceforge.net/) - Mixed Integer Linear Programming (MILP) solver (Version 5.5.2.5)
- [lpsolve python extension](https://github.com/chandu-atina/lp_solve_python_3x) - Unofficial lp-solve python ported to Python 3x
- [fix-lpsolve patch](https://groups.google.com/forum/#!topic/prismmodelchecker/gtVatHAir90) - lp-solve patch fix for recent
compilers

## Authors
* **Igor M. Araujo** - *Initial work* - [igormaraujo](https://github.com/igormaraujo)
* **Carlos Natalino** - *Initial work* - [carlosnatalino](https://github.com/carlosnatalino)


See also the list of [contributors](https://github.com/igormaraujo/docker-lpsolve-python3/contributors) who participated in this project.

## License
This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments
- meow - https://stackoverflow.com/a/44922060/12347166
- Thomas Dejonghe - https://stackoverflow.com/a/50592697/12347166
- Joachim Klein - https://groups.google.com/forum/#!topic/prismmodelchecker/gtVatHAir90
- Chandrasekhar Atina - https://github.com/chandu-atina/lp_solve_python_3x
