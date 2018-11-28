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

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
