# Custom wordpress with docker-compose
This repo contains custom docker-compose and dockerfiles to run wordpress. 

## Common
.env file stores variables to initialize mysql database and is obligatory. 
Before run, you should modify with own values.

## Option 1: Building Images Locally
With file: docker-compose.yml

1. Clone the repository to your local machine.
2. Navigate to the repository's root directory.
3. Run the following commands to build the images and start the containers:<br>
```docker-compose build```<br>
```docker-compose up```

## Option 2: Using Pre-built Images 
With docker-compose-prebuild.yml
This compose uses same images but downloands them from docker-hub.
1. Clone the repository to your local machine.
2. Ensure you're in the repository's root directory where docker-compose-prebuild.yml is located.
3. Run the following command to start the containers using the pre-built images: <br>
```docker-compose -f docker-compose-prebuild.yml up```
