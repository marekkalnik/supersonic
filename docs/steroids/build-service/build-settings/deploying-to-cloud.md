---
layout: steroids_build
header_title: Deploying to cloud
header_sub_title: Learn how to deploy your app to the AppGyver cloud and share it with others.
section_id: build-settings
subsection_id: deploying-to-cloud
parent_id: steroids
---
<section class="docs-section" id="deploying-to-cloud">

# Deploying your app to the cloud

Deploying your app to the AppGyver cloud has three uses:

1. You can share your work with others.
2. You can create custom builds of your app for testing or submission to the app stores.
3. You can integrate your app with Supersonic data

Deploying to the cloud is very quick and easy and can be done in two ways.

## Deploying via Connect Screen

To deploy your app to the cloud, just go to the "cloud"-tab in the Steroids Connect window and press "Deploy to cloud". The app will be deployed to the cloud, after which you will be presented with a QR code for scanning the cloud version of your app.

## Deploying via the Steroids² CLI

Steroids allows you to deploy your app to the cloud with the command

```bash
$ steroids deploy
```

When you do this, Steroids internally runs the `steroids make` and `steroids package` commands, which updates the contents of the `dist/` folder and creates a .zip package of your app.

Steroids then checks if there is a valid `config/cloud.json` file (JSON with the fields `id` and `hash`). If not, a new `config/cloud.json` file is created with a fresh app ID and hash. If the file exists, Steroids uploads a new version of the app into the cloud, replacing the one previously deployed under that app ID.

Your app is then uploaded to the cloud. A share.appgyver.com site opens, with a QR code for sharing your app. You can see all your previous cloud-deployed ad hoc builds at the [AppGyver Cloud Services][cloud-services] page, view their QR codes and access the share page. The value of the `steroids.config.name` property in `config/application.coffee` becomes your cloud-deployed application's name. To change the name, you need to re-deploy your app.

## App ID and AppGyver account

Each app ID is linked to one AppGyver account. Trying to use `$ steroids deploy` when your account doesn't have access to the app ID defined in `config/cloud.json` results in the deploy failing (even if you have the correct hash).

Thus, if you are working on a shared project, each member needs to have their own `cloud.json` file. (One way to handle this is to create your own `.cloud.json.my_name` file, add it to `.gitignore` and symlink it to `config/cloud.json`.) We are working on a proper team support!

## Sharing your app

After you've deployed your app to the AppGyver cloud you will get access to a special cloud QR, which points to a cloud-based version of your app. That app can be scanned and previewed just like a normal app, but it is not connected to your local development environment, so any new changes you make after the deploy will not update to the cloud app.

To share your progress with your friends or co-workers, click on the "open cloud share page", which will open a new browser tab with the share QR code. Now you can just copy and paste this url to anyone you want to take a look at your app.


[cloud-services]: https://cloud.appgyver.com

</section>

