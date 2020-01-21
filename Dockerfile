FROM jupyter/base-notebook:lab-1.2.1

USER root

# Install dependences
RUN apt-get update && apt-get install -y \
	wget \
	git \
	gcc \
	zip \
	&& rm -rf /var/lib/apt/lists/*

# Copy install files to tmp dir
COPY fix-lpsolve.patch /tmp
COPY requirements.txt /tmp

# Install python libraries 
RUN conda install --yes --file /tmp/requirements.txt

# Set environment variables
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/lp_solve_5.5/lpsolve55/bin/ux64
ENV PATH=$PATH:/opt/lp_solve_5.5/bin/ux64

# Download, compile and install lp-solve with Python 3x Interface
RUN wget https://sourceforge.net/projects/lpsolve/files/lpsolve/5.5.2.5/lp_solve_5.5.2.5_source.tar.gz \
  && tar -xvf lp_solve_5.5.2.5_source.tar.gz \
  && mv lp_solve_5.5 /opt \
  && git clone https://github.com/igormaraujo/lp_solve_python_3x.git \
  && mv lp_solve_python_3x/extra /opt/lp_solve_5.5 \
  && rm -rf lp_solve_python_3x lp_solve_5.5.2.5_source.tar.gz \
  && cd /opt/lp_solve_5.5/lpsolve55 \
  && patch -f < /tmp/fix-lpsolve.patch \
  && sh ccc \
  && cd /opt/lp_solve_5.5 && mkdir -p bin/ux64 && cd bin/ux64 \
  && wget https://sourceforge.net/projects/lpsolve/files/lpsolve/5.5.2.5/lp_solve_5.5.2.5_exe_ux64.tar.gz \
  && tar -xvf lp_solve_5.5.2.5_exe_ux64.tar.gz \
  && mv *.so /opt/lp_solve_5.5/lpsolve55/bin/ux64 \
  && rm -rf lp_solve_5.5.2.5_exe_ux64.tar.gz \
  && cd /opt/lp_solve_5.5/extra/Python \
  && python setup.py install \
  && rm -rf /tmp/fix-lpsolve.patch /tmp/requirements.txt \
  && mkdir /home/$NB_USER/examples/

# Copy example files
COPY example/ /home/$NB_USER/examples/

# Fix the permission on files and folders
RUN chown -R $NB_USER:$NB_GID /home/$NB_USER

EXPOSE 8888

USER $NB_UID

CMD ["jupyter", "lab"]
