# azure-basic-starter

> A basic PHP starter project for launching an Azure App Service resource with Azure CLI

### Features

- Scripted Azure App Service provisioning
- Customized Kudu deploys on Git push

### Reasoning

PHP is easy to install, if not already present on you computer. PHP runs pretty much everywhere. PHP is flexible.

This project aims to make it easier to get started with PHP on Azure without needing to use the [Azure portal](https://portal.azure.com/).

## Requirements

- [Active Azure subscription](https://azure.microsoft.com/en-us/)
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure)

## Getting Started

Ensure `provision.sh` is up-to-date to match the desired App Service Plan:

```bash
SERVICE_PLAN_NAME='Default1'
SERVICE_PLAN_RESOURCE_GROUP_NAME='Default-Web-EastUS'
APP_PHP_VERSION='7.2'
APP_PUBLIC_PATH='\public'
```

Once configured, run the `provision.sh` script from the project root. This will:

- Create a resource group
- Create a web app
- Update the document root to be the project's [`public`](public) directory
- Configure local Git deployments
- Add the Azure remote deployment URL to your local Git repository

Once complete, you'll see something similar to the below:

```
$ bash provision.sh
Created resource group 'azure-basic-starter'
Created web app 'azure-basic-starter-4524'
Added Azure deployment URL as a remote

Deploy via:

    git add .
    git commit -m "add files"
    git push -u azure master

Once deployed, 'azure-basic-starter-4524' will be accessible at:

    https://azure-basic-starter-4524.azurewebsites.net

Copied 'https://azure-basic-starter-4524.azurewebsites.net' to the system clipboard
```

Pushing to the `azure` remote, Azure / Kudu will display notes during the deployment:

```
$ git push azure master
Enumerating objects: 19, done.
Counting objects: 100% (19/19), done.
Delta compression using up to 4 threads
Compressing objects: 100% (13/13), done.
Writing objects: 100% (15/15), 466.75 KiB | 5.02 MiB/s, done.
Total 15 (delta 3), reused 0 (delta 0)
remote: Updating branch 'master'.
remote: Updating submodules.
remote: Preparing deployment for commit id 'fb3f0264f8'.
remote: Running custom deployment command...
remote: Running deployment command...
remote: Handling node.js deployment.
remote: Creating app_offline.htm
remote: KuduSync.NET from: 'D:\home\site\repository' to: 'D:\home\site\wwwroot'
remote: Copying file: '.gitignore'
remote: Copying file: 'composer.json'
remote: Copying file: 'composer.lock'
remote: Copying file: 'composer.phar'
remote: Copying file: 'LICENSE'
remote: Copying file: 'README.md'
remote: Copying file: 'public\index.php'
remote: Deleting app_offline.htm
remote: Looking for app.js/server.js under site root.
remote: The package.json file does not specify node.js engine version constraints.
remote: The node.js application will run with the default node.js version 8.11.1.
remote: Selected npm version 5.6.0
remote: Missing server.js/app.js files, web.config is not generated
remote: Loading composer repositories with package information
remote: Installing dependencies (including require-dev) from lock file
remote: Nothing to install or update
remote: Generating autoload files
remote: Finished successfully.
remote: Running post deployment command(s)...
remote: Deployment successful.
To https://azure-basic-starter-4524.scm.azurewebsites.net/azure-basic-starter-4524.git
   04679c2..fb3f026  master -> master
```

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
