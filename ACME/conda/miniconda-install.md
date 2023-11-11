# Install Miniconda

## References

<https://docs.conda.io/projects/conda/en/latest/user-guide/install/linux.html>
<https://docs.conda.io/en/latest/miniconda.html#linux-installers>

## Commands to install Miniconda

```bash
cd ~/Downloads
curl https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh > Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh

# Optional test installing conda environment.  Warning this takes a long time.
cd ~/src/linux-utils/conda
conda env create -f env-reports.yml

```
