# template_ETL_repo
This repo is used as the template when creating new repository.

## What is inside the template
1. Issue template (.github/ISSUE_TEMPLATE/*.md)
2. Pull Request template (.github/PULL_REQUEST_TEMPLATE.md)
3. Skeleton Folders
4. Python requirements (environment_*.yml) ([pls use conda to install](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#creating-an-environment-from-an-environment-yml-file))

## Steps to create new repo using template:
1. Create new repository or simply click the button "Use this template"
2. Select this repo from "Repository template"
3. Copy from [here](https://github.com/sfbrigade/data-science-wg/blob/master/dswg_project_resources/Project-README-template.md) paste and edit the followings as your `readme.md` in root folder


## GitHub Actions - host dbt docs on website

https://www.youtube.com/watch?app=desktop&v=I-yT2Err6PE&feature=youtu.be

1.  Create a ci.yml file
2.  If it is self-hosted, the deploy site will be generated automatically
3.  Otherwise, go settings > pages
    Source: deploy from a branch
    Branch: gh-pages - /(root)
    Then, the build and deploy workflow will start automatically


```yaml
  name: CI

# To trigger the Actions
on:
  pull_request:
    branches: [MY-28-github_page_test2]
  push:
    branches: [main]
  workflow_dispatch:


permissions:
  contents: write

jobs:
  build:  
    runs-on: self-hosted # choose the environment to be used
    
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Python
        uses: actions/setup-python@v2
        with:
          python-version: '3.9'
        
      
      - name: Install dbt 
        run: pip install dbt-sqlserver # install the correct dbt tool
      
      # Applicable when "self-hosted" is used
      - name: Upload Artifacts 🔺 # The project is then uploaded as an artifact named 'site'.
        uses: actions/upload-artifact@v1
        with:
          name: site
          path: etl/CDW_FB_SQ # dbt project folder path
      

  deploy:
    needs: [build] # [deploy] action will run after [build] action done 
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3
    
    # pair up with upload artifacts
      - name: Download Artifacts 🔻 # The built project is downloaded into the 'site' folder.
        uses: actions/download-artifact@v1
        with:
          name: site

      
      - name: Deploy
        uses: JamesIves/github-pages-deploy-action@v4
        with: 
          folder: etl/CDW_FB_SQ/target
```
