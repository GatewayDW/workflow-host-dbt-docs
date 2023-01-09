## GitHub Actions - host dbt docs on website (Reusable workflow)
This is the Github Action to host dbt docs on GitHub pages when there is changes in the repo.

Example of dbt docs:
![](asset/dbt-docs-1.png)
![](asset/dbt-docs-2.png)

Ref: https://www.youtube.com/watch?app=desktop&v=I-yT2Err6PE

### Steps to use this GitHub Workflow
1. Check if there is secret `DBT_PROFILE` created in repo > Secrets
  
2. Copy the dbt profile config from profiles.yml to Github > your repo > Settings > Secrets > Actions > New repository secret
    Name: DBT_PROFILE
    Value: <dbt profile config>
    dbt profiles documentation https://docs.getdbt.com/reference/profiles.yml

3. From the caller repository, create a .yml file in the .github/workflows folder (see the example repo https://github.com/GatewayDW/test_ghw_dbt_docs/blob/main/.github/workflows/call_host_dbt_docs.yml)
  ```yml
  name: Build and Deploy dbt docs to Github Pages

  on:
    pull_request:
      branches: [main]

    push:
      branches:
        - main
    # workflow_dispatch:
    
  jobs:
    call-workflow:
      uses: GatewayDW/workflow-host-dbt-docs/.github/workflows/host_dbt_docs.yml@main
      with:
        runner_type: self-hosted
        dbt_project_path: <dbt project relative path e.g. etl/DOR>

      # https://docs.github.com/en/actions/using-workflows/reusing-workflows#passing-inputs-and-secrets-to-a-reusable-workflow

      secrets:
        secrets_dbt_profile: ${{ secrets.DBT_PROFILE }}
  ```

4. Make changes in your repo, commit and push to main branch. The workflow will be triggered based on the trigger condition in step 3 `on` block [Ref: Workflow Trigger](https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows).

5. For the 1st time CI execution, there will be an new branch `gh-pages` created. Go to settings > Pages > Select `gh-pages` branch > Save.
![](asset/gh-pages.png)

6. A new workflow will be created and executed automatically after step 5. The dbt docs will be hosted on the website.
![](asset/cicd-pages.png)
