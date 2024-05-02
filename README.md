## This project implements the Whisper AI models in an easily accessible and simple to use containerized Web App.
## No need to mess with config files and pip dependencies, everything comes packages in a single docker container ready to be used. 

## Check out the project on Docker Hub - [Docker Hub](https://hub.docker.com/repository/docker/asharshith/audio2txtdowload/general)

#***Repository Overview***:

This repository hosts a Flask web application integrated with Audi2Text for speech-to-text functionality, Whisper messaging for secure communication, and a feature for downloading text. The README provides instructions on running the application.

**Docker Hub Overview:**

This Docker image contains the Flask app configured with Audi2Text and Whisper messaging capabilities. It simplifies deployment and offers flexibility for various environments. 

**Why This Image:**
This image provides a convert setup for a  Audi2Text integration using python Flask app and Whisper messaging services enabling easy deployment and utilisation of audio-to-text and secure messaging  and download features.

**Overview:**
This Docker image facilitates the deployment of a Flask app with Audi2Text integration and Whisper messaging, streamlining the process of setting up a web application with advanced functionalities. It serves as a foundation for building speech-to-text enabled applications with secure communication capabilities.


**Getting Started**

These instructions will get you a copy of the project up and running on your local machine and developement server for a development and testing purposes.


**Pre-requisites:**
- Docker installed on the host machine or server 

**Deployment Options:**
- Docker container only 

### How to use this image

The container runs on port 5000, launch and run it using the below command.

```
docker run -d --name=audio2txt -p 5000:5000 hrshith/audio2text-dowload
```
### Browse to http://your-host-ip:5000 to access the web UI

# Building it yourself

You can also build the container locally. Just clone this repository
```
git clone https://github.com/hrshith/audio2text-download.git
```

Then change into the directory
```
cd audio2txt
```

Build the container
```
docker build -t audio2txt-dowload
```

Finally once the container is build you can launch it using the command 
```
docker run -d --name=audio2txt -p 5000:5000 audio2txt-dowload
```

# Additional Notes

## The container runs the base model of Whisper by default, if you want to change it, follow the instructions below. (For future builds I am hoping to incorporate this into the docker run command)

1. Once the container is running, enter it
   ```
   docker exec -it audio2txt-dowload bash
   ```
2. Look for the **text.py** file and open it (You can install and use an editor of your choice I am using nano)
   ```
   nano text.py
   ```
3. You should see the below line
   ```
   # Load the Whisper model
   model = whisper.load_model("base")
   ```
4. Change it to anything you like based on the below table (The .en models are english only)

5. 5. For example if you want to run the medium model your code should look like this.
   ```
   # Load the Whisper model
   model = whisper.load_model("medium")
   ```
6. Just restart the container and upload your audio and it will automatically pull the new model.


**Warning: Higher models require a moderately powerful CPU else it will take forever to load**

|  Size  | Parameters | English-only model | Multilingual model | Required VRAM | Relative speed |
|:------:|:----------:|:------------------:|:------------------:|:-------------:|:--------------:|
|  tiny  |    39 M    |     `tiny.en`      |       `tiny`       |     ~1 GB     |      ~32x      |
|  base  |    74 M    |     `base.en`      |       `base`       |     ~1 GB     |      ~16x      |
| small  |   244 M    |     `small.en`     |      `small`       |     ~2 GB     |      ~6x       |
| medium |   769 M    |    `medium.en`     |      `medium`      |     ~5 GB     |      ~2x       |
| large  |   1550 M   |        N/A         |      `large`       |    ~10 GB     |       1x       |


**Run Docker Image**
```bash

docker run -p 5000:5000 audio2txtdowload

```

**Deployment:**
Access the application at `http://localhost:5000` after running the Docker container. one port - 5000 only 



**Resources:**
- Documentation Link:  https://github.com/openai/whisper/blob/main/README.md

-https://docs.docker.com/guides/


  # Future Plans
- Plans to make the model change accessible during the run command itself to prevent additional work when changing models
- Currently the app is running on the development server, soon I will be moving it to a WSGI server for proper production use
- Beautify the web app further since right now its quite barebones but it does the job!

# Credits
Special credits go to the OpenAI Whisper project which has made this project possible! Check them out at - [Whisper Project](https://github.com/openai/whisper)


**References:**
- **Flask**: https://flask.palletsprojects.com/en/3.0.x/

- **Whisper**: https://github.com/openai/whisper/blob/main/README.md

- **Docker**: https://docs.docker.com/reference/dockerfile


