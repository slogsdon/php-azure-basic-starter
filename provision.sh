#!/bin/bash

# Script only needs to run once to create the webapp
# and configure some basic settings

## START CHANGES

SERVICE_PLAN_NAME='Default1'
SERVICE_PLAN_RESOURCE_GROUP_NAME='Default-Web-EastUS'
APP_PHP_VERSION='7.2'
APP_PUBLIC_PATH='\public'

# Optional. Defaults generate values based on
# above/environment

SERVICE_PLAN_ID=$(
  az appservice plan show \
    --name $SERVICE_PLAN_NAME \
    --resource-group $SERVICE_PLAN_RESOURCE_GROUP_NAME \
    --query id \
    --output tsv
  )
RESOURCE_GROUP_NAME=$(basename `pwd`)
RESOURCE_GROUP_LOCATION=$(
  az appservice plan show \
    --name $SERVICE_PLAN_NAME \
    --resource-group $SERVICE_PLAN_RESOURCE_GROUP_NAME \
    --query location \
    --output tsv
  )
APP_NAME="${RESOURCE_GROUP_NAME}-${RANDOM}"

## STOP CHANGES

# Create a resource group.
az group create \
  --name $RESOURCE_GROUP_NAME \
  --location "$RESOURCE_GROUP_LOCATION" \
  > /dev/null 2>&1
echo "Created resource group '$RESOURCE_GROUP_NAME'"

# Create a web app.
az webapp create \
  --name $APP_NAME \
  --resource-group $RESOURCE_GROUP_NAME \
  --plan $SERVICE_PLAN_ID \
  --runtime "PHP|${APP_PHP_VERSION}" \
  > /dev/null 2>&1
echo "Created web app '$APP_NAME'"

# Update document root
az resource update \
  --name web \
  --resource-group $RESOURCE_GROUP_NAME \
  --namespace Microsoft.Web \
  --resource-type config \
  --parent sites/$APP_NAME \
  --set "properties.virtualApplications[0].physicalPath='site\wwwroot${APP_PUBLIC_PATH}'" \
  > /dev/null 2>&1

# Configure local Git and get deployment URL
APP_DEPLOYMENT_URL=$(
  az webapp deployment source config-local-git \
    --name $APP_NAME \
    --resource-group $RESOURCE_GROUP_NAME \
    --query url \
    --output tsv
  )

# Add the Azure remote to your local Git respository
git remote add azure $APP_DEPLOYMENT_URL > /dev/null 2>&1
echo "Added Azure deployment URL as a remote"

APP_URL="https://$APP_NAME.azurewebsites.net"
echo $APP_URL | pbcopy

echo "Copied '$APP_URL' to the system clipboard"
echo "Deploy via:"
echo ""
echo "    git add ."
echo "    git commit -m \"add files\""
echo "    git push -u azure master"
