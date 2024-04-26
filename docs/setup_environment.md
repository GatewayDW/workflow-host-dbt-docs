## Setup Development/ Production Environment
What is environment?
- Environment is a set of configurations/ softwares installed that allows the application to run in different settings.

### Via Conda
> [!NOTE]
> You can use ` && ` to chain commands in a single line, example:
```
call ./script/conda/01_create_conda_env_v1.bat && call ./script/conda/02_install_packages_v1.bat
```
#### Initial Setup
1. Install [MiniConda](https://docs.anaconda.com/free/miniconda/miniconda-install/)
2. Open a terminal and navigate to the project root directory
3. Copy `.env.base.sample` to `.env.base`, modify the content inside
   > [!IMPORTANT]
   > Be aware `.env.base` is not committed to any branch
4. Run the script to create the virtual environment
   ```cmd
   call .\script/conda/00_start_base_venv_miniconda_v1.bat
   ```
5. Create an new environment:
   ```cmd
   call .\script/conda/01_create_conda_env_v1.bat
   ```
6. Run the script to install python packages
   ```cmd
   call .\script/conda/02_uv_install_update_packages_v1.bat
   ```

   If you encountered `invalid peer certificate: UnknownIssuer`, run the following command:
   ```cmd
   call .\script/conda/02_pip_install_update_packages_v1.bat
   ```

#### Update any python packages:
11. Update `requirements.txt`
12. Recommended to create a new environment/ remove the old environment 
    ```cmd
    call ./script/conda/03_remove_conda_env_v1.bat
    ```
13. Execute the steps from 6 to 11