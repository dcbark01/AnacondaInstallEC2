#!/usr/bin/env bash

# ---------------------------- INSTALL NOTES ----------------------------
# To properly setup the AWS CLI, make sure that this shell script is run with the two required positional args:
#   $1 :: (string) AWS Access Key ID
#   $2 :: (string) AWS Secret Key
#
# Also make sure to give the script permission to run!:
#    chmod 755 /home/ec2-user/install.sh
#
# -----------------------------------------------------------------------


# ++++++++++++++++++++ START ANACONDA INSTALL +++++++++++++++++++++
cd /home/ec2-user
su ec2-user

# Download the Linux Anaconda Distribution
wget https://repo.anaconda.com/archive/Anaconda3-2019.03-Linux-x86_64.sh -O /tmp/anaconda3.sh

# Run the installer (installing without -p should automatically install into '/' (root dir)
bash /tmp/anaconda3.sh -b -p /home/ec2-user/anaconda3
rm /tmp/anaconda3.sh

### Run the conda init script to setup the shell
echo ". /home/ec2-user/anaconda3/etc/profile.d/conda.sh" >> /home/ec2-user/.bashrc
. /home/ec2-user/anaconda3/etc/profile.d/conda.sh
source /home/ec2-user/.bashrc

# Create a base Python3 environment separate from the base env
conda create -y --name python3

# +++++++++++++++++++++ END ANACONDA INSTALL ++++++++++++++++++++++


# ++++++++++++++ SETUP ENV +++++++++++++++

# Install necessary Python packages
# Note that 'source' is deprecated, so now we should be using 'conda' to activate/deactivate envs
conda activate python3

# Setup the credentials for the AWS CLI
aws configure set aws_access_key_id $1
aws configure set aws_secret_access_key $2

# ++++++++++++ END  +++++++++++++