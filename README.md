# Heedy Plugin Template

This repository offers a template to use when creating a heedy plugin. It sets up a basic plugin structure and build system that simplifies testing and deployment.

## Things to Modify

To customize the template to your needs, first decide:
- What will the plugin name be? The name has no spaces (use underscores or dashes), so `myplugin` is fine, `my plugin` is not. Keep it simple, since it will be used in urls.
- Will the plugin have a frontend component? That is, will it alter the UI shown to users in the browser?
- Will it have a backend server? That is, will the plugin need to do things in the background, even when no users are currently logged in?

Once you have a good idea here, follow these steps:
1) Run `make rename PLUGIN_NAME=myplugin` with `myplugin` replaced with your plugin's name
1) If the plugin does not have a frontend component, delete the `frontend` folder. If the plugin does not have a backend component, delete the `backend` folder.
2) Edit `heedy.conf`:
    - If your plugin does not include a frontend component, remove `frontend = "myplugin/main.js`
    - if your plugin does not include a backend component, remove the entire `run "backend"` clause and remove the `routes= {}` element. If your plugin has a backend server, but doesn't expose an API, delete just the `routes` element.
    - If the plugin does not expose an app/doesn't have a backend server, delete the `app` clause.

## Debugging your Plugin

Once you have adapted the template to your plugin's needs in the previous section, you will want to build the plugin, to make sure things work:

```
make debug
```

If you don't have heedy in `PATH`, and it is not in the current folder, you will have to use: `make debug HEEDY=./location/of/heedy`.
This will create the `dist` folder, where your plugin is prepared for distribution, and a `testdb` folder where a testing heedy database is created.

To test your plugin, you will now run heedy using the database in testdb:

```
heedy run testdb
```

You will be able to log in using the username `test` and password `test`. If everything went well, you will see your plugin in the server configuration,
and enabling it there will succeed.

If something goes wrong, you can try rebuilding your plugin with `make debug`, or if all else fails, run `make clean`, which will clear the testdb folder and the `dist` folder, and try again.

## Building a Release

When you're ready to release your plugin, run:
```
make clear
make
```

The resulting plugin zip file will be in the `dist/` folder.

