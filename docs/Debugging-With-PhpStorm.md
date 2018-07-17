
> Credits to the article [Getting xDebug to Work](https://serversforhackers.com/c/getting-xdebug-working)

Open the configuration dialog and add a new **Server** mapping the folder **code** (if you are using the default value 
for the env variable CODE_FOLDER) to the **/var/www* folder in the server.

![image](https://user-images.githubusercontent.com/23129061/41975785-f0fef222-79d8-11e8-96e0-29e215819f27.png)

In case you are wondering why the name **MUST BE** `devsquad-server`, here is the answer

![image](https://user-images.githubusercontent.com/23129061/41975711-b1853926-79d8-11e8-95e6-097e5a31e168.png)

Now, make sure your have the correct IP Address set in your environment

![image](https://user-images.githubusercontent.com/23129061/41976093-5b2b4ef2-79d9-11e8-9c57-9f153630cdca.png)

The IP Address of the host machine is being added to the `/etc/hosts` file in the container as you can see here

![image](https://user-images.githubusercontent.com/23129061/41976163-9b14a824-79d9-11e8-8247-7a31b476a6bb.png)

and here

![image](https://user-images.githubusercontent.com/23129061/41976325-19788dca-79da-11e8-9eef-153617d51e5b.png)

The `dockerhost` is also referenced in the `xdebug.ini` file

![image](https://user-images.githubusercontent.com/23129061/41976250-e574d3d0-79d9-11e8-93a2-d7a0fb3f7ce6.png)

**NOTE:** the `xdebug.remote_connect_back = 0` needs to be 0.

Open the Run/Debug Configurations dialog and add a new entry for **PHP Remote Debug** choosing the `devsquad-server`

![image](https://user-images.githubusercontent.com/23129061/41976514-8da8a266-79da-11e8-8e0f-6b394d1d76ab.png)

Open the section **Debug** int the **Preferences Dialog** and make the necessary changes to meet your needs

![image](https://user-images.githubusercontent.com/23129061/41976862-435cffda-79db-11e8-8b87-7f8e959beac2.png)



