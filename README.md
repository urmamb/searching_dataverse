# Searching-dataverse-flutter-web-dockerfile
A demo how to access dataverse storage using Web API's. Setup flutter web and mobile app in docker container 


# Command
## Build the docker image
Use docker build the container image
```
docker build -t searching_dataverse .
```
If you have some problem during cache, you can clean cache by this
```
docker build --no-cache -t searching_dataverse .
```

## After Success building image
Run the docker image with localhost 8081 port.
You can change to any other port just replace it and remember to update redirect url in Azure active directory app authorization menu.
If you want to use your datverse account please change the credentials in .env-development file inside the root directory.
```
docker run -d -p 8081:80 --name searching-dataverse searching_dataverse
```

Here we go, open browser and go to http://localhost:8081/