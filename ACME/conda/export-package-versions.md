https://docs.conda.io/projects/conda/en/latest/commands/list.html
conda list --export > env-reports2-package-list.txt
Reinstall packages from an export file:

conda create -n myenv --file package-list.txt