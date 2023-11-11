https://stackoverflow.com/questions/50777849/from-conda-create-requirements-txt-for-pip3

If you want a file which you can use to create a pip virtual environment (i.e. a requirements.txt in the right format) you can install pip within the conda environment, then use pip to create requirements.txt.

conda activate <env>
conda install pip
pip freeze > requirements.txt
Then use the resulting requirements.txt to create a pip virtual environment:

python3 -m venv env
source env/bin/activate
pip install -r requirements.txt
When I tested this, the packages weren't identical across the outputs (pip included fewer packages) but it was sufficient to set up a functional environment.

For those getting odd path references in requirements.txt, use:

pip list --format=freeze > requirements.txt