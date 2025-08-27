# Dockerfile
FROM condaforge/miniforge3:latest

# Keep the image lean
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
ENV PIP_NO_CACHE_DIR=1
ENV PATH=/opt/conda/bin:$PATH

# Lock to Python 3.11 and add Jupyter
RUN conda install -y python=3.11 notebook jupyterlab && conda clean -afy

# Copy requirements.txt (if exists) and install
COPY requirements.txt /tmp/requirements.txt
RUN if [ -s /tmp/requirements.txt ]; then \
      pip install -r /tmp/requirements.txt ; \
    fi

# Workspace + port
WORKDIR /workspace
EXPOSE 8888

# Start Notebook (swap to "jupyter lab" if you prefer)
CMD ["bash", "-lc", "jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser"]
