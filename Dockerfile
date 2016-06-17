# Copyright (c) Parrot Prediction Ltd.
# Distributed under the terms of the Modified BSD License.
FROM jupyter/minimal-notebook

MAINTAINER Parrot Prediction <contact@parrotprediction.com>

USER root

# libav-tools for matplotlib anim
RUN apt-get update && \
    apt-get install -y --no-install-recommends libav-tools && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER jovyan

# Install Python 3 packages
RUN conda install --quiet --yes \
	'pandas=0.17*' \
	'matplotlib=1.5*' \
	'seaborn=0.7*' \
	'scikit-learn=0.17*'

# Add shortcuts to distinguish pip for python2 and python3 envs
RUN ln -s $CONDA_DIR/envs/python2/bin/pip $CONDA_DIR/bin/pip2 && \
    ln -s $CONDA_DIR/bin/pip $CONDA_DIR/bin/pip3

# Install XGBoost library
RUN pip3 install xgboost
